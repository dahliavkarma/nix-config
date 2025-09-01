{
  lib,
  ...
}:
{
  programs.kitty = {
    font = {
      size = lib.mkForce 13.5;
      name = "Sarasa Mono SC"; # has to be defined when a size is present
    };
    extraConfig = ''
      linux_display_server x11
    '';
  };
}
