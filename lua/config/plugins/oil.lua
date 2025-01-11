return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
	  require("oil").setup({
      win_options = {
        signcolumn = "yes:2",
      },
    })
    vim.keymap.set("n", "-", "<cmd>Oil<CR>")
  end
}
