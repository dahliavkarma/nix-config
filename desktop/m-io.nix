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
    xorg.xev
    xorg.xinit
    xorg.xrandr
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
    jack.enable = true;
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
    extraConfig = with pkgs; ''
      Defaults:picloud secure_path="${
        lib.makeBinPath [
          systemd
        ]
      }:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
    '';
  };

}
