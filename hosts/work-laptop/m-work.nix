{
  pkgs,
  username,
  ...
}:
{

  homebrew = {
    casks = [
      "azure-data-studio"
      "cursor"
      "dbeaver-community"
      "docker-desktop"
      "insomnia"
      "intellij-idea-ce"
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
