{ pkgs, ... } @ inputs:

{
  programs.nixvim = {
    enable = true;
    colorschemes = import ./colorschemes.nix;
    keymaps = import ./keymaps.nix;
    options = import ./options.nix;
    globals = { mapleader = " "; };
    plugins = {
      lsp = import ./plugins/lsp.nix inputs;
      nvim-cmp = import ./plugins/cmp;
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp-cmdline.enable = true;
      cmp_luasnip.enable = true;
      luasnip = import ./plugins/luasnip;
      nvim-autopairs.enable = true;
      treesitter.enable = true;

      rust-tools.enable = true;
      nvim-jdtls = import ./plugins/jdtls;

      telescope = import ./plugins/telescope.nix;
      lualine = import ./plugins/lualine.nix;
      barbecue.enable = true;
      barbar = import ./plugins/barbar.nix;
    };
    extraConfigLua = ''
      require'lspconfig'.hls.setup {
        filetypes = { 'haskell', 'lhaskell', 'cabal' },
        cmd = { "${pkgs.haskell-language-server}/bin/haskell-language-server-9.4.8", "--lsp" }
      }
    '';
  };
}
