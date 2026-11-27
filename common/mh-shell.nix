{
  config,
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
      # cat = "bat"; # comfortable enough to comment this out
      ## workarounds
      # nix = "noglob nix"; # enable hashtag-hostname designation without quotes
      # nixos-rebuild = "noglob nixos-rebuild"; # see above
      "update" = "pushd ~/nix-config && nix flake update && popd";
    };
  };

  # settings and functioalities
  programs.zsh = {
    # some are set in m-system.nix
    dotDir = config.home.homeDirectory;
    autocd = true;
    historySubstringSearch.enable = true;
    sessionVariables = {
      EDITOR = "nvim";
    };
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
      name = pkgs.zsh-fzf-tab.pname;
      src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      file = "fzf-tab.plugin.zsh";
    }
    {
      name = pkgs.zsh-nix-shell.pname;
      src = pkgs.zsh-nix-shell.src;
      file = "nix-shell.plugin.zsh";
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
    signing.format = null;
    # settings = {
    #   user = {
    #     name = "dahliavkarma";
    #     email = "dahliavkarma@gmail.com";
    #   };
    # };
  };

  # ssh settings
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      homelab = {
        host = "homelab";
        hostname = "homelab.silverside-chimera.ts.net";
        addKeysToAgent = "yes";
        forwardAgent = true;
      };
      home-desktop = {
        host = "home-desktop";
        hostname = "home-desktop.silverside-chimera.ts.net";
        addKeysToAgent = "yes";
        forwardAgent = true;
      };
    };
  };

  programs.ripgrep = {
    enable = true;
    package = pkgs.ripgrep-all;
  };

  programs.claude-code = {
    enable = true;
  };

  home.packages = with pkgs; [
    inetutils
  ];

}
