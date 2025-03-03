return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-buffer", -- Buffer completions
		"hrsh7th/cmp-path", -- Path completions
		"hrsh7th/cmp-nvim-lsp", -- LSP completions
		"hrsh7th/cmp-nvim-lua", -- Neovim Lua API completions
		"saadparwaiz1/cmp_luasnip", -- Snippet completions
		"L3MON4D3/LuaSnip", -- Snippet engine
		"onsails/lspkind.nvim", -- Icons
	},
	config = function()
		-- Configuration for nvim-cmp
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		cmp.setup({
			window = {
				completion = {
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				},
				documentation = {
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				},
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body) -- Expand snippets
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept selected item
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- LSP completions
				{ name = "luasnip" }, -- Snippet completions
			}, {
				{ name = "buffer" }, -- Buffer completions
				{ name = "path" }, -- Path completions
			}),
			-- Enable icons with lspkind
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(_, vim_item)
					local kind = vim_item.kind

					vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" })
					vim_item.menu = " " .. kind
					return vim_item
				end,
			},
		})

		-- Use buffer source for `/` (search) and `:` (command line)
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})
	end,
}
