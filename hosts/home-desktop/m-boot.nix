{
  ...
}:
{

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.kernelParams = [ "amdgpu.sg_display=0" ]; # may or may not solve screen flickering
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/3f70d35f-95fa-4d3d-a870-0a476264a063";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/6030-8A58";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/02403e27-122d-46e0-b507-eca920abec5e"; }
  ];

  security.tpm2.enable = false;

}
