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
          "Languages" = {
            id = "feb836e4-5f46-4e47-99b2-4ebf72cedb77";
            position = 2000;
            icon = "🗣️";
          };
          "Studies" = {
            id = "de7554b3-7bbb-4fbe-ba37-a54abdcc3aa6";
            position = 3000;
            icon = "📚";
          };
        };
        pins = {
          "Gemini" = {
            id = "942a1aab-d8ad-4495-83d5-6ca182797bc1";
            url = "https://gemini.google.com/app";
            isEssential = true;
            position = 001;
          };
          "MyNixOS" = {
            id = "4dd46e95-757d-4ecd-a389-d92e26bcc161";
            url = "https://mynixos.com/";
            isEssential = false;
            position = 101;
            workspace = spaces.Default.id;
          };
          "Hebrew" = {
            id = "d85a9026-1458-4db6-b115-346746bcc692";
            workspace = spaces.Languages.id;
            isGroup = true;
            isFolderCollapsed = false;
            editedTitle = true;
            position = 210;
          };
          "Aleph with Beth playlist" = {
            id = "2eed5614-3896-41a1-9d0a-a3283985359b";
            workspace = spaces.Languages.id;
            folderParentId = pins.Hebrew.id;
            url = "https://www.youtube.com/playlist?list=PLq1vmb-z7PpQt2PDNUr7XOzBjWAOWf0Rt";
            position = 211;
          };
          "Aleph with Beth resources" = {
            id = "d1b9db07-472c-4337-a7da-0b3ba13c1bed";
            workspace = spaces.Languages.id;
            folderParentId = pins.Hebrew.id;
            url = "https://freehebrew.online/resources/";
            position = 212;
          };
          "German" = {
            id = "852aa8ee-4996-42d2-82eb-52a0242ed66f";
            workspace = spaces.Languages.id;
            isGroup = true;
            isFolderCollapsed = false;
            editedTitle = true;
            position = 220;
          };
          "German Moments" = {
            id = "0684b399-0295-40f6-a0d4-1ee801fdc39e";
            workspace = spaces.Languages.id;
            folderParentId = pins.German.id;
            url = "https://www.youtube.com/playlist?list=PLNpY_mXFs9W0O0m_7GTxHX4cnnRUcNzTv";
            position = 221;
          };
          "Natürlich German" = {
            id = "3f3f0c59-162e-4ca3-877d-b902de1529c3";
            workspace = spaces.Languages.id;
            folderParentId = pins.German.id;
            url = "https://www.youtube.com/playlist?list=PL_VCREGnvRpdRDfHe57eFqZQz9P5v-pyB";
            position = 222;
          };
          "ALG German" = {
            id = "600d5e6d-7a84-4abe-ac24-6fa026311185";
            workspace = spaces.Languages.id;
            folderParentId = pins.German.id;
            url = "https://www.youtube.com/playlist?list=PLkbzqJ1OxlmolGMa1A9EVj8cN3tnVFiGw";
            position = 223;
          };
          "Extra auf Deutsch" = {
            id = "7068e7ea-ddd2-4635-ba2d-97cd0ad41baa";
            workspace = spaces.Languages.id;
            folderParentId = pins.German.id;
            url = "https://www.youtube.com/playlist?list=PLM45RE_YsqS5-S58HSmYOhu2m-tRul9jW";
            position = 224;
          };
          "Nicos Weg" = {
            id = "600d5e6d-7a84-4abe-ac24-6fa026311185";
            workspace = spaces.Languages.id;
            folderParentId = pins.German.id;
            url = "https://www.youtube.com/playlist?list=PLs7zUO7VPyJ7n29SeiN1tK4Z-Alh1WHyM";
            position = 225;
          };
          "BBC Deutsch Direkt" = {
            id = "36862b06-6916-431e-be0b-6a5ee2d06131";
            workspace = spaces.Languages.id;
            folderParentId = pins.German.id;
            url = "https://www.youtube.com/playlist?list=PLt6NoCieiwOxD7wNZMa79LrKeJ3yJInRT";
            position = 226;
          };
        };
      in
      {
        id = 0;
        isDefault = true;
        extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          bitwarden
        ];
        inherit pins spaces;
        pinsForce = true;
        spacesForce = true;
      };
  };
}
