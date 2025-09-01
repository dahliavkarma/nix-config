{
  pkgs,
  ...
}:
{
  # DO NOT TRY TO PATCH SARASA. Exceeds 65535 glyphs.

  # stylix
  stylix = {
    enable = true;
    image = ./r-wall-archimedes-death.png;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";
    cursor = {
      package = pkgs.nordzy-cursor-theme;
      name = "Nordzy-cursors";
      size = 24;
    };
    fonts = {
      # will set the system fontconfig too
      monospace = {
        name = "Sarasa Mono SC";
        package = pkgs.sarasa-gothic;
      };
      sansSerif = {
        name = "Sarasa UI SC";
        package = pkgs.sarasa-gothic;
      };
      serif = {
        name = "Noto Serif CJK SC";
        package = pkgs.noto-fonts-cjk-serif;
      };
    };
    targets = {
      gnome-text-editor.enable = false;
    };
  };

  # additional fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      maple-mono.NF-CN
      nerd-fonts.iosevka
    ];
    fontconfig.defaultFonts.monospace = [
      "Iosevka Nerd Font"
      "Sarasa Mono SC"
    ];
  };

  # starship
  programs.starship.presets = [ "nerd-font-symbols" ];

}
