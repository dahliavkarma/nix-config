{
  config,
  pkgs,
  ...
}:
{

  environment.systemPackages = with pkgs; [
    cloudflared # services.cloudflared enabled below does not install the binary
  ];
  sops.secrets = {
    "server/cloudflared/tunnel-content" = { };
    "server/cloudflared/cert.pem" = {
      path = "/home/user/.config/cloudflared/cert.pem";
    };
  };

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts."dahliavkarma.com" = {
      enableACME = true;
      forceSSL = true;
    };
    virtualHosts."nextcloud.dahliavkarma.com" = { };
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "dahliavkarma@gmail.com";
  };
  services.cloudflared = {
    enable = true;
    tunnels = {
      "cddde6ed-858d-4d20-87cf-cf7efca9eb61" = {
        credentialsFile = config.sops.secrets."server/cloudflared/tunnel-content".path;
        ingress = {
          "dahliavkarma.com" = {
            service = "https://localhost:443";
          };
        };
        default = "http_status:404";
        originRequest.noTLSVerify = true;
      };
    };
  };
}
