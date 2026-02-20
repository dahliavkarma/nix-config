{
  inputs, 
  username, 
  lib, 
  ...
}: 
{
  home-manager = {
    extraSpecialArgs = { inherit inputs; }; # will work on this, and the arguments at the top too
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-bak";
    users.${username} = (import ./home.nix { }) // {
      home = {
        stateVersion = "25.05";
        inherit username;
        homeDirectory = lib.mkForce "/Users/${username}";
      };
    };
  };
}