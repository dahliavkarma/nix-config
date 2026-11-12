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
    # mise shims so non-interactive shells (e.g. Claude Code hooks via /bin/sh) find node/pnpm
    "$HOME/.local/share/mise/shims"
    # "/Applications/IntelliJ IDEA CE.app/Contents/MacOS"
  ];
}
