{
  pkgs,
  ...
}: {
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };
  programs.zsh = {
    initContent = ''eval "($direnv hook zsh)"'';
  };
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