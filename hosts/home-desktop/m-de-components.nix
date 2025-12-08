{
  pkgs,
  ...
}:
{

  ### display manager
  services.xserver.displayManager.startx.enable = true; # enabled for login through tty, otherwise it's just ldm

  # file manager
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    baobab
    bluetuith # bluetooth management
    nautilus
    evince # pdf viewer, generates thumbnail
    loupe # rust-driven photo viewer
    sushi # quick previewer
    totem # video player, generates thumbnail
  ];
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "kitty";
  };

  services.udisks2 = {
    enable = true;
  };

  programs.ssh = {
    askPassword = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
  };

  services.blueman = {
    enable = true;
  };

}
