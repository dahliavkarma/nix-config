{
  hostname,
  inputs,
  pkgs,
  stateVersion,
  username,
  ...
}:
{

  # user and groups
  users.users.${username} = {
    name = username;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    home = "/home/${username}";
    openssh.authorizedKeys.keys = [
      # ssh login keys; for other ssh settings, see m-network.nix and mh-shell.nix
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPEMK4Kys6A3fzzJIyQ9yQWC+obkrbvonksO0CXrYswc home-desktop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMFSjy+wxbw/FQcivZkoHW61GB7gCufW4HAo0Gsv79rP homelab"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDPb/SePBsIOqh5q77K8kitFsVRN4DV9vcDPT5f0T6KP tablet"
    ];
  };
  nix.settings.allowed-users = [ "@wheel" ];
  security.sudo.execWheelOnly = true;
  security.sudo.extraConfig =
    let
      bell = builtins.fromJSON ''"\u0007"''; # nix strings have no \a escape
    in
    ''
      # ring the terminal bell when asking for a password, so a forgotten prompt in a background window gets noticed
      Defaults passprompt="${bell}[sudo] password for %p: "
      # never time out the password prompt (default is 5 minutes)
      Defaults passwd_timeout=0
    '';
  security.pam.sshAgentAuth.enable = true;

  # yubikey login (pam_u2f)
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };
  services.pcscd.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];

  # Home Manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; }; # will work on this, and the arguments at the top too
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-bak";
    users.${username} = (import ../hosts/${hostname}/home.nix { }) // {
      home = {
        inherit stateVersion;
        inherit username;
        homeDirectory = "/home/${username}";
      };
    };
  };

}
