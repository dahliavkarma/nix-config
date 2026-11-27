{
  ...
}:
{
  imports = [
    ../../common
    ./m-boot.nix
    ./m-container.nix
    ./m-lute.nix
    ./m-photos.nix
    ./m-server.nix
    # ./m-v2ray.nix
    ./m-webdav.nix
  ];
  programs.starship.presets = [ "no-nerd-font" ];

  security.sudo.extraConfig = ''
    Defaults timestamp_timeout=-1
  '';
}
