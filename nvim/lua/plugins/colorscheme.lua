return {
	"craftzdog/solarized-osaka.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local hslutil = require("solarized-osaka.hsl")
		local hsl = hslutil.hslToHex

		require("solarized-osaka").setup({
			transparent = false,

			-- Color overrides
			on_colors = function(colors)
				-- Fix dark colors
				local darker = hsl(192, 100, 3)
				colors.base04 = darker
				colors.bg_popup = darker
				colors.bg_sidebar = darker
				colors.bg_float = darker
			end,

			-- Custom Highlights
			on_highlights = function(hl, c)
				hl.MatchParen = { fg = c.red100, bold = true }

				-- Treesitter Context
				hl.TreesitterContext = { bg = c.base03 }
				hl.TreesitterContextBottom = { sp = c.base01, underline = true }
			end
		})

		vim.cmd.colorscheme("solarized-osaka")
	end,
}
