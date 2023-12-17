{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    colorschemes = import ./colorschemes.nix;
    plugins = {
      lsp = import ./plugins/lsp.nix;
      nvim-cmp = import ./plugins/cmp.nix;
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp-cmdline.enable = true;
      cmp_luasnip.enable = true;
      luasnip.enable = true;
      treesitter.enable = true;

      telescope = import ./plugins/telescope.nix;
    };
  };
}
