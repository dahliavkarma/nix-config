{
  ...
}:
{
  imports = [
    ./m-boot.nix # most everything related to booting the system
    ./m-network.nix
    ./m-region.nix # time, locale, keyboard, etc.
    ./m-secrets.nix # sops-nix related settings
    ./m-system.nix # system utilities and functionalities
    ./m-system-darwinComp.nix # system configuration/tools that are also available on darwin
    ./m-user.nix # user management and home-manager
  ];
}
