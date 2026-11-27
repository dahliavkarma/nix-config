{
  ...
}:
{
  services.immich = {
    enable = true;
    port = 2283; # the default
  };
  services.borgbackup.jobs.immich = {
    paths = [ "/var/lib/immich" ];
    exclude = [
      "/var/lib/immich/thumbs"
      "/var/lib/immich/encoded-video"
    ];
    repo = "/mnt/backup/immich";
    removableDevice = true;
    encryption.mode = "none";
    environment.BORG_UNKNOWN_UNENCRYPTED_REPO_ACCESS_IS_OK = "yes";
    compression = "auto,zstd";
    startAt = "04:00";
    persistentTimer = true;
    prune.keep = {
      daily = 7;
      weekly = 4;
      monthly = 6;
    };
  };
  systemd.services.borgbackup-job-immich.onFailure = [ "ntfy-failure@%N.service" ];
  services.caddy.virtualHosts."immich.silverside-chimera.ts.net" = {
    extraConfig = ''
      bind tailscale/immich
      tailscale_auth
      reverse_proxy localhost:2283
    '';
  };
}
