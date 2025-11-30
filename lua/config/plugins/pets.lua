return {
	"LukaKobaidze/pets.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"giusgad/hologram.nvim",
	},
	config = function()
		require("pets").setup({
			row = 7,
			random = false,
			default_pet = "dog",
			default_style = "black",
		})
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				vim.defer_fn(function()
					vim.cmd("PetsNewCustom dog black doggy")
				end, 50)
			end,
		})
	end,
}
