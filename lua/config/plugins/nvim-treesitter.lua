return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
   local nvim_treesitter = require('nvim-treesitter.configs')
   nvim_treesitter.setup({
     ensure_installed = { "typescript", "tsx", "javascript" },
     highlight = {
       enable = true,  -- Enable syntax highlighting
     },
     indent = {
       enable = true,  -- Enable indentation based on Tree-sitter
     },
   })
  end
}
