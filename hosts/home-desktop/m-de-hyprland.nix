{
  inputs,
  pkgs,
  ...
}:
{

  # to avoid having to rebuild Hyprland AND all its dependencies on every update
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland; # use the flake package
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland; # use the flake package
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    # STEAM_FORCE_DESKTOPUI_SCALING = "2";
  };
}
