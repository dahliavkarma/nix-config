{
  config,
  pkgs,
  ...
}:
{
  sops.secrets."server/tailscale/authkey" = {
    owner = config.services.caddy.user;
    group = config.services.caddy.group;
    mode = "600";
  };
  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/tailscale/caddy-tailscale@v0.0.0-20260826180304-de41b249af4f" ];
      hash = "sha256-UTpKsbriOMTfgG36Y1VL1hPQUNhJzPmTyMUXi0WycAA=";
    };
    enableReload = false; # the plugin can't reload, so restart instead
    # acmeCA = "https://acme-v02.api.letsencrypt.org/directory"; # for dev/testing; comment out for production
    # email = "dahliavkarma@gmail.com";
    environmentFile = config.sops.secrets."server/tailscale/authkey".path;
  };
  # services.cloudflared = {
  #   enable = true;
  #   tunnels = {
  #     "cddde6ed-858d-4d20-87cf-cf7efca9eb61" = {
  #       credentialsFile = config.sops.secrets."server/cloudflared/tunnel-content".path;
  #       ingress = {
  #         "dahliavkarma.com" = {
  #           service = "https://localhost:443";
  #         };
  #       };
  #       default = "http_status:404";
  #       originRequest.noTLSVerify = true;
  #     };
  #   };
  # };
}
