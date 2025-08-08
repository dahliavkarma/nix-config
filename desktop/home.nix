{
  inputs,
  pkgs, 
  ...
}: {
  imports = [
    ./mh-dev.nix
    ./mh-looks.nix
    ./mh-shell.nix
    ./mh-ocr.nix
    # ./mh-work.nix
  ];
  home.packages = with pkgs; [
    anki
    calibre
    discord
    ffmpeg
    # gimp
    heroic
    kdePackages.kate
    kdePackages.okular
    krita
    libreoffice
    motrix
    musescore
    scantailor-advanced
    siyuan
    telegram-desktop
    thunderbird
    tor-browser
    tuxguitar
    vscodium # remember to install Nix IDE, Catppuccin Icons, and the vsix file
    yt-dlp
    zotero
  ] ++ (with inputs; [
    zen-browser.packages.${pkgs.system}.default
  ]);
  programs.chromium = { # since chrome is needed from time to time
    enable = true;
    package = pkgs.ungoogled-chromium;
    extensions = [ # doesn't work just yet
      "gcbommkclmclpchllfjekcdonpmejbdp" # https everywhere
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
    ];
  };
  services.copyq = {
    enable = true;
    forceXWayland = false;
  };
}