{
  pkgs,
  ...
}:
{
  imports = [
    ./mh-browser.nix
    ./mh-kde.nix
    ./mh-looks.nix
    ./mh-shell.nix
  ];
  home.packages = with pkgs; [
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
  ];
  services.copyq = {
    enable = true;
    forceXWayland = false;
  };
}
