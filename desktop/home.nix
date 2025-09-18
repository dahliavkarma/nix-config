{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./mh-dev.nix
    ./mh-looks.nix
    ./mh-shell.nix
    ./mh-ocr.nix
    # ./mh-work.nix
  ];
  home.packages =
    with pkgs;
    [
      # anki
      calibre
      discord
      ffmpeg
      gimp
      kdePackages.kate
      kdePackages.okular
      krita
      libreoffice
      motrix
      mpv
      musescore
      nextcloud-client
      scantailor-advanced
      siyuan
      telegram-desktop
      thunderbird
      tor-browser
      tuxguitar
      vscodium # remember to install Nix IDE and Catppuccin Icons
      yt-dlp
      zotero
    ]
    ++ (with inputs; [
      zen-browser.packages.${pkgs.system}.default
    ]);
  programs.chromium = {
    # since chrome is needed from time to time
    enable = true;
    extensions = [
      # doesn't work just yet
      "gcbommkclmclpchllfjekcdonpmejbdp" # https everywhere
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
    ];
  };
  services.copyq = {
    enable = true;
    forceXWayland = false;
  };
}
