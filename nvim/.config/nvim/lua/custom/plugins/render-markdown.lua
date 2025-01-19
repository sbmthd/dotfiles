return {
	"MeanderingProgrammer/render-markdown.nvim",
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
	---@module 'render-markdown'
	---@type render.md.UserConfig
	---
	config = function()
		-- Lackluster color palette
		local colors = {
			-- Grays
			gray1 = "#080808",
			gray2 = "#191919",
			gray3 = "#2A2A2A",
			gray4 = "#444444",
			gray5 = "#555555",
			gray6 = "#7A7A7A",
			gray7 = "#AAAAAA",
			gray8 = "#CCCCCC",
			gray9 = "#DDDDDD",
			-- Base colors
			black = "#000000",
			error = "#D70000",
			warn = "#FFAA88",
			special = "#789978",
			hint = "#7788AA",
			lack = "#708090",
			luster = "#DEEEED",
		}
		-- Set up plugin treesitter markdown highlight groups
		-- Heading and signs icons
		vim.api.nvim_set_hl(0, "RenderMarkdownH1", { fg = colors.lack })
		vim.api.nvim_set_hl(0, "RenderMarkdownH2", { fg = colors.special })
		vim.api.nvim_set_hl(0, "RenderMarkdownH3", { fg = colors.special })
		vim.api.nvim_set_hl(0, "RenderMarkdownH4", { fg = colors.special })
		vim.api.nvim_set_hl(0, "RenderMarkdownH5", { fg = colors.special })
		vim.api.nvim_set_hl(0, "RenderMarkdownH6", { fg = colors.special })
		-- Heading text
		vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { fg = colors.lack })
		vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { fg = colors.special })
		vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", { fg = colors.special })
		vim.api.nvim_set_hl(0, "@markup.heading.4.markdown", { fg = colors.special })
		vim.api.nvim_set_hl(0, "@markup.heading.5.markdown", { fg = colors.special })
		vim.api.nvim_set_hl(0, "@markup.heading.6.markdown", { fg = colors.special })
		-- Bullet points
		vim.api.nvim_set_hl(0, "RenderMarkdownBullet", { fg = colors.special })
		-- Paragraph text
		vim.api.nvim_set_hl(0, "@text.inline.markdown", { fg = colors.black })
		vim.api.nvim_set_hl(0, "@text.paragraph.markdown", { fg = colors.black })
		vim.api.nvim_set_hl(0, "@paragraph.markdown", { fg = colors.black })
		vim.api.nvim_set_hl(0, "@markup.raw.markdown", { fg = colors.black })
		-- Set up code block backgrounds using plugin's highlight groups
		vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "NONE" }) -- For code block background
		vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { bg = "NONE" }) -- For inline code background
		-- vim.api.nvim_set_hl(0, "RenderMarkdownCodeBlock", { fg = colors.special, bg = "NONE" })

		-- General syntax highlighting for all languages
		-- vim.api.nvim_set_hl(0, "@keyword", { fg = colors.error }) -- for keywords
		-- vim.api.nvim_set_hl(0, "@string", { fg = colors.special }) -- for strings
		-- vim.api.nvim_set_hl(0, "@number", { fg = colors.hint }) -- for numbers
		-- vim.api.nvim_set_hl(0, "@function", { fg = colors.lack }) -- for functions
		-- vim.api.nvim_set_hl(0, "@variable", { fg = colors.gray8 }) -- for variables
		-- vim.api.nvim_set_hl(0, "@constant", { fg = colors.warn }) -- for constants
		-- vim.api.nvim_set_hl(0, "@operator", { fg = colors.gray7 }) -- for operators
		-- vim.api.nvim_set_hl(0, "@punctuation", { fg = colors.gray6 }) -- for punctuation
		-- vim.api.nvim_set_hl(0, "@comment", { fg = colors.gray4 }) -- for comments
		--
		-- -- These should cover most syntax elements across different languages
		-- vim.api.nvim_set_hl(0, "@type", { fg = colors.hint })
		-- vim.api.nvim_set_hl(0, "@property", { fg = colors.lack })
		-- vim.api.nvim_set_hl(0, "@parameter", { fg = colors.special })

		require("render-markdown").setup({
			-- Mimic org-indent-mode behavior by indenting everything under a heading based on the
			-- level of the heading. Indenting starts from level 2 headings onward.
			indent = {
				-- Turn on / off org-indent-mode
				enabled = true,
				-- Additional modes to render indents
				render_modes = false,
				-- Amount of additional padding added for each heading level
				per_level = 3,
				-- Heading levels <= this value will not be indented
				-- Use 0 to begin indenting from the very first level
				skip_level = 0,
				-- Do not indent heading titles, only the body
				skip_heading = true,
			},
			heading = {
				backgrounds = {},
				foregrounds = {
					"RenderMarkdownH1",
					"RenderMarkdownH2",
					"RenderMarkdownH3",
					"RenderMarkdownH4",
					"RenderMarkdownH5",
					"RenderMarkdownH6",
				},
				icons = { " ", " ", " ", " ", " ", " " },
			},
			paragraph = {},
			bullet = {
				icons = { "", "", "", "" },
			},
			checkbox = {
				unchecked = { icon = "✘ " },
				checked = { icon = "✔ ", scope_highlight = "@markup.strikethrough" },
			},
			code = {
				style = "full",
				-- language_pad = 2,
				width = "block",
				border = false,
				left_pad = 6,
				-- right_pad = 4,
				min_width = 60,
				-- highlight = "RenderMarkdownCode",
				-- highlight_inline = "RenderMarkdownCodeInline",
				-- highlight_language = "RenderMarkdownInlineHighlight",
			},
		})
	end,
}
