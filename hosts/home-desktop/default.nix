{
  ...
}:
{
  imports = [
    ../../common
    ../../desktop
    ./m-boot.nix
    ./m-de-components.nix
    ./m-de-hyprland.nix
    ./mh-dev.nix
    ./mh-gaming.nix
    ./m-guitar.nix
    ./m-remap.nix
  ];
  environment.sessionVariables.MU_QT_QPA_PLATFORM = "wayland"; # for musescore to run in Wayland with native HiDPI support;
  environment.sessionVariables.QT_QPA_PLATFORM = "wayland"; # for musescore to run in Wayland with native HiDPI support;
  hardware.bluetooth.enable = true;
}
