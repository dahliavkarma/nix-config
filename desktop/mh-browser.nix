{
  inputs,
  pkgs,
  ...
}:
{
  # home.sessionVariables.MOZ_LEGACY_PROFILES = 1;
  programs.zen-browser = {
    enable = true;

    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = false;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };

    profiles."default" =
      let
        spaces = {
          "Default" = {
            id = "ccb9f6ed-24c4-499a-b5b2-e3e5d52fbad5";
            icon = "";
            position = 1000;
          };
        };
        pins = {
        };
      in
      {
        id = 0;
        isDefault = true;
        extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          bitwarden
        ];
      };
  };
}
