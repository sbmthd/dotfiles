return {
	"mvllow/modes.nvim",
	tag = "v0.2.1",
	config = function()
		require("modes").setup({
			colors = {
				bg = "", -- Optional bg param, defaults to Normal hl group
				copy = "#ffaa88",
				delete = "#c75c6a",
				insert = "#789978",
				visual = "#b69bf1",
			},

			-- Set opacity for cursorline and number background
			line_opacity = 0.25,

			-- Enable cursor highlights
			set_cursor = false,

			-- Enable cursorline initially, and disable cursorline for inactive windows
			-- or ignored filetypes
			set_cursorline = true,

			-- Enable line number highlights to match cursorline
			set_number = true,

			-- Disable modes highlights in specified filetypes
			-- Please PR commonly ignored filetypes
			ignore_filetypes = { "NvimTree", "TelescopePrompt" },
		})
	end,
}
