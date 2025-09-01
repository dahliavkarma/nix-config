{
  pkgs,
  ...
}:
{
  stylix = {
    enable = true;
    image = ../../desktop/r-wall-archimedes-death.png;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";
  };

  fonts.packages = with pkgs; [
    noto-fonts-cjk-serif
    maple-mono.NF
    sarasa-gothic
    nerd-fonts.iosevka
    nerd-fonts."m+"
  ];
}
