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
    on-click = "${pkgs.kitty}/bin/kitty --class system_monitor -e btop";
  };
  cpu = {
    interval = 1;
    format = " {icon0}{icon1}{icon2}{icon3}";
    format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
    on-click = "${pkgs.kitty}/bin/kitty --class system_monitor -e btop";
    max-length = 25;
    min-length = 6;
  };
  temperature = {
    critical-threshold = 40;
    format = "{temperatureC}°C {icon}";
    format-icons = ["" "" ""];
    tooltip = false;
  };
  network = {
    format-wifi = "{signalStrength}% ";
    format-ethernet = "{ipaddr}/{cidr} 󰛳";
    tooltip-format = "{ifname} via {gwaddr} ";
    format-linked = "{ifname} (No IP) 󰅛";
    format-disconnected = "Disconnected ⚠";
  };
  "hyprland/workspaces" = {
    all-outputs = false;
    on-click = "activate";
    on-scroll-up = "hyprctl dispatch workspace r-1";
    on-scroll-down = "hyprctl dispatch workspace r+1";
    format = "{icon}";
    format-icons = {
      "active" = "";
      "default" = "";
      "empty" = "";
      # "1" = "01";
      # "2" = "02";
      # "3" = "03";
      # "4" = "04";
      # "5" = "05";
      # "6" = "06";
      # "7" = "07";
      # "8" = "08";
      # "9" = "09";
      # "10" = "10";
    };
  };
  "custom/power" = {
    format = "⏻ ";
    tooltip = false;
    menu = "on-click";
    menu-file = ./r-de-power.xml;
    menu-actions = {
      "logout" = "uwsm stop && exit";
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
in {
  programs.waybar = {
    enable = true;
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
  ];
  stylix.targets.waybar.enable = false;
  programs.zsh.zsh-abbr.abbreviations = {
    "waybar" = "hyprctl dispatch exec waybar";
    "restart-waybar" = "pkill waybar && hyprctl dispatch exec waybar";
  };
}