{
  # username,
  # config,
  pkgs,
  ...
}:
let
  # 1 s of a 20 Hz tone at -40 dB: inaudible, but not digital silence
  wakeTone = pkgs.runCommand "wake-audio.wav" { nativeBuildInputs = [ pkgs.sox ]; } ''
    sox -n -r 48000 -c 2 -b 16 $out synth 1 sine 20 gain -40
  '';
in
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
  # outputs start out suspended and the monitor stays muted on pure silence, so wake both at login
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
      pw-play ${wakeTone}
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
