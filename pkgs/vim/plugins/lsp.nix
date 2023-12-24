{ pkgs, ... }:

{
  enable = true;
  keymaps = {
    lspBuf = {
      gd = "definition";
      gr = "references";
      gt = "type_definition";
      "<leader>k" = "hover";
      "<leader>r" = "rename";
    };
  };
  servers = {
    # Programming languages
    tsserver.enable = true;
    clangd.enable = true;
    pylsp.enable = true;
    elixirls.enable = true;
    rust-analyzer = {
      enable = true;
      installCargo = true;
      installRustc = true;
      package = pkgs.rust-analyzer;
    };

    # Web frameworks
    astro.enable = true;
    svelte.enable = true;

    # Styling
    cssls.enable = true;
    tailwindcss.enable = true;

    # Misc
    dockerls.enable = true;
  };
}
