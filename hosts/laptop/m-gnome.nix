{
  pkgs,
  ...
}:
{
  services = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    xserver = {
      excludePackages = [ pkgs.xterm ];
    };
    gnome.gcr-ssh-agent.enable = false;
  };
  programs.dconf = {
    enable = true;
  };
  environment.gnome.excludePackages =
    (with pkgs; [
      # comment to install, uncomment to uninstall
      # baobab # disk analyzer
      epiphany # gnome web browser
      # evince # gnome document viewer, tied to thumbnail generation
      geary # gnome mail client
      gnome-backgrounds # default wallpapers
      # gnome-bluetooth # keeping around just in case
      gnome-calculator
      gnome-calendar
      gnome-characters
      gnome-clocks
      gnome-color-manager
      gnome-connections # gnome remote desktop
      gnome-console
      gnome-contacts
      # gnome-control-center
      # gnome-disk-utility
      # gnome-font-viewer
      # gnome-logs
      gnome-maps
      gnome-music
      # gnome-shell-extensions
      gnome-system-monitor
      # gnome-text-editor
      gnome-tour
      gnome-user-docs
      gnome-weather
      # loupe # gnome image viewer, rust-driven
      orca # gnome screen reader
      seahorse # secret management in gnome-keyring
      simple-scan
      # snapshot # gnome camera
      yelp # gnome help viewer
    ])
    ++ (with pkgs.gnome; [
      # adwaita-icon-theme # exclude after icon settings are done
      # file-roller # gnome archive utility
      # gucharmap # gnome character map (not the utility gnome-character), no need to exclude
      # nautilus # gnome file manager, no need to exclude
      # sushi # gnome quick previewer
      # totem # gnome videos, tied to thumbnail generation
      # nixos-background-info # ???
    ]);
  environment.systemPackages = with pkgs; [
    gnome-tweaks
  ];
}
