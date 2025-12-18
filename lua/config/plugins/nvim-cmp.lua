return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-buffer", -- Buffer completions
		"hrsh7th/cmp-cmdline", -- Cmdline completions
		"hrsh7th/cmp-path", -- Path completions
		"hrsh7th/cmp-nvim-lsp", -- LSP completions
		"hrsh7th/cmp-nvim-lua", -- Neovim Lua API completions
		"saadparwaiz1/cmp_luasnip", -- Snippet completions
		{
			"L3MON4D3/LuaSnip",
			version = "2.*",
			build = "make install_jsregexp",
			dependencies = { "rafamadriz/friendly-snippets" },
		},
	},
	config = function()
		-- Configuration for nvim-cmp
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		local function get_doc_text(entry)
			local doc = entry.completion_item.documentation
			if not doc then
				return nil
			end
			if type(doc) == "string" then
				return doc
			elseif type(doc) == "table" and doc.value then
				return doc.value
			end
			return nil
		end

		cmp.setup({
			window = {
				completion = {
					border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
				},
				documentation = {
					border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
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
			formatting = {
				fields = { "abbr", "menu" },
				format = function(entry, vim_item)
					local path = entry.completion_item.detail

					if path then
						local max_length = 20
						if #path > max_length then
							vim_item.menu = " " .. path:sub(1, max_length)
						else
							vim_item.menu = " " .. entry.completion_item.detail
						end
					end

					return vim_item
				end,
			},
			sorting = {
				priority_weight = 2,
				comparators = {
					-- Put required props first
					function(entry1, entry2)
						local doc1 = get_doc_text(entry1)
						local doc2 = get_doc_text(entry2)

						local is_required1 = doc1 and doc1:match("required")
						local is_required2 = doc2 and doc2:match("required")

						if is_required1 and not is_required2 then
							return true
						elseif not is_required1 and is_required2 then
							return false
						end
						return nil
					end,
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
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
