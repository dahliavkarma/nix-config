{
  config,
  ...
}:
{
  services.xray = {
    enable = true;
    settingsFile = config.sops.secrets."server/xray/config".path;
  };
  services.nginx.virtualHosts."dahliavkarma.com".locations."/smallcylinder" = {
    proxyPass = "http://127.0.0.1:10000";
    proxyWebsockets = true;
  };
  sops.secrets = {
    "server/xray/config" = {
      restartUnits = [ "xray.service" ];
    };
  };
}
