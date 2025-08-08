{
  username, 
  ...
}: {
  
  virtualisation.docker = {
    enable = true;
    # daemon.settings =  = {

    # };
  };

  users.users.${username}.extraGroups = [ "docker" ];

}