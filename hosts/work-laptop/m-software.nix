{
  pkgs,
  ...
}: 
{
  environment.systemPackages = with pkgs; [
    kitty
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
      "raycast"
      "siyuan"
      "ungoogled-chromium"
      "zen"
    ];
    masApps = {
      Bitwarden = 1352778147; # for biometric
    };
    onActivation.cleanup = "zap";
  };
}