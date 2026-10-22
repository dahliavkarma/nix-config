{
  ...
}:
{
  xdg.configFile = {
    ".ideavimrc".text = ''
      set clipboard+=unnamed
    '';
  };
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };
  home.sessionPath = [
    # Native Claude Code installer (claude install); must precede Nix-provided claude
    "$HOME/.local/bin"
    # "/Applications/IntelliJ IDEA CE.app/Contents/MacOS"
  ];
}
