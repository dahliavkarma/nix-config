{
  lib,
  pkgs,
  ...
}:
let
  ext = pkgs.gnomeExtensions;
in
{
  home.packages = with pkgs; [
    libgtop # for gnome vitals
    lm_sensors # for gnome vitals
  ];
  gtk.enable = true;
  programs.gnome-shell = {
    enable = true;
    extensions = [
      {
        package = ext.appindicator;
        id = "appindicatorsupport@rgcjonas.gmail.com";
      }
      {
        package = ext.clipboard-indicator;
        id = "clipboard-indicator@tudmotu.com";
      }
      {
        package = ext.color-picker;
        id = "color-picker@tuberry";
      }
      {
        package = ext.dash-to-dock;
        id = "dash-to-dock@micxgx.gmail.com";
      }
      {
        package = ext.gnome-40-ui-improvements;
        id = "gnome-ui-tune@itstime.tech";
      }
      {
        package = ext.kimpanel;
        id = "kimpanel@kde.org";
      }
      {
        package = ext.middle-click-to-close-in-overview;
        id = "middleclickclose@paolo.tranquilli.gmail.com";
      }
      {
        package = ext.screen-rotate; # autorotate regardless of touch mode
        id = "screen-rotate@shyzus.github.io";
      }
      {
        package = ext.thinkpad-battery-threshold;
        id = "thinkpad-battery-threshold@marcosdalvarez.org";
      }
      {
        package = ext.user-themes;
        id = "user-theme@gnome-shell-extensions.gcampax.github.com";
      }
      {
        package = ext.vitals;
        id = "Vitals@CoreCoding.com";
      }
    ];
  };
  dconf = {
    enable = true;
    settings = {

      ### EXTENSIONS ###
      "org/gnome/shell" = {
        disable-user-extensions = false;
      };
      "org/gnome/shell/extensions/clipboard-indicator" = {
        move-item-first = true;
      };
      "org/gnome/shell/extensions/color-picker" = {
        enable-notify = true;
        enable-shortcut = true;
        color-picker-shortcut = [ "<Super><Shift>c" ];
        enable-systray = true;
      };
      "org/gnome/shell/extensions/dash-to-dock" = {
        preview-size-scale = 0.15;
        click-action = "minimize-or-previews";
        scroll-action = "cycle-windows";
        shift-click-action = "previews";
        middle-click-action = "quit";
      };
      "org/gnome/shell/extensions/vitals" = {
        hot-sensors = [
          "_memory_usage_"
          "__temperature_avg__"
        ];
      };

      ### APPEARANCE ###
      "org/gnome/desktop/interface" = {
        color-scheme = lib.mkForce "prefer-dark";
        text-scaling-factor = 1.25;
      };
      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
        night-light-schedule-from = 21.0;
        night-light-schedule-to = 8.0;
      };

      ### PROGRAMS ###
      # "org/gnome/desktop/default-applications" = {
      #   terminal = "exec ${commonSettings.default.terminal}";
      # };
      "org/gnome/shell" = {
        favorite-apps = [
          "org.gnome.Nautilus.desktop"
          "kitty.desktop"
          "codium.desktop"
          # "anki.desktop"
          "zen.desktop54000"
        ];
      };

      ### WINDOW BEHAVIOUR ###
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
        focus-mode = "click"; # click or sloppy
        auto-raise = "true";
      };
      "org/gnome/mutter" = {
        edge-tiling = true;
      };

      ### KEYBOARD ###
      "org/gnome/dektop/input-sources" = {
        xkb-options = [ "compose:ralt" ];
      };
      "org/gnome/desktop/wm/keybindings" = {
        switch-windows = [
          "<Ctrl>Tab"
          "<Super>Tab"
        ];
        switch-windows-backward = [
          "<Shift><Ctrl>Tab"
          "<Shift><Super>Tab"
        ];
        toggle-application-view = [ "<Super>a" ];
        switch-input-source = [ ];
        switch-input-source-backward = [ ];
        screenshot = [ ];
        screenshot-window = [ ];
        show-screenshot-ui = [ "<Shift><Super>s" ];
        toggle-message-tray = [ ];
      };

      ### POWER ###
      "org/gnome/desktop/session" = {
        idle-delay = lib.hm.gvariant.mkUint32 0;
      };
      "org/gnmome/settings-daemon/plugins/power" = {
        sleep-inactive-ac-type = "nothing";
      };
      "org/gnome/desktop/screensaver" = {
        lock-enabled = false;
      };
      "org/gnome/desktop/interface" = {
        show-battery-percentage = true;
      };
      "org/gnome/shell/extensions/thinkpad-battery-threshold" = {
        indicator-mode = "ALWAYS";
      };

      ### OTHERS ###
      "org/gnome/desktop/media-handling" = {
        automount = false;
        automount-open = false;
      };
    };
  };

}
