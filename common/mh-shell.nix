{
  lib,
  pkgs,
  ...
}:
{

  programs.zsh.enable = true;

  # aliases
  programs.zsh.zsh-abbr = {
    enable = true;
    abbreviations = {
      ## abreviations & substitutions
      ls = "eza";
      cat = "bat";
      ## workarounds
      # nix = "noglob nix"; # enable hashtag-hostname designation without quotes
      # nixos-rebuild = "noglob nixos-rebuild"; # see above
      "update-switch" = "pushd ~/nix-config && nix flake update && nh os switch && popd";
      "just-switch" = "nh os switch";
    };
  };

  # settings and functioalities
  programs.zsh = {
    # some are set in m-system.nix
    autocd = true;
    historySubstringSearch.enable = true;

  };
  programs.zsh.plugins = [
    {
      name = pkgs.nix-zsh-completions.pname;
      src = pkgs.nix-zsh-completions.src;
    }
    {
      name = pkgs.zsh-autopair.pname;
      src = pkgs.zsh-autopair.src;
    }
    {
      name = pkgs.zsh-completions.pname;
      src = pkgs.zsh-completions.src;
    }
    {
      name = pkgs.zsh-command-time.pname;
      src = pkgs.zsh-command-time.src;
    }
    {
      name = pkgs.zsh-fzf-tab.pname;
      src = pkgs.zsh-fzf-tab.src;
    }
    {
      name = pkgs.zsh-nix-shell.pname;
      src = pkgs.zsh-nix-shell.src;
    }
    {
      name = pkgs.zsh-z.pname;
      src = pkgs.zsh-z.src;
    }
  ];
  programs.fzf.enable = true; # zsh integration is enabled by default

  # git
  programs.git = {
    enable = true;
    ignores = [
      "*~"
      "*.swp"
      ".stfolder/"
    ];
  };

  # ssh settings
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      homelab = {
        host = "homelab";
        hostname = "192.168.0.52";
      };
      home-desktop = {
        host = "home-desktop";
        hostname = "192.168.0.50";
      };
      laptop = {
        host = "laptop";
        hostname = "192.168.0.41";
      };
    };
  };

}
