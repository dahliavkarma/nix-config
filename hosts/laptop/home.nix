{
  ...
}: {
  imports = [
    ../../common/home.nix
    ../../desktop/home.nix
    ./mh-gnome.nix
  ];
  programs.kitty = {
    font = {
      size = 13.5;
      name = "Sarasa Mono SC"; # has to be defined when a size is present
    };
    extraConfig = ''
      linux_display_server x11
    '';
  };
}