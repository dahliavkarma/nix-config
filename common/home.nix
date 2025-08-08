{  
  stateVersion,
  username,
  inputs, 
  config, 
  pkgs,
  ...
}: {
  
  # installations & configurations
  imports = [
    ./mh-shell.nix
  ];
  home.packages = with pkgs; [
    aria
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
  #   inherit stateVersion;
  #   inherit username;
  #   homeDirectory = "/home/${username}";
  # };

}