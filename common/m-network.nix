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
  services.syncthing = {
    enable = true;
    dataDir = "/home/${username}";
    configDir = "/home/${username}/.config/syncthing";
    openDefaultPorts = true; # ports for decovery
    user = username;
    group = "users";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "homelab" = {
          id = "GLWVF5J-3FE5JUT-JHTXLHZ-ZI4SIOR-VOEF3TZ-24GROC2-QJQTBEF-3LPFGQY";
        };
        "home-desktop" = {
          id = "244B3EN-C6YUHO4-LWXDAQ4-YIFSLQT-WXZWJH7-MCXRRH3-WMPX4QP-3ED3SAH";
        };
        "laptop" = {
          id = "E27OWAN-CM7XOCF-6NHB6CR-PCHYUXG-YGHADF5-A3DU5WF-KIGMTPG-2J54AQM";
        };
        "DESKTOP-P0I9JS1" = {
          id = "QEMI2RI-XEP3MDA-HNZEZY2-SGAXMVL-PN3SRLG-TH2JVV6-W6444BS-FNR53QK";
        }; # work desktop
        "phone-p" = {
          id = "MUMNSZI-VHU3UXC-5MTJVSD-66ZXKQA-5HUZFBT-PJKY34O-VTD4Y2X-SH4QPQB";
        };
      };
      folders = {
        # DONT SYNTHING SIYUAN DIR FFS
        "nix-config" = {
          path = "/home/${username}/nix-config";
          devices = [
            "home-desktop"
            "homelab"
            "laptop"
          ];
        };
        "pictures" = {
          path = "/home/${username}/Pictures";
          devices = [
            "home-desktop"
            "homelab"
            "laptop"
          ];
        };
        "documents" = {
          path = "/home/${username}/Documents";
          devices = [
            "home-desktop"
            "homelab"
            "laptop"
            "DESKTOP-P0I9JS1"
          ];
        };
        "library" = {
          path = "/home/${username}/Library";
          devices = [
            "home-desktop"
            "homelab"
            "laptop"
            "DESKTOP-P0I9JS1"
          ];
        };
        "bitburner" = {
          path = "/home/${username}/.config/bitburner/saves";
          devices = [
            "home-desktop"
            "homelab"
            "laptop"
          ];
        };
        #   "obsidian" = {
        #     path = "/home/${commonSettings.user.username}/Obsidian";
        #     devices = [ "home-desktop" "home-server" "laptop" "phone-p" "DESKTOP-P0I9JS1" ];
        #   };
      };
    };
  };

  services.mullvad-vpn = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    mullvad-closest
  ];

}
