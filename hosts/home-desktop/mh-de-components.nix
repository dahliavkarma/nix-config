{
  pkgs,
  ...
}:
{

  programs.zsh.zsh-abbr.abbreviations = {
    hyprland = "uwsm start hyprland-uwsm.desktop";
  };

  home.packages = with pkgs; [
    calibre
    gnome-text-editor
    kdePackages.kate
    kdePackages.okular
    peazip
    scantailor-advanced
    zotero

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

  programs.zsh.zsh-abbr.abbreviations = {
    "empty-trash" = "pushd ~/.local/share/Trash && rm -rf .";
  };

}
