{
  inputs,
  pkgs,
  ...
}:
{

  # installations & configurations
  imports = [
    inputs.nvf.homeManagerModules.default
    inputs.zen-browser.homeModules.beta
    inputs.plasma-manager.homeModules.plasma-manager
    ./mh-shell.nix
    ./mh-vim.nix
  ];
  home.packages = with pkgs; [
    aria2
    btop
    exercism
    fastfetch
    gdu
    nix-tree
    yazi
  ];

  programs.gh = {
    enable = true;
  };

  # static settings
  xdg.enable = true; # enable management of XDG base dirs

}
