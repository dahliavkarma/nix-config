{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./mh-looks.nix
    ./mh-shell.nix
  ];
  home.packages =
    with pkgs;
    [
      # anki
      discord
      ffmpeg
      gimp
      google-chrome
      krita
      motrix
      mpv
      musescore
      nextcloud-client
      # siyuan
      tor-browser
      vscodium # remember to install Nix IDE and Catppuccin Icons
      yt-dlp
      zoom-us
    ]
    ++ (with inputs; [
      zen-browser.packages.${pkgs.system}.default
    ]);
  services.copyq = {
    enable = true;
    forceXWayland = false;
  };
}
