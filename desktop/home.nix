{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./mh-looks.nix
    ./mh-shell.nix
    # ./mh-work.nix
  ];
  home.packages =
    with pkgs;
    [
      # anki
      discord
      ffmpeg
      gimp
      krita
      motrix
      mpv
      musescore
      ncdu
      nextcloud-client
      siyuan
      tor-browser
      vscodium # remember to install Nix IDE and Catppuccin Icons
      yt-dlp
      yubioath-flutter
      yubikey-manager
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
