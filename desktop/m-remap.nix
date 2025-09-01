{
  username,
  ...
}:
{

  services.xremap.enable = true;
  # to run xremap as a user
  hardware.uinput.enable = true;
  users.groups = {
    uinput.members = [ username ];
    input.members = [ username ];
  };

  # mode
  services.xremap = {
    # needs to be enabled manually on each machine
    serviceMode = "user";
    userName = username;
  };

  # options
  services.xremap = {
    # enable feature flags for each machine
    # debug = true;
    watch = true;
    mouse = true;
  };
  systemd.user.services.xremap = {
    serviceConfig = {
      Restart = "on-failure";
      RestartSec = 3;
    };
  };

  # config
  services.xremap.config = {
    modmap = [
      {
        name = "Caps Lock to esc";
        remap = {
          "CapsLock" = "Esc";
        };
      }
      {
        name = "Esc to change language (set up in fcitx)";
        remap = {
          "Esc" = "KatakanaHiragana";
        };
      }
      {
        name = "swap left ctrl & alt";
        remap = {
          "LeftCtrl" = "LeftAlt";
          "LeftAlt" = "LeftCtrl";
        };
      }
      {
        name = "lower right alt-home-end";
        remap = {
          "SysRq" = "Home"; # yes, PrtSc key is actually SysRq
          "RightCtrl" = "End";
        };
        device.only = "Darfon Thinkpad X12 Detachable Gen 1 Folio case -1";
      }
    ];
    keymap = [
      {
        name = "shift + capslock";
        remap = {
          "Shift-Esc" = "CapsLock";
        };
      }
      {
        name = "swap back ctrl/alt tab";
        remap = {
          "Ctrl-Tab" = "Alt-Tab";
          "Alt-Tab" = "Ctrl-Tab";
          "Ctrl-Shift-Tab" = "Alt-Shift-Tab";
          "Alt-Shift-Tab" = "Ctrl-Shift-Tab";
        };
      }
    ];
  };

}
