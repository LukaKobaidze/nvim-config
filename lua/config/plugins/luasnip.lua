return {
	"L3MON4D3/LuaSnip",
	config = function()
		local ls = require("luasnip")
		local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node
		local f = ls.function_node

		vim.keymap.set({ "i", "s" }, "<C-L>", function()
			ls.jump(1)
		end, { silent = true })

		local filename = function()
			return vim.fn.fnamemodify(vim.fn.expand("%"), ":t:r")
		end
		local directoryname = function()
			return "directoryname"
		end

		ls.add_snippets("typescriptreact", {
			s("tsxf", {
				t("import styles from './"),
				f(filename),
				t({ ".module.scss';", "", "" }),
				t("export type "),
				f(filename),
				t("Props = {"),
				i(2),
				t({ "};", "", "" }),
				t("export default function "),
				f(filename),
				t("(props: "),
				f(filename),
				t({ "Props) {", "" }),
				t("  const { "),
				i(3),
				t({ " } = props;", "", "" }),
				t("  return "),
				i(1),
				t({ "", "}" }),
			}),
		})

		ls.add_snippets("typescript", {
			s("reexport", {
				t("import "),
				f(directoryname),
				t(" from './"),
				f(directoryname),
				t({ "';", "", "export * from './" }),
				f(directoryname),
				t({ "';", "export default " }),
				f(directoryname),
				t(";"),
			}),
		})
	end,
}
