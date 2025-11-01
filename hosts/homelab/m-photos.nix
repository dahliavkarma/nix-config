{
  ...
}:
{
  services.immich = {
    enable = true;
    port = 2283; # the default
  };
  services.caddy.virtualHosts."immich.silverside-chimera.ts.net" = {
    extraConfig = ''
      tailscale_auth
      reverse_proxy localhost:2283
    '';
  };
}
