{
  pkgs,
  lib,
  ...
}: let
  layer = "top";
  height = 32;
  margin = "9px 16px";
  reload_style_on_change = true;
  "custom/slash".format = "/";
  memory = {
    format = " {}%";
    on-click = "${pkgs.kitty}/bin/kitty --class system_monitor --hold sh -c btop";
  };
  cpu = {
    interval = 1;
    format = " {icon0}{icon1}{icon2}{icon3}";
    format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
    on-click = "${pkgs.kitty}/bin/kitty --class system_monitor --hold sh -c btop";
    max-length = 25;
    min-length = 6;
  };
  temperature = {
    critical-threshold = 80;
    format = "{temperatureC}°C {icon}";
    format-icons = ["" "" ""];
    format-critical = "{temperatureC}°C ";
    tooltip = false;
  };
  network = {
    format-wifi = "{signalStrength}% ";
    format-ethernet = "{ipaddr}/{cidr} 󰛳";
    tooltip-format = "{ifname} via {gwaddr} ";
    format-linked = "{ifname} (No IP) 󰅛";
    format-disconnected = "Disconnected ⚠";
  };
  # Waybar 0.15.0 (the tagged release in nixpkgs) predates upstream PR #5013
  # ("fix(hyprland/workspaces): adapt dispatch commands for Lua IPC
  # protocol", merged 2026-05-04, commit 0594574), which is what actually
  # fixes on-click "activate" under Hyprland Lua config (configType = "lua"
  # in mh-de-hyprland.nix). No tagged release includes it yet, so this
  # builds waybar straight from a recent master commit instead of vendoring
  # a third-party module or reimplementing the workspace widget ourselves.
  waybarUnstable = (pkgs.waybar.override { cavaSupport = false; }).overrideAttrs (old: {
    version = "0.15.0-unstable-2026-09-20";
    src = pkgs.fetchFromGitHub {
      owner = "Alexays";
      repo = "Waybar";
      rev = "3672eee03a6abfe883310b92ddbcf3300ae43b2d";
      hash = "sha256-dc2tsgfAKqnZ/w369G6mYkfeIathdWLeyh+xgBxERU8=";
    };
    # versionCheckHook expects `waybar --version` to report old.version;
    # this is an untagged snapshot, so there is nothing meaningful to check.
    doInstallCheck = false;
    # New since nixpkgs' pinned 0.15.0: a WWAN/cellular module gated on
    # ModemManager's mm-glib, which nixpkgs' waybar doesn't build against
    # and this desktop has no use for.
    mesonFlags = (old.mesonFlags or []) ++ ["-Dwwan=disabled"];
  });
  "hyprland/workspaces" = {
    all-outputs = false;
    on-click = "activate";
    on-scroll-up = "hyprctl dispatch 'hl.dsp.focus({workspace = \"r-1\"})'";
    on-scroll-down = "hyprctl dispatch 'hl.dsp.focus({workspace = \"r+1\"})'";
    format = "{icon}";
    format-icons = {
      "active" = "";
      "default" = "";
      "empty" = "";
    };
  };
  "custom/power" = {
    format = "⏻";
    tooltip = false;
    menu = "on-click";
    menu-file = ./r-de-power.xml;
    menu-actions = {
      "logout" = "uwsm stop";
      "shutdown" = "shutdown";
      "reboot" = "reboot";
      "suspend" = "systemctl suspend";
      # "hibernate" = "systemctl hibernate";
    };
  };
  pulseaudio = { # substitute with a JACK one, one day, also check m-de-components.nix
    format = "  {volume}%";
    format-bluetooth = " {volume}%";
    scroll-step = 1;
    on-click-right = "pavucontrol";
    ignored-sinks = ["Easy Efects Sink"];
    max-length = 25;
    exec = "pactl --format=json list sinks | jq -cM --unbuffered \"map(select(.name == \\\"$(pactl get-default-sink)\\\"))[0].properties | [.\\\"media.name\\\",.\\\"alsa.name\\\",.\\\"node.nick\\\",.\\\"alsa.long_card_name\\\"] | map(select(length>0))[0] | {text:.}\"";
    exec-if = "sleep 0.1";
    on-click = "pactl --format=json list sinks short | jq -cM --unbuffered \"[.[].name] | .[((index(\\\"$(pactl get-default-sink)\\\")+1)%length)]\" | xargs pactl set-default-sink";
    tooltip = false;
  };
  bluetooth = {
    format = "󰂯";
    tooltip = false;
    on-click-right = "${pkgs.kitty}/bin/kitty --class bluetooth-manager --hold sh -c bluetuith";
   };
in {
  programs.waybar = {
    enable = true;
    package = waybarUnstable;
    style = ./r-de-waybar.css;
    settings = {
      topBar = {
        name = "topBar";
        inherit layer height margin reload_style_on_change "custom/slash" "custom/power";
        position = "top";
        modules-left = [ "clock" "custom/slash" "hyprland/window" ];
        modules-right = [ "custom/power" ];
        clock = {
          format = "{:%F  %A  %R  W%V}";
        };
        "hyprland/window" = {
          "seperate-outputs" = true;
        };
      };
      bottomBar= {
        name = "bottomBar";
        inherit layer height margin reload_style_on_change memory cpu temperature network "hyprland/workspaces" pulseaudio;
        position = "bottom";
        modules-left = [ "memory" "cpu" "temperature" "network" ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [ "tray" "pulseaudio" ];
        tray = {
          spacing = 7;
        };
      };
    };
  };
  home.packages = with pkgs; [
    lm_sensors
    pulseaudioFull
    pavucontrol
    jq # pulseaudio module above shells out to a bare `jq`, not otherwise declared
  ];
  stylix.targets.waybar.enable = false;
  programs.zsh.zsh-abbr.abbreviations = {
    "waybar" = "hyprctl dispatch 'hl.dsp.exec_cmd(\"waybar\")'";
    "restart-waybar" = "pkill waybar && hyprctl dispatch 'hl.dsp.exec_cmd(\"waybar\")'";
  };
}
