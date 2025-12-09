{
  pkgs,
  username,
  ...
}:
{

  homebrew = {
    casks = [
      "azure-data-studio"
      "dbeaver-community"
      "docker-desktop"
      "insomnia"
      "intellij-idea-ce"
      "visual-studio-code"

      "discord"
      "google-chrome"
      "intune-company-portal"
      "microsoft-office"
      "microsoft-teams"
      "notion"
      "slack"
      "zoom"
    ];
    masApps = {
      "Azure VPN Client" = 1553936137;
    };
  };

  environment.systemPackages = with pkgs; [
    azure-cli
  ];

}
