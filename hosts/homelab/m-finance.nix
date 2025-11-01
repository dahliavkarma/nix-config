{
  ...
}:
{
  services.immich = {
    enable = true;
    port = 3000; # the default
    settings.hostname = "localhost";
  };
  services.caddy.virtualHosts."actual.silverside-chimera.ts.net" = {
    extraConfig = ''
      bind tailscale/actual
      tailscale_auth
      reverse_proxy localhost:3000
    '';
  };
}
