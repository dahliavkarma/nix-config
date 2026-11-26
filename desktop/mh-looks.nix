{
  ...
}:
{
  stylix = {
    enable = true;
    targets = {
      gnome-text-editor.enable = false;
      # Plasma handles Qt theming; the NixOS-level stylix qt target already sets
      # the kde platform theme, and the HM target only supports qtct.
      qt.enable = false;
    };
  };
  fonts.fontconfig.defaultFonts.monospace = [
    "Iosevka Nerd Font"
    "Sarasa Mono SC"
  ];

}
