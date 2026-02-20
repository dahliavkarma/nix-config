{
  pkgs,
  ...
}: 
{
  environment.systemPackages = with pkgs; [
    localsend
    vscodium
  ];

  homebrew = {
    enable = true;
    greedyCasks = true;
#    brews = [
#      "mpv"
#    ];
    casks = [
      "iina"
      "karabiner-elements"
      "kate"
      "kitty"
      "nextcloud"
      "raycast"
      "siyuan"
      "tailscale"
      "ungoogled-chromium"
      "zotero"
    ];
    masApps = {
      Bitwarden = 1352778147; # for biometrics
    };
    onActivation.cleanup = "zap";
  };
}