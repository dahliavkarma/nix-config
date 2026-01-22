{
  config,
  pkgs,
  ...
}:
{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        options = {
          tabstop = 2;
          shiftwidth = 2; 
        };

        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;

        lsp.enable = true;
        treesitter.enable = true;

        clipboard = {
          enable = true;
          registers = "unnamedplus";
        };

        languages = {
          nix.enable = true;
          ts.enable = true;
          python.enable = true;
          markdown.enable = true;
          html.enable = true;
          lua.enable = true;
        };

        extraPackages = with pkgs; [
          nodePackages.prettier
        ];
        lazy = {
          enable = true;
          plugins = {
            ${pkgs.vimPlugins.autoclose-nvim.pname} = {
              package = pkgs.vimPlugins.autoclose-nvim;
              after = "require('autoclose').setup()";
            };
            ${pkgs.vimPlugins.ale.pname} = {
              package = pkgs.vimPlugins.ale;
            };
          };
        };

        globals = {
          ale_fix_on_save = 1;
          ale_fixers = {
            javascript = [ "prettier" ];
            typescript = [ "prettier" ];
            typescriptreact = [ "prettier" ];
            css = [ "prettier" ];
            html = [ "prettier" ];
            json = [ "prettier" ];
            markdown = [ "prettier" ];
            "*" = [ "remove_trailing_lines" ];
          };
          # ale_linters_explicit = 1;
          # ale_disable_lsp = 1; 
        };
      };
    };
  };
}

