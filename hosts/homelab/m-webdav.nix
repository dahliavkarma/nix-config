{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.nextcloud = {
    enable = true;
    hostName = "nextcloud.dahliavkarma.com";
    database.createLocally = true;
    configureRedis = true;
    https = true;
    autoUpdateApps.enable = true;
    config = {
      adminuser = "admin";
      adminpassFile = config.sops.secrets."server/nextcloud/admin-pass".path;
      dbtype = "pgsql";
    };
    settings = {
      overwriteprotocol = "https";
      default_phone_region = "JP";
      log_type = "file";
      loglevel = 1;
    };
    package = pkgs.nextcloud31;
  };

  services.nginx.enable = lib.mkForce false;
  # services.caddy.virtualHosts."https://nextcloud.dahliavkarma.com".extraConfig =
  sops.secrets = {
    "server/nextcloud/admin-pass" = {
      owner = config.users.users.nextcloud.name;
      group = config.users.users.nextcloud.name;
    };
  };
  users.users.nextcloud.extraGroups = [ "users" ];
  systemd.services."nextcloud-setup" = {
    requires = [ "postgresql.service" ];
    after = [ "postgresql.service" ];
  };
}
