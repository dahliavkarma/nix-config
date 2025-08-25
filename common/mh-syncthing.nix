{
  config,
  ...
}:
let
  username = config.home.username;
in
{
  services.syncthing = {
    enable = true;
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
        # "zotero" = {
        #   path = "/home/${username}/Zotero";
        #   devices = [
        #     "home-desktop"
        #     "homelab"
        #     "laptop"
        #   ];
        # };
        #   "obsidian" = {
        #     path = "/home/${commonSettings.user.username}/Obsidian";
        #     devices = [ "home-desktop" "home-server" "laptop" "phone-p" "DESKTOP-P0I9JS1" ];
        #   };
      };
    };
  };
}
