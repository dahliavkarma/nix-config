{
  lib,
  ...
}:
{
  zsh.zsh-abbr = {
    abbreviations = {
      ## abreviations & substitutions
      ls = "eza";
      cat = "bat";
      ## workarounds
      # nix = "noglob nix"; # enable hashtag-hostname designation without quotes
      # nixos-rebuild = "noglob nixos-rebuild"; # see above
      "update" = "pushd ~/nix-config && nix flake update && popd";
      "switch" = "sudo darwin-rebuild --flake /Users/user/nix-config switch";
    };
  };
}