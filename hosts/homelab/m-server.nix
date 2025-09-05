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
    package = pkgs.callPackage ./r-caddy-tailscale.nix { };
    acmeCA = "https://acme-v02.api.letsencrypt.org/directory"; # for dev/testing; comment out for production
    email = "dahliavkarma@gmail.com";
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
