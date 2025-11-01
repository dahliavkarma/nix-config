{
  ...
}:
{
  services.actual = {
    enable = true;
    settings = {
      port = 3000; # the default
      hostname = "localhost";
    };
  };
  services.caddy.virtualHosts."actual.silverside-chimera.ts.net" = {
    extraConfig = ''
      tailscale_auth
      reverse_proxy localhost:3000
    '';
  };
}
