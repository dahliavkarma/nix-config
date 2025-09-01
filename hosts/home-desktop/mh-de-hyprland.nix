{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all &
    QT_QPA_PLATFORM=wayland ${pkgs.copyq}/bin/copyq --start-server &
  '';
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      debug.disable_logs = false;
      # xwayland.force_zero_scaling = true; # steam might run pixelated when false but most X11 apps won't scale when true
      monitor = [
        "HDMI-A-1, 3840x2160@60, 0x0, 2"
        "DP-3, 3840x2160@60, 1920x0, 2"
      ];
      ### PROGRAMS ###
      "$terminal" = "${pkgs.kitty}/bin/kitty";
      "$fileManager" = "${pkgs.nautilus}/bin/nautilus";
      "$menu" = "${pkgs.wofi}/bin/wofi";
      "$browser" = "${inputs.zen-browser.packages.${pkgs.system}.default}/bin/zen";
      "$screenshot" = "${pkgs.grim}/bin/grim -t png -g \"$(${pkgs.slurp}/bin/slurp -w 0)\" - | wl-copy";
      "$editScreenshot" = "${pkgs.wl-clipboard-rs}/bin/wl-paste | ${pkgs.swappy}/bin/swappy -f -";
      "$clipboardHist" = "${pkgs.copyq}/bin/copyq show";
      ### AUTOSTART ###
      exec-once = ''${startupScript}/bin/start'';
      ### WORKSPACES ###
      workspace = [
        "1, monitor:HDMI-A-1, persistent:true"
        "2, monitor:HDMI-A-1, persistent:true"
        "3, monitor:HDMI-A-1, persistent:true"
        "4, monitor:HDMI-A-1, persistent:true"
        "5, monitor:HDMI-A-1, persistent:true"
        "6, monitor:HDMI-A-1, persistent:true"
        "7, monitor:HDMI-A-1, persistent:true"
        "8, monitor:HDMI-A-1, persistent:true"
        "9, monitor:HDMI-A-1, persistent:true"
        "10, monitor:HDMI-A-1, persistent:true"
        "11, monitor:DP-3, persistent:true"
        "12, monitor:DP-3, persistent:true"
        "13, monitor:DP-3, persistent:true"
        "14, monitor:DP-3, persistent:true"
        "15, monitor:DP-3, persistent:true"
        "16, monitor:DP-3, persistent:true"
        "17, monitor:DP-3, persistent:true"
        "18, monitor:DP-3, persistent:true"
        "19, monitor:DP-3, persistent:true"
        "20, monitor:DP-3, persistent:true"
      ];
      ### KEYBINDINGS ###
      "$mainMod" = "SUPER";
      bind = [
        # keyboard bindings
        # run
        "$mainMod, T, exec, $terminal"
        "$mainMod, R, exec, $menu --show drun -show-icons -a" # Run
        "$mainMod, E, exec, $fileManager" # Explorer
        "$mainMod, B, exec, $browser"
        "$mainMod, C, exec, codium"
        "$mainMod, M, togglefloating," # toggle Mode
        "$mainMod, F, fullscreen"
        "$mainMod, Q, killactive,"
        "$mainMod SHIFT, Q, exit,"
        "$mainMod SHIFT, S, exec, $screenshot"
        "$mainMod SHIFT, E, exec, $editScreenshot"
        "$mainMod, V, exec, $clipboardHist"
        # move window
        "$mainMod, left, movewindow, l"
        "$mainMod, right, movewindow, r"
        "$mainMod, up, movewindow, u"
        "$mainMod, down, movewindow, d"
        "$mainMod CTRL, left, movewindow, mon:HDMI-A-1"
        "$mainMod CTRL, right, movewindow, mon:DP-3"
        # alter focus
        "$mainMod ALT, left, movefocus, l"
        "$mainMod ALT, right, movefocus, r"
        "$mainMod ALT, up, movefocus, u"
        "$mainMod ALT, down, movefocus, d"
        # alter focus through workspaces
        "$mainMod ALT, left, workspace, r-1"
        "$mainMod ALT, right, workspace, r+1"
        "$mainMod, prior, workspace, r-1"
        "$mainMod, next, workspace, r+1"
        "$mainMod, mouse_up, workspace, r+1"
        "$mainMod, mouse_down, workspace, r-1"
        # shift window to workspace
        "$mainMod CTRL, prior, movetoworkspace, r-1"
        "$mainMod CTRL, next, movetoworkspace, r+1"
        "$mainMod CTRL, mouse_up, movetoworkspace, r+1"
        "$mainMod CTRL, mouse_down, movetoworkspace, r-1"
        # move to workspace
        "$mainMod ALT, 1, workspace, 1"
        "$mainMod ALT, 2, workspace, 2"
        "$mainMod ALT, 3, workspace, 3"
        "$mainMod ALT, 4, workspace, 4"
        "$mainMod ALT, 5, workspace, 5"
        "$mainMod ALT, q, workspace, 6"
        "$mainMod ALT, w, workspace, 7"
        "$mainMod ALT, e, workspace, 8"
        "$mainMod ALT, r, workspace, 9"
        "$mainMod ALT, t, workspace, 10"
        "$mainMod ALT, a, workspace, 11"
        "$mainMod ALT, s, workspace, 12"
        "$mainMod ALT, d, workspace, 13"
        "$mainMod ALT, f, workspace, 14"
        "$mainMod ALT, g, workspace, 15"
        "$mainMod ALT, z, workspace, 16"
        "$mainMod ALT, x, workspace, 17"
        "$mainMod ALT, c, workspace, 18"
        "$mainMod ALT, v, workspace, 19"
        "$mainMod ALT, b, workspace, 20"
        # move window to workspace
        "$mainMod CTRL, 1, workspace, 1"
        "$mainMod CTRL, 2, workspace, 2"
        "$mainMod CTRL, 3, workspace, 3"
        "$mainMod CTRL, 4, workspace, 4"
        "$mainMod CTRL, 5, workspace, 5"
        "$mainMod CTRL, q, workspace, 6"
        "$mainMod CTRL, w, workspace, 7"
        "$mainMod CTRL, e, workspace, 8"
        "$mainMod CTRL, r, workspace, 9"
        "$mainMod CTRL, t, workspace, 10"
        "$mainMod CTRL, a, workspace, 11"
        "$mainMod CTRL, s, workspace, 12"
        "$mainMod CTRL, d, workspace, 13"
        "$mainMod CTRL, f, workspace, 14"
        "$mainMod CTRL, g, workspace, 15"
        "$mainMod CTRL, z, workspace, 16"
        "$mainMod CTRL, x, workspace, 17"
        "$mainMod CTRL, c, workspace, 18"
        "$mainMod CTRL, v, workspace, 19"
        "$mainMod CTRL, b, workspace, 20"
      ];
      bindl = [
        # works even when lockscreen is active
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];
      bindel = [
        # works when locked & repeat when held
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];
      bindm = [
        # mouse bindings
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizwindow"
        "$mainMod ALT, mouse:272, resizewindow"
      ];
      ### WINDOWS AND WORKSPACES ###
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "float, class:com.github.hluk.copyq, title:CopyQ"
      ];
      ### LOOK AND FEEL ###
      dwindle = {
        pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # You probably want this
      };
      general = {
        gaps_in = 3;
        gaps_out = "0, 16, 0, 16";
        border_size = 1;
        "col.active_border" = lib.mkForce "0xffc49ea0 0xffc49ec4 0xffa39ec4 0xffa5b4cb 0xff9ec3c4 45deg";
        "col.inactive_border" = lib.mkForce "0xff3c3836";
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };
      decoration = {
        rounding = 4;
        # change transparency of window on focus
        active_opacity = 1;
        inactive_opacity = 0.97;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };
      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };
      ### INPUT ###
      input = {
        kb_layout = "us";
        kb_options = "compose:ralt";
        follow_mouse = 1;
      };
    };
  };
}
