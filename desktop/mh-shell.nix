{
  pkgs,
  ...
}:
{
  programs.zsh.zsh-abbr.abbreviations = {
    "xremap" = "systemctl restart --user xremap";
  };

  programs.kitty = {
    enable = true;
    settings = {
      # make the terminal bell audible (e.g. sudo password prompts, see m-user.nix)
      enable_audio_bell = true;
      bell_path = "${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/bell.oga";
      window_alert_on_bell = true; # also mark the window/workspace urgent
    };
  };
}
