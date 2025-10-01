{
  ...
}:
{
  boot.initrd.systemd.enable = true;
  boot.initrd.availableKernelModules = [
    "nvme"
    "sd_mod"
    "thunderbolt"
    "usb_storage"
    "xhci_pci"
  ];
  boot.initrd.kernelModules = [
    "nls_cp437"
    "nls_iso8859-1"
    "usbhid"
    "vfat"
  ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/11e295b9-f23a-445a-8123-1c455b917b3f";
    fsType = "ext4";
  };

  boot.initrd.luks = {
    devices = {
      "luks-bee7a3e8-59fe-41d4-98e1-2ea37f990a9d" = {
        device = "/dev/disk/by-uuid/bee7a3e8-59fe-41d4-98e1-2ea37f990a9d";
        preLVM = true;
        crypttabExtraOpts = [ "fido2-device=auto" ];
      };
      "luks-0b7fcd27-5161-4d34-b98c-4c470ec65511" = {
        device = "/dev/disk/by-uuid/0b7fcd27-5161-4d34-b98c-4c470ec65511";
        preLVM = true;
        crypttabExtraOpts = [ "fido2-device=auto" ];
      };
    };
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D687-7C0C";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/c81f071b-1650-40a6-92c0-088efa6f6325"; } ];
}
