{
  ...
}:
{
  imports = [
    ../../common
    ./m-boot.nix
    # ./m-container.nix
    ./m-server.nix
    ./m-v2ray.nix
    ./m-webdav.nix
  ];
  programs.starship.presets = [ "no-nerd-font" ];
}
