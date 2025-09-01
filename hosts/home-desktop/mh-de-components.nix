{
  pkgs,
  ...
}:
{

  programs.zsh.zsh-abbr.abbreviations = {
    hyprland = "uwsm start hyprland-uwsm.desktop";
  };

  home.packages = with pkgs; [
    gnome-text-editor
    peazip

    dunst
    libnotify
    waybar

    grim # screenshot
    slurp # screen area selection
    swappy
    wl-clipboard-rs
  ];

  programs.wofi = {
    enable = true;
    settings = {
      allow_images = true;
    };
  };

  services.udiskie = {
    # udisks2 dbus enabled in m-de-components
    enable = true;
  };

}
