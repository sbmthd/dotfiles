return {
    "MeanderingProgrammer/render-markdown.nvim",
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons

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
        -- Set up code block backgrounds using plugin's highlight groups
        vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = colors.gray2 }) -- For code block background
        vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { bg = colors.gray2 }) -- For inline code background
        vim.api.nvim_set_hl(0, "RenderMarkdownCodeBlock", { fg = colors.gray2, bg = colors.gray2 })

        require("render-markdown").setup({
            padding = {
                -- Highlight to use when adding whitespace, should match background
                highlight = "Normal",
            },
            -- Mimic org-indent-mode behavior by indenting everything under a heading based on the
            -- level of the heading. Indenting starts from level 2 headings onward.
            indent = {
                -- Turn on / off org-indent-mode
                enabled = true,
                -- Additional modes to render indents
                render_modes = false,
                -- Amount of additional padding added for each heading level
                per_level = 4,
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
                border = "none",
                left_pad = 0,
                right_pad = 0,
                min_width = 120,
                -- highlight = "RenderMarkdownCode",
                -- highlight_inline = "RenderMarkdownCodeInline",
                -- highlight_language = "RenderMarkdownInlineHighlight",
            },
        })
    end,
}
