{
  ...
}:
{
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "nvme"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/11e295b9-f23a-445a-8123-1c455b917b3f";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-bee7a3e8-59fe-41d4-98e1-2ea37f990a9d".device =
    "/dev/disk/by-uuid/bee7a3e8-59fe-41d4-98e1-2ea37f990a9d";
  boot.initrd.luks.devices."luks-0b7fcd27-5161-4d34-b98c-4c470ec65511".device =
    "/dev/disk/by-uuid/0b7fcd27-5161-4d34-b98c-4c470ec65511";

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
