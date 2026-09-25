{
  username,
  ...
}:
{
  virtualisation.oci-containers.containers."lute-container" = {
    image = "jzohrab/lute3:latest";
    ports = [ "5001:5001" ];
    volumes = [
      "/home/${username}/lute/data:/lute_data"
      "/mnt/backup/lute:/lute_backup"
    ];
  };

  services.caddy.virtualHosts = {
    "lute.silverside-chimera.ts.net" = {
      extraConfig = ''
        bind tailscale/lute
        tailscale_auth
        reverse_proxy localhost:5001
      '';
    };
  };
}
