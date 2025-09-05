{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.nextcloud;
  fpm = config.services.phpfpm.pools.nextcloud;
  webserver = config.services.caddy;
  phpinfoScript = pkgs.writeTextFile {
    name = "info.php";
    text = "<?php phpinfo();";
  };
  phpinfoDir = pkgs.runCommand "phpinfo-dir" { } ''
    mkdir -p $out
    cp ${phpinfoScript} $out/index.php
  '';
in
{
  services.caddy.virtualHosts."nextcloud-phpinfo.silverside-chimera.ts.net" = {
    extraConfig = ''
      bind tailscale/nextcloud-phpinfo
      tailscale_auth
      root * ${phpinfoDir}
      php_fastcgi unix/${fpm.socket}
      file_server
    '';
  };
  services.nextcloud = {
    enable = true;
    hostName = "nextcloud.silverside-chimera.ts.net";
    database.createLocally = true;
    configureRedis = true;
    https = false;
    # autoUpdateApps.enable = true;
    config = {
      adminuser = "admin";
      adminpassFile = config.sops.secrets."server/nextcloud/admin-pass".path;
      dbtype = "pgsql";
    };
    settings = {
      # overwriteprotocol = "https";
      # default_phone_region = "JP";
      log_type = "file";
      loglevel = 0;
      trusted_domains = [
        "100.121.225.8"
        "nextcloud"
      ];
      trusted_proxies = [
        "100.64.0.0/10"
        "127.0.0.1"
      ];
      # overwritehost = "nextcloud.silverside-chimera.ts.net";
      # overwritecondaddr = "^100\\.";
      # forwarded_for_headers = [ "HTTP_X_FORWARDED_FOR" ];
    };
    package = pkgs.nextcloud31;
  };

  services.nginx.enable = lib.mkForce false;
  services.caddy.virtualHosts."https://nextcloud.silverside-chimera.ts.net/".extraConfig = ''
    bind tailscale/nextcloud
    tailscale_auth
    encode zstd gzip

    root * ${config.services.nginx.virtualHosts.${cfg.hostName}.root}

    redir /.well-known/carddav /remote.php/dav 301
    redir /.well-known/caldav /remote.php/dav 301
    redir /.well-known/* /index.php{uri} 301
    redir /remote/* /remote.php{uri} 301

    header {
      Strict-Transport-Security max-age=31536000
      Permissions-Policy interest-cohort=()
      X-Content-Type-Options nosniff
      X-Frame-Options SAMEORIGIN
      Referrer-Policy no-referrer
      X-XSS-Protection "1; mode=block"
      X-Permitted-Cross-Domain-Policies none
      X-Robots-Tag "noindex, nofollow"
      -X-Powered-By
    }

    php_fastcgi unix/${fpm.socket} {
      root ${config.services.nginx.virtualHosts.${cfg.hostName}.root}
      env front_controller_active true
      env modHeadersAvailable true
    }

    @forbidden {
      path /build/* /tests/* /config/* /lib/* /3rdparty/* /templates/* /data/*
      path /.* /autotest* /occ* /issue* /indie* /db_* /console*
      not path /.well-known/*
    }
    error @forbidden 404

    @immutable {
      path *.css *.js *.mjs *.svg *.gif *.png *.jpg *.ico *.wasm *.tflite
      query v=*
    }
    header @immutable Cache-Control "max-age=15778463, immutable"

    @static {
      path *.css *.js *.mjs *.svg *.gif *.png *.jpg *.ico *.wasm *.tflite
      not query v=*
    }
    header @static Cache-Control "max-age=15778463"

    @woff2 path *.woff2
    header @woff2 Cache-Control "max-age=604800"

    file_server
  '';
  sops.secrets = {
    "server/nextcloud/admin-pass" = {
      owner = config.users.users.nextcloud.name;
      group = config.users.users.nextcloud.name;
    };
  };
  users.users.nextcloud.extraGroups = [ "users" ];
  users.groups.nextcloud.members = [
    "nextcloud"
    webserver.user
  ];
  services.phpfpm.pools.nextcloud.settings = {
    "listen.owner" = webserver.user;
    "listen.group" = webserver.group;
    "php_admin_value[open_basedir]" = lib.mkForce "${
      config.services.nginx.virtualHosts.${cfg.hostName}.root
    }:${cfg.package}:/var/lib/nextcloud:/tmp:${phpinfoDir}";
  };
  systemd.services."nextcloud-setup" = {
    requires = [ "postgresql.service" ];
    after = [ "postgresql.service" ];
  };
}
