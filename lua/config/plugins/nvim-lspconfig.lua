return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")

    lspconfig.ts_ls.setup({
      on_attach = function(client, bufnr)
        vim.diagnostic.open_float()
      end,
    })
  end
}
