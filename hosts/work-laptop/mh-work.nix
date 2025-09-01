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
    "/Applications/IntelliJ IDEA CE.app/Contents/MacOS"
  ];
}
