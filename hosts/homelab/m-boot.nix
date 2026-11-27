{
  config,
  pkgs,
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
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [ "fbcon=rotate:3" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/e3b4a18f-456c-4574-a039-6777117330bb";
    fsType = "btrfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/0158-6F1A";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  fileSystems."/mnt/backup" = {
    device = "/dev/disk/by-uuid/a60cf7c2-3696-4938-9621-457675ba2a0f";
    fsType = "btrfs";
    options = [ "nofail" ];
  };

  sops.secrets."server/ntfy/topic" = { };
  systemd.services.backup-disk-check = {
    after = [
      "mnt-backup.mount"
      "network-online.target"
    ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    startAt = "daily";
    serviceConfig.Type = "oneshot";
    path = with pkgs; [
      btrfs-progs
      curl
      util-linux
    ];
    script = ''
      if ! mountpoint -q /mnt/backup; then
        problem="Backup disk is not mounted at /mnt/backup. Lute is stopped until it is."
      elif ! btrfs device stats --check /mnt/backup > /dev/null; then
        problem="Backup disk reports errors: $(btrfs device stats /mnt/backup | grep -v ' 0$')
      Once dealt with, clear the counters or this repeats daily: sudo btrfs device stats -z /mnt/backup"
      else
        exit 0
      fi
      curl -fsS --retry 10 --retry-all-errors --retry-delay 30 \
        -H "Title: homelab backup disk" -H "Priority: high" -H "Tags: warning" \
        -d "$problem" "https://ntfy.sh/$(cat ${config.sops.secrets."server/ntfy/topic".path})"
      exit 1
    '';
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/8668b273-5af8-4783-bee4-a6467063afc1"; }
  ];
}
