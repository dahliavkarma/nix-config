{
  hostname,
  inputs,
  pkgs,
  stateVersion,
  username,
  ...
}:
let
  # ssh login keys; for other ssh settings, see m-network.nix and mh-shell.nix
  sshKeys = {
    desktop-yubikey-1 = "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIPcRDK+1ieUpxx7cp/ZXmQlgB0FA+JeD/OBIdRqYEbjLAAAABHNzaDo= desktop-yubikey-1";
    desktop-yubikey-2 = "sk-ecdsa-sha2-nistp256@openssh.com AAAAInNrLWVjZHNhLXNoYTItbmlzdHAyNTZAb3BlbnNzaC5jb20AAAAIbmlzdHAyNTYAAABBBPJK6/hWmBB2qqXhN37W/eKnKyAg2e8nrKDrZzg+IEcta+1IwjYU8BRAo4Pwyqmi36WMj1Fftbb/9YuVAViOzcsAAAAEc3NoOg== desktop-yubikey-2";
    tablet-yubikey-1 = "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAINQC8H/d9tp6XpYpTQgc9YgTiB9OLOTPVeF4rwo+4k5VAAAABHNzaDo= tablet-yubikey-1";
    tablet-yubikey-2 = "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAII1rU6jScYGRIR96bmirsKD8/A24T+V9W5HaOlOoO07lAAAABHNzaDo= tablet-yubikey-2";
  };
  sshAuthorizedFrom = {
    home-desktop = [
      "tablet-yubikey-1"
      "tablet-yubikey-2"
    ];
    homelab = [
      "desktop-yubikey-1"
      "desktop-yubikey-2"
      "tablet-yubikey-1"
      "tablet-yubikey-2"
    ];
  };
in
{

  # user and groups
  users.users.${username} = {
    name = username;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    home = "/home/${username}";
    openssh.authorizedKeys.keys = map (name: sshKeys.${name}) (sshAuthorizedFrom.${hostname} or [ ]);
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
  security.pam.rssh.enable = true;
  security.pam.services.sudo.rssh = true;

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
