{
  ...
}:
{
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };
  # programs.zsh = {
  #   initContent = ''eval "($direnv hook zsh)"'';
  # };
  programs.git = {
    userName = "dahliavkarma";
    userEmail = "dahliavkarma@gmail.com";
  };
}
