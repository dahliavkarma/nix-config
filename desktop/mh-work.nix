{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    jetbrains.idea-community-bin
    github-copilot-intellij-agent
  ];
  xdg.configFile = {
    ".ideavimrc".text = ''
      set clipboard+=unnamed
    '';
  };
}
