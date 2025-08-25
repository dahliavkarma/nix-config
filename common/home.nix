{
  inputs,
  pkgs,
  ...
}:
{

  # installations & configurations
  imports = [
    inputs.nvf.homeManagerModules.default
    ./mh-shell.nix
    ./mh-syncthing.nix
    ./mh-vim.nix
  ];
  home.packages = with pkgs; [
    aria2
    btop
    exercism
    neofetch
    yazi
  ];

  programs.gh = {
    enable = true;
  };

  # static settings
  xdg.enable = true; # enable management of XDG base dirs
  # home = {
  #   inherit username;
  #   homeDirectory = "/home/${username}";
  # };

}
