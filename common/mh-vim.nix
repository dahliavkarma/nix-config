{
  config,
  lib,
  options,
  pkgs,
  ...
}:
{
  imports = [
    # stylix's nvf target still sets the renamed `vim.statusline.lualine.theme`,
    # which triggers an eval warning. Until upstream merges the fix
    # (nix-community/stylix#2497), disable the target and apply the same theme here.
    # Guarded because stylix only adds its HM module on hosts with stylix enabled.
    {
      config = lib.optionalAttrs (options ? stylix) {
        stylix.targets.nvf.enable = false;
        programs.nvf.settings.vim = lib.mkIf config.stylix.enable {
          theme = {
            enable = true;
            name = "base16";
            base16-colors = {
              inherit (config.lib.stylix.colors.withHashtag)
                base00
                base01
                base02
                base03
                base04
                base05
                base06
                base07
                base08
                base09
                base0A
                base0B
                base0C
                base0D
                base0E
                base0F
                ;
            };
          };
          statusline.lualine.setupOpts.options.theme = "base16";
        };
      };
    }
  ];

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

        lsp = {
          enable = true;
          formatOnSave = true;
        };
        treesitter.enable = true;

        clipboard = {
          enable = true;
          registers = "unnamedplus";
        };

        languages = {
          html = {
            enable = true;
            lsp.servers = [ "emmet-ls" ];
          };
          lua.enable = true;
          markdown = {
            enable = true;
            extensions.markview-nvim = {
              enable = true;
            };
            format.enable = true;
          };
          nix = {
            enable = true;
            format = {
              enable = true;
              type = [ "nixfmt" ];
            };
            lsp.servers = [ "nixd" ];
          };
          python.enable = true;
          typescript = {
            enable = true;
            format.enable = false;
          };
        };

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
            javascriptreact = [ "prettier" ];
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
