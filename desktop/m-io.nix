{
  # username,
  # config,
  pkgs,
  ...
}:
{

  # enable the X11 windowing system, needed for wayland too
  services.xserver = {
    enable = true;
    excludePackages = with pkgs; [
      xterm
    ];
  };
  environment.systemPackages = with pkgs; [
    # some utilities
    xev
    xinit
    xrandr
  ];

  # configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "compose:ralt"; # compose key setting
  };

  # enable CUPS to print documents
  services.printing.enable = true;

  # sound
  hardware.alsa.enablePersistence = true;
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # never suspend outputs: an HDMI monitor takes a moment to wake up and swallows short sounds like bells
    wireplumber.extraConfig."51-no-suspend"."monitor.alsa.rules" = [
      {
        matches = [ { "node.name" = "~alsa_output.*"; } ];
        actions.update-props."session.suspend-timeout-seconds" = 0;
      }
    ];
  };
  # outputs still start out suspended, so wake them once with half a second of silence
  systemd.user.services.wake-audio-output = {
    description = "Wake audio outputs so the first short sound is not swallowed";
    after = [ "wireplumber.service" ];
    partOf = [ "wireplumber.service" ];
    wantedBy = [ "wireplumber.service" ];
    path = with pkgs; [
      coreutils
      pipewire
      wireplumber
    ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      for _ in $(seq 30); do
        wpctl inspect @DEFAULT_AUDIO_SINK@ > /dev/null 2>&1 && break
        sleep 1
      done
      head -c 96000 /dev/zero | pw-play --raw -
    '';
  };

  security.sudo = {
    # enable passwordless power controls
    extraRules = [
      {
        commands = [
          {
            command = "${pkgs.systemd}/bin/systemctl suspend";
            options = [ "NOPASSWD" ];
          }
          {
            command = "${pkgs.systemd}/bin/reboot";
            options = [ "NOPASSWD" ];
          }
          {
            command = "${pkgs.systemd}/bin/poweroff";
            options = [ "NOPASSWD" ];
          }
        ];
        groups = [ "wheel" ];
      }
    ];
  };

}
