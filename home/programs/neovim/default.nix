{ pkgs, ... }: let
  tsPlugins = with pkgs.vimPlugins.nvim-treesitter-parsers; [
    css scss html yuck
    astro svelte
    nix lua typescript rust elixir
  ];

  plugins = with pkgs.vimPlugins; [
    nvim-treesitter nightfox-nvim
    nvim-lspconfig nvim-cmp cmp-nvim-lsp cmp_luasnip luasnip nvim-autopairs
    telescope-nvim barbar-nvim lualine-nvim nvim-web-devicons
  ] ++ tsPlugins;
in {
  inherit plugins;
  enable = true;
  defaultEditor = true;
  extraLuaConfig = pkgs.lib.concatStrings (map builtins.readFile (import ./plugins));
}
