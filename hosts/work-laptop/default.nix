{
  ...
}:
{
  imports = [
    ../../common/m-system-darwinComp.nix
    ./m-hm.nix
    ./m-looks.nix
    ./m-shell.nix
    ./m-software.nix
    ./m-work.nix
  ];

  security.pam.services.sudo_local.touchIdAuth = true;
  system = {
    primaryUser = "user";
    defaults = {
      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        CreateDesktop = false;
        FXEnableExtensionChangeWarning = false;
        ShowPathbar = true;
        ShowStatusBar = true;
      };
      dock = {
        autohide = true;
        show-recents = false;
        magnification = true;
        mineffect = "scale";
        tilesize = 50;
        largesize = 64;
      };
    };
  };


}
