{
  lib, 
  ...
}:
{
  # Options slightly differernt from the nixpkgs one
  programs.zsh = {
    # Fzf is enabled on user level
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
  };

}
