{
  username,
  ...
}:
{

  homebrew.casks = [
    "intellij-idea-ce"
    "intune-company-portal"
    "azure-data-studio"
    "dbeaver-community"
    "dbeaver-community"
    "microsoft-office"
    "notion"
  ];

  virtualisation.docker = {
    enable = true;
    # daemon.settings =  = {

    # };
  };

  users.users.${username}.extraGroups = [ "docker" ];

}
