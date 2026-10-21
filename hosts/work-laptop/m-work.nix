{
  ...
}:
{

  homebrew = {
    taps = [
      "k1LoW/tap"
    ];
    brews = [
      "k1LoW/tap/mo"
    ];
    casks = [
      "azure-data-studio"
      "cursor"
      "dbeaver-community"
      "docker-desktop"
      "firefox"
      "insomnia"
      "intellij-idea-ce"
      "linear-linear"
      "microsoft-azure-storage-explorer"
      "postman"
      "sourcetree"
      "visual-studio-code"

      "discord"
      "google-chrome"
      "intune-company-portal"
      "microsoft-office"
      "microsoft-teams"
      "notion"
      "python"
      "slack"
      "zoom"
    ];
    masApps = {
      "Azure VPN Client" = 1553936137;
    };
  };

  # environment.systemPackages = with pkgs; [
  #   azure-cli
  # ];

}
