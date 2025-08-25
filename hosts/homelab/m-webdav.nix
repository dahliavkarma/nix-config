{
  config,
  pkgs,
  ...
}:
{
  services.nextcloud = {
    enable = true;
    hostName = "dahliavkarma.com";
    database.createLocally = true;
    configureRedis = true;
    https = false;
    autoUpdateApps.enable = true;
    config = {
      adminuser = "admin";
      adminpassFile = config.sops.secrets."server/nextcloud/admin-pass".path;
      dbtype = "pgsql";
    };
    settings = {
      overwriteprotocol = "https";
      default_phone_region = "JP";
    };
    package = pkgs.nextcloud31;
  };
  # services.postgresql = {
  #   enable = true;
  #   ensureUsers = [
  #     {
  #       name = "nextcloud";
  #       ensureDBOwnership = true;
  #       ensureClauses = {
  #         superuser = true;
  #         replication = true;
  #         login = true;
  #         "inherit" = true;
  #         createrole = true;
  #         createdb = true;
  #         bypassrls = true;
  #       };
  #     }
  #   ];
  #   ensureDatabases = [ "nextcloud" ];
  # };
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
