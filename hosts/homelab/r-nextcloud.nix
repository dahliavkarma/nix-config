{
  config,
  lib,
  ...
}:
let
  cfg = config.services.nextcloud;
in
{
  options.services.nextcloud.config = {
    overwriteHost = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "The hostname to be used in generated URLs when behind a trusted proxy.";
    };

    overwriteCondAddr = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "A regular expression to match the IP of the trusted proxy.";
    };

    forwardedForHeaders = lib.mkOption {
      type = lib.types.nullOr (lib.types.listOf lib.types.str);
      default = null;
      description = "The headers to trust from a trusted proxy for determining the remote address.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.nextcloud.settings = lib.mkMerge [
      (lib.mkIf (cfg.config.overwriteHost != null) {
        overwritehost = cfg.config.overwriteHost;
      })
      (lib.mkIf (cfg.config.overwriteCondAddr != null) {
        overwritecondaddr = cfg.config.overwriteCondAddr;
      })
      (lib.mkIf (cfg.config.forwardedForHeaders != null) {
        forwarded_for_headers = cfg.config.forwardedForHeaders;
      })
    ];
  };

}
