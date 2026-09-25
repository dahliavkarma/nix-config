{
  inputs,
  lib,
  pkgs,
  config,
  ...
}:
let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${config.programs.waybar.package}/bin/waybar &
    ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all &
    ${pkgs.copyq}/bin/copyq --start-server &
  '';

  terminal = "${pkgs.kitty}/bin/kitty";
  fileManager = "${pkgs.nautilus}/bin/nautilus";
  menu = "${pkgs.wofi}/bin/wofi";
  browser = "${inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/zen-beta";
  screenshot = "${pkgs.grim}/bin/grim -t png -g \"$(${pkgs.slurp}/bin/slurp -w 0)\" - | wl-copy";
  editScreenshot = "${pkgs.wl-clipboard-rs}/bin/wl-paste | ${pkgs.swappy}/bin/swappy -f -";
  clipboardHist = "${pkgs.copyq}/bin/copyq show";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    systemd.enable = false;
    settings = {
      ### AUTOSTART ###
      on = {
        _args = [
          "hyprland.start"
          (lib.generators.mkLuaInline ''
            function()
              hl.exec_cmd("${startupScript}/bin/start")
            end
          '')
        ];
      };

      ### LOOK AND FEEL / CORE OPTIONS ###
      config = {
        debug.disable_logs = false;
        # xwayland.force_zero_scaling = true; # steam might run pixelated when false but most X11 apps won't scale when true
        general = {
          gaps_in = 3;
          gaps_out = {
            top = 0;
            right = 16;
            bottom = 0;
            left = 16;
          };
          border_size = 1;
          resize_on_border = true;
          allow_tearing = false;
          layout = "dwindle";
          col = {
            active_border = lib.mkForce {
              colors = [
                "0xffc49ea0"
                "0xffc49ec4"
                "0xffa39ec4"
                "0xffa5b4cb"
                "0xff9ec3c4"
              ];
              angle = 45;
            };
            inactive_border = lib.mkForce "0xff3c3836";
          };
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
        animations.enabled = true;
        input = {
          kb_layout = "us";
          kb_options = "compose:ralt";
          follow_mouse = 1;
        };
        dwindle.preserve_split = true; # You probably want this
      };

      ### MONITORS ###
      monitor = [
        {
          output = "DP-3";
          mode = "3840x2160@60";
          position = "0x0";
          scale = 2;
        }
      ];

      ### WORKSPACES ###
      workspace_rule = map (n: {
        workspace = toString n;
        monitor = "DP-3";
        persistent = true;
      }) (lib.range 1 9);

      ### WINDOWS ###
      window_rule = [
        {
          match.class = ".*";
          suppress_event = "maximize";
        }
        {
          match.class = "com.github.hluk.copyq";
          float = true;
        }
        {
          match.class = "guitarix";
          float = true;
        }
        {
          match.title = "Guitarix:gx_head";
          size = [
            611
            679
          ];
        }
      ];

      ### ANIMATIONS ###
      curve = [
        {
          _args = [
            "easeOutQuint"
            {
              type = "bezier";
              points = [
                [
                  0.23
                  1
                ]
                [
                  0.32
                  1
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "easeInOutCubic"
            {
              type = "bezier";
              points = [
                [
                  0.65
                  0.05
                ]
                [
                  0.36
                  1
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "linear"
            {
              type = "bezier";
              points = [
                [
                  0
                  0
                ]
                [
                  1
                  1
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "almostLinear"
            {
              type = "bezier";
              points = [
                [
                  0.5
                  0.5
                ]
                [
                  0.75
                  1.0
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "quick"
            {
              type = "bezier";
              points = [
                [
                  0.15
                  0
                ]
                [
                  0.1
                  1
                ]
              ];
            }
          ];
        }
      ];
      # NOTE: `bezier = "default"` below refers to Hyprland's builtin default curve.
      # The wiki's own animation examples are inconsistent about whether this field is
      # called `bezier` or `curve` for a named curve reference — verify against
      # `hyprctl` / the generated hyprland.lua once this builds, the Lua config API is
      # still actively changing upstream.
      animation = [
        {
          leaf = "global";
          enabled = true;
          speed = 10;
          bezier = "default";
        }
        {
          leaf = "border";
          enabled = true;
          speed = 5.39;
          bezier = "easeOutQuint";
        }
        {
          leaf = "windows";
          enabled = true;
          speed = 4.79;
          bezier = "easeOutQuint";
        }
        {
          leaf = "windowsIn";
          enabled = true;
          speed = 4.1;
          bezier = "easeOutQuint";
          style = "popin 87%";
        }
        {
          leaf = "windowsOut";
          enabled = true;
          speed = 1.49;
          bezier = "linear";
          style = "popin 87%";
        }
        {
          leaf = "fadeIn";
          enabled = true;
          speed = 1.73;
          bezier = "almostLinear";
        }
        {
          leaf = "fadeOut";
          enabled = true;
          speed = 1.46;
          bezier = "almostLinear";
        }
        {
          leaf = "fade";
          enabled = true;
          speed = 3.03;
          bezier = "quick";
        }
        {
          leaf = "layers";
          enabled = true;
          speed = 3.81;
          bezier = "easeOutQuint";
        }
        {
          leaf = "layersIn";
          enabled = true;
          speed = 4;
          bezier = "easeOutQuint";
          style = "fade";
        }
        {
          leaf = "layersOut";
          enabled = true;
          speed = 1.5;
          bezier = "linear";
          style = "fade";
        }
        {
          leaf = "fadeLayersIn";
          enabled = true;
          speed = 1.79;
          bezier = "almostLinear";
        }
        {
          leaf = "fadeLayersOut";
          enabled = true;
          speed = 1.39;
          bezier = "almostLinear";
        }
        {
          leaf = "workspaces";
          enabled = true;
          speed = 1.94;
          bezier = "almostLinear";
          style = "fade";
        }
        {
          leaf = "workspacesIn";
          enabled = true;
          speed = 1.21;
          bezier = "almostLinear";
          style = "fade";
        }
        {
          leaf = "workspacesOut";
          enabled = true;
          speed = 1.94;
          bezier = "almostLinear";
          style = "fade";
        }
      ];
    };

    ### KEYBINDINGS ###
    # Written as plain Lua rather than Nix `_args`/`mkLuaInline` because every entry
    # calls an `hl.dsp.*` dispatcher function, which would otherwise mean escaping Lua
    # code inside Nix strings for ~40 binds.
    extraLuaFiles.binds = ''
      local mod = "SUPER"

      -- run
      hl.bind(mod .. " + T", hl.dsp.exec_cmd("${terminal}"))
      hl.bind(mod .. " + R", hl.dsp.exec_cmd("${menu} --show drun -show-icons -a")) -- Run
      hl.bind(mod .. " + E", hl.dsp.exec_cmd("${fileManager}")) -- Explorer
      hl.bind(mod .. " + B", hl.dsp.exec_cmd("${browser}"))
      hl.bind(mod .. " + C", hl.dsp.exec_cmd("codium"))
      hl.bind(mod .. " + M", hl.dsp.window.float()) -- toggle Mode
      hl.bind(mod .. " + F", hl.dsp.window.fullscreen())
      hl.bind(mod .. " + Q", hl.dsp.window.close())
      hl.bind(mod .. " + SHIFT + Q", hl.dsp.exit())
      hl.bind(mod .. " + SHIFT + S", hl.dsp.exec_cmd([[${screenshot}]]))
      hl.bind(mod .. " + SHIFT + E", hl.dsp.exec_cmd("${editScreenshot}"))
      hl.bind(mod .. " + V", hl.dsp.exec_cmd("${clipboardHist}"))

      -- move window
      hl.bind(mod .. " + left", hl.dsp.window.move({ direction = "l" }))
      hl.bind(mod .. " + right", hl.dsp.window.move({ direction = "r" }))
      hl.bind(mod .. " + up", hl.dsp.window.move({ direction = "u" }))
      hl.bind(mod .. " + down", hl.dsp.window.move({ direction = "d" }))
      hl.bind(mod .. " + CTRL + left", hl.dsp.window.move({ monitor = "HDMI-A-1" }))
      hl.bind(mod .. " + CTRL + right", hl.dsp.window.move({ monitor = "DP-3" }))

      -- alter focus
      hl.bind(mod .. " + ALT + left", hl.dsp.focus({ direction = "l" }))
      hl.bind(mod .. " + ALT + right", hl.dsp.focus({ direction = "r" }))
      hl.bind(mod .. " + ALT + up", hl.dsp.focus({ direction = "u" }))
      hl.bind(mod .. " + ALT + down", hl.dsp.focus({ direction = "d" }))

      -- alter focus through workspaces
      hl.bind(mod .. " + ALT + left", hl.dsp.focus({ workspace = "r-1" }))
      hl.bind(mod .. " + ALT + right", hl.dsp.focus({ workspace = "r+1" }))
      hl.bind(mod .. " + prior", hl.dsp.focus({ workspace = "r-1" }))
      hl.bind(mod .. " + next", hl.dsp.focus({ workspace = "r+1" }))
      hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "r+1" }))
      hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "r-1" }))

      -- shift window to workspace
      hl.bind(mod .. " + CTRL + prior", hl.dsp.window.move({ workspace = "r-1" }))
      hl.bind(mod .. " + CTRL + next", hl.dsp.window.move({ workspace = "r+1" }))
      hl.bind(mod .. " + CTRL + mouse_up", hl.dsp.window.move({ workspace = "r+1" }))
      hl.bind(mod .. " + CTRL + mouse_down", hl.dsp.window.move({ workspace = "r-1" }))

      -- workspace switching (numbers -> workspaces 1-9)
      local workspace_keys = {
        "1", "2", "3", "4", "5",
        "6", "7", "8", "9",
      }
      for i, key in ipairs(workspace_keys) do
        local ws = tostring(i)
        hl.bind(mod .. " + ALT + " .. key, hl.dsp.focus({ workspace = ws }))
        hl.bind(mod .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = ws }))
      end

      -- works even when lockscreen is active
      hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })

      -- works when locked & repeat when held
      hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
      hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })

      -- mouse bindings
      -- NOTE: the original `bindm` entry for mouse:273 used the dispatcher name
      -- `resizwindow` (missing an "e"), which isn't a real hyprlang dispatcher and was
      -- silently doing nothing. Migrated here to the presumably-intended window resize
      -- dispatcher.
      hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
      hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
      hl.bind(mod .. " + ALT + mouse:272", hl.dsp.window.resize(), { mouse = true })
    '';
  };
}
