{
  hostname,
  username,
  lib,
  pkgs,
  ...
}:
{

  networking.hostName = hostname;
  networking.useDHCP = lib.mkDefault true;

  # nm
  networking.networkmanager.enable = true;
  users.users.${username}.extraGroups = [ "networkmanager" ];

  # dns
  services.resolved = {
    enable = true;
    #  dnsovertls = "true";
  };
  networking.nameservers = [
    "45.90.28.0#2cc1cb.dns.nextdns.io"
    "a207:28c0::#2cc1cb.dns.nextdns.io"
  ];

  # ssh daemon
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    knownHosts = {
      # for authorized keys of the user, see m-user.nix and mh-shell.nix
      homelab = {
        extraHostNames = [ "192.168.0.52" ];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2PYN1SuNVtgpuCtzs2zLIhoXfyIW2qILFnq8wn6X/F";
      };
      home-desktop = {
        extraHostNames = [ "192.158.0.50" ];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAr+xkRalWCwJ0mYJrQGFBLGzBuWKMwYjSwwOg+6DT//";
      };
      laptop = {
        extraHostNames = [ "192.168.0.41" ];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBLx+Os6fExGO8/PYzukTsuyLJOnADgO6YTjS76oFmHg";
      };
    };
  };
  services.fail2ban = {
    enable = true;
    maxretry = 10;
    ignoreIP = [ "192.168.0.0/16" ];
  };
  programs.ssh.startAgent = true;

  # Syncthing
  networking.firewall.allowedTCPPorts = [ 8384 ]; # port for webui

  services.mullvad-vpn = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    mullvad-closest
  ];

}
