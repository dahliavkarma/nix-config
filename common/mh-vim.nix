{
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
      };
    };
  };
}
