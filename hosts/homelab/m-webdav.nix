{
  config,
  ...
}: {

  users.groups.webdav = {};
  users.users.webdav = {
    isSystemUser = true;
    group = "webdav"; 
  };
  sops.secrets = {
    ### webdav-server-rs
    "server/webdav/.htpasswd" = {
      owner = "webdav";
    };
  };

  services.webdav-server-rs = {
    enable = true; 
    # debug = true;
    settings = {
      server.listen = [ "0.0.0.0:4918" "[::]:4918" ];
      accounts = {
        auth-type = "htpasswd.default";
        acct-type = "unix";
      };
      htpasswd.default = {
        htpasswd = config.sops.secrets."server/webdav/.htpasswd".path;
      };
      location = [
        {
          route = [ "/*path" ];
          directory = "/home/user/webdav"; # DONT SYNCTHING THIS DIR FFS
          handler = "filesystem";
          methods = [ "webdav-rw" ];
          autoindex = true;
          auth = "true";
          case-insensitive = "true"; # case insentive lookups; t/f/"ms"
        }
      ];
    }
    ;
  };

  services.nginx.virtualHosts."dahliavkarma.com".locations."/webdav" = {
    proxyPass = "http://localhost:4918";
  };
  
}