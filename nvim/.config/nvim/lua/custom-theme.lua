local M = {}

-- Theme Variants
local themes = {
    sage = "#869782",
    ocean = "#7aa2b3",
    amber = "#b39169",
    rose = "#b37a8b",
    slate = "#8691a3",
    olive = "#96a369",
    plum = "#9b7aa3",
    copper = "#b38969",
    sea = "#5f8786",
    honey = "#edcb6c",
}

function M.setup(opts)
    opts = opts or {}
    local theme = opts.theme or "sage"

    -- Core colors
    local colors = {
        background = "#121212",
        primary = themes[theme],

        surface_0 = "#ffffff", -- 255
        surface_1 = "#e8e8e8", -- 232
        surface_2 = "#d1d1d1", -- 209
        surface_3 = "#bababa", -- 186
        surface_4 = "#a3a3a3", -- 163
        surface_5 = "#8c8c8c", -- 140
        surface_6 = "#757575", -- 117
        surface_7 = "#5e5e5e", -- 94
        surface_8 = "#474747", -- 71
        surface_9 = "#303030", -- 48
        surface_10 = "#191919", -- 25
        black = "#000000", -- 0

        -- Additional
        cursorLineNr = "#bababa",
        lineNr = "#474747",
        yellow = "#e6dc44",
        lilac = "#b39bc8",

        -- Diff colors
        diff_add = "#869782",
        diff_add_bg = "#1d2520",
        diff_delete = "#b37a7a",
        diff_delete_bg = "#251d1d",
        -- diff_delete = "#b38080", -- slightly warmer dusty red
        -- diff_delete_bg = "#2a2020", -- dark warm red background
    }

    -- Clear and set basics
    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") == 1 then
        vim.cmd("syntax reset")
    end
    vim.o.background = "dark"
    vim.g.colors_name = "custom"

    -- Helper function for cleaner syntax
    local hl = vim.api.nvim_set_hl

    -- ==========================================
    -- Neovim Core
    -- ==========================================
    --
    -- Core syntax
    hl(0, "@variable", { fg = colors.surface_3 })
    hl(0, "@function", { fg = colors.surface_2 })
    hl(0, "@function.call", { fg = colors.surface_2 })
    hl(0, "@keyword", { fg = colors.surface_5 })
    hl(0, "@keyword.return", { fg = colors.primary })
    hl(0, "@keyword.function", { fg = colors.surface_5 })
    hl(0, "@string", { fg = colors.primary })
    hl(0, "@number", { fg = colors.surface_3 })
    hl(0, "@boolean", { fg = colors.surface_3 })
    hl(0, "@comment", { fg = colors.surface_8 })
    hl(0, "@type", { fg = colors.primary })
    hl(0, "@constant", { fg = colors.surface_3 })
    hl(0, "@operator", { fg = colors.surface_5 })

    -- Structure
    hl(0, "@parameter", { fg = colors.surface_3 })
    hl(0, "@property", { fg = colors.surface_2 })
    hl(0, "@field", { fg = colors.surface_2 })
    hl(0, "@punctuation.bracket", { fg = colors.surface_5 })
    hl(0, "@punctuation.delimiter", { fg = colors.surface_5 })

    -- Additional common groups
    hl(0, "@tag", { fg = colors.surface_6 })
    hl(0, "@tag.delimiter", { fg = colors.surface_4 })
    hl(0, "@tag.attribute", { fg = colors.surface_7 })
    hl(0, "@constructor", { fg = colors.surface_6 })
    hl(0, "@namespace", { fg = colors.surface_2 })
    hl(0, "@label", { fg = colors.primary })

    -- UI groups
    hl(0, "MatchParen", { fg = colors.primary, bold = true })
    hl(0, "Directory", { fg = colors.primary })

    -- Editor UI essentials
    hl(0, "VertSplit", { fg = colors.surface_8, bg = colors.background }) -- legacy name
    hl(0, "WinSeparator", { fg = colors.surface_8, bg = colors.background }) -- current name
    hl(0, "SignColumn", { fg = colors.surface_5, bg = colors.background })
    hl(0, "EndOfBuffer", { fg = colors.surface_8 })
    hl(0, "NonText", { fg = colors.surface_8 }) -- for listchars
    hl(0, "Whitespace", { fg = colors.surface_8 }) -- for trailing spaces

    -- Cursor & current line
    hl(0, "CursorLine", { bg = colors.surface_9 })
    hl(0, "CursorColumn", { bg = colors.surface_9 })
    hl(0, "ColorColumn", { bg = colors.surface_9 })
    hl(0, "LineNr", { fg = colors.lineNr, bg = colors.background })
    hl(0, "CursorLineNr", { fg = colors.cursorLineNr, bg = colors.background })

    hl(0, "Normal", { fg = colors.surface_3, bg = colors.background })
    hl(0, "NormalNC", { fg = colors.surface_4, bg = colors.background })

    -- Visual selection
    hl(0, "Visual", { bg = colors.surface_8 })
    hl(0, "VisualNOS", { bg = colors.surface_8 })

    -- Search
    hl(0, "Search", { fg = colors.background, bg = colors.yellow })
    hl(0, "IncSearch", { fg = colors.background, bg = colors.primary })
    hl(0, "CurSearch", { fg = colors.background, bg = colors.primary })

    -- Popup menus (autocomplete, etc)
    hl(0, "Pmenu", { fg = colors.surface_3, bg = colors.surface_9 })
    hl(0, "PmenuSel", { fg = colors.background, bg = colors.primary })
    hl(0, "PmenuSbar", { bg = colors.surface_8 })
    hl(0, "PmenuThumb", { bg = colors.surface_6 })

    -- Messages & prompts
    hl(0, "ModeMsg", { fg = colors.primary })
    hl(0, "MoreMsg", { fg = colors.primary })
    hl(0, "Question", { fg = colors.primary })
    hl(0, "ErrorMsg", { fg = colors.diff_delete })
    hl(0, "WarningMsg", { fg = colors.yellow })

    -- Folding
    hl(0, "Folded", { fg = colors.surface_5, bg = colors.surface_9 })
    hl(0, "FoldColumn", { fg = colors.surface_5, bg = colors.background })

    -- Additional syntax basics
    hl(0, "Statement", { fg = colors.primary })
    hl(0, "Operator", { fg = colors.surface_3 })
    hl(0, "Number", { fg = colors.surface_3 })
    hl(0, "Boolean", { fg = colors.surface_3 })
    hl(0, "MatchParen", { fg = colors.yellow, bold = true })
    hl(0, "Directory", { fg = colors.primary })
    hl(0, "Special", { fg = colors.surface_2 })

    -- Window Dimming (inactive buffers)
    hl(0, "NormalDim", { bg = "#212121", fg = "#aaaaaa" })
    hl(0, "LineNrDim", { bg = "#212121", fg = "#313131" })
    hl(0, "CursorLineNrDim", { bg = "#212121", fg = "#313131" })
    hl(0, "SignColumnDim", { bg = "#212121", fg = "#aaaaaa" })

    -- MsgArea customization
    hl(0, "MsgArea", { bg = "#282c34" })

    -- Diffview
    hl(0, "DiffviewDiffAdd", { fg = colors.diff_add, bg = colors.diff_add_bg })
    hl(0, "DiffviewDiffDelete", { fg = colors.diff_delete, bg = colors.diff_delete_bg })
    hl(0, "DiffviewDiffAddAsDelete", { fg = colors.diff_delete, bg = colors.diff_delete_bg })
    hl(0, "DiffviewDiffText", { fg = colors.surface_0, bg = colors.diff_add_bg }) -- highlighted changes within lines

    -- Standard Vim diff highlights (used by Diffview)
    hl(0, "DiffAdd", { fg = colors.diff_add, bg = colors.diff_add_bg })
    hl(0, "DiffDelete", { fg = colors.diff_delete, bg = colors.diff_delete_bg })
    hl(0, "DiffChange", { fg = colors.surface_3, bg = colors.surface_9 })
    hl(0, "DiffText", { fg = colors.surface_0, bg = colors.diff_add_bg })

    -- ==========================================
    -- FZF Lua
    -- ==========================================
    hl(0, "FzfLuaPreviewBorder", { fg = colors.surface_8, bg = colors.background })
    hl(0, "FzfLuaFzfScrollbar", { fg = colors.surface_8, bg = colors.background })

    -- ==========================================
    -- Neogit
    -- ==========================================
    hl(0, "NeogitDiffAdd", { fg = colors.diff_add, bg = colors.background })
    hl(0, "NeogitDiffAddHighlight", { fg = colors.diff_add, bg = colors.diff_add_bg })
    hl(0, "NeogitDiffDelete", { fg = colors.diff_delete, bg = colors.background })
    hl(0, "NeogitDiffDeleteHighlight", { fg = colors.diff_delete, bg = colors.diff_delete_bg })
    hl(0, "NeogitDiffContext", { fg = colors.surface_4, bg = colors.background })
    hl(0, "NeogitDiffContextHighlight", { fg = colors.surface_3, bg = colors.surface_9 })
    hl(0, "NeogitHunkHeader", { fg = colors.primary, bg = colors.background })
    hl(0, "NeogitHunkHeaderHighlight", { fg = colors.primary, bg = colors.surface_9 })

    -- ==========================================
    -- Diffview
    -- ==========================================
    hl(0, "DiffviewDiffAdd", { fg = colors.diff_add, bg = colors.diff_add_bg })
    hl(0, "DiffviewDiffAddAsDelete", { fg = colors.diff_delete, bg = colors.diff_delete_bg })
    hl(0, "DiffviewDiffDelete", { fg = colors.surface_6, bg = colors.diff_delete_bg })
    hl(0, "DiffviewDiffChange", { fg = colors.yellow, bg = colors.background })
    hl(0, "DiffviewDiffText", { fg = colors.yellow, bg = colors.surface_8 })
    hl(0, "DiffviewDiffLine", { fg = colors.primary, bg = colors.background })
    hl(0, "DiffviewReference", { fg = colors.primary, bg = colors.background })
    hl(0, "DiffviewFilePanelTitle", { fg = colors.primary, bg = colors.background })
    hl(0, "DiffviewFilePanelCounter", { fg = colors.surface_5, bg = colors.background })
    hl(0, "DiffviewFilePanelFileName", { fg = colors.surface_2, bg = colors.background })
    hl(0, "DiffviewFilePanelPath", { fg = colors.surface_5, bg = colors.background })
    hl(0, "DiffviewFilePanelInsertions", { fg = colors.diff_add, bg = colors.background })
    hl(0, "DiffviewFilePanelDeletions", { fg = colors.diff_delete, bg = colors.background })
    hl(0, "DiffviewFilePanelSelected", { fg = colors.primary, bg = colors.background })
    hl(0, "DiffviewStatusAdded", { fg = colors.diff_add, bg = colors.background })
    hl(0, "DiffviewStatusModified", { fg = colors.yellow, bg = colors.background })
    hl(0, "DiffviewStatusRenamed", { fg = colors.primary, bg = colors.background })
    hl(0, "DiffviewStatusDeleted", { fg = colors.diff_delete, bg = colors.background })
    hl(0, "DiffviewStatusUntracked", { fg = colors.surface_5, bg = colors.background })
    hl(0, "DiffviewFolderName", { fg = colors.primary, bg = colors.background })
    hl(0, "DiffviewFolderSign", { fg = colors.surface_6, bg = colors.background })
    hl(0, "DiffviewNormal", { fg = colors.surface_3, bg = colors.background })
    hl(0, "DiffviewVertSplit", { fg = colors.surface_6, bg = colors.background })
    hl(0, "DiffviewEndOfBuffer", { fg = colors.surface_8, bg = colors.background })
    hl(0, "DiffviewCursorLine", { bg = colors.surface_9 })

    -- Float window backgrounds
    hl(0, "NormalFloat", { fg = colors.surface_3, bg = colors.black })
    hl(0, "FloatBorder", { fg = colors.surface_8, bg = colors.black })
    hl(0, "FloatTitle", { fg = colors.surface_7, bg = colors.black })

    -- ==========================================
    -- Status Line (Inverted)
    -- ==========================================
    hl(0, "StatusLine", { fg = colors.surface_9, bg = colors.surface_6 }) -- Light bg, dark text
    hl(0, "StatusLineNC", { fg = colors.surface_8, bg = colors.surface_6 }) -- Slightly dimmer

    -- ==========================================
    -- Command Line / Messages (Inverted)
    -- ==========================================
    hl(0, "MsgArea", { fg = colors.surface_2, bg = colors.black })
    hl(0, "CmdLine", { fg = colors.surface_9, bg = colors.surface_6 })
    hl(0, "CmdLinePrompt", { fg = colors.primary, bg = colors.surface_3 }) -- Primary accent

    -- Mode messages
    hl(0, "ModeMsg", { fg = colors.surface_9, bg = colors.surface_3, bold = true })
    hl(0, "MoreMsg", { fg = colors.surface_9, bg = colors.surface_3 })

    -- Mini.statusline highlight groups
    hl(0, "MiniStatuslineModeNormal", { fg = colors.surface_2, bg = colors.surface_9 })
    hl(0, "MiniStatuslineModeInsert", { fg = colors.black, bg = colors.yellow })
    hl(0, "MiniStatuslineModeVisual", { fg = colors.black, bg = colors.lilac })
    hl(0, "MiniStatuslineModeReplace", { fg = colors.black, bg = colors.diff_delete })
    hl(0, "MiniStatuslineModeCommand", { fg = colors.black, bg = colors.surface_2 })
    hl(0, "MiniStatuslineModeOther", { fg = colors.surface_9, bg = colors.surface_4 })
    hl(0, "MiniStatuslineDevinfo", { fg = colors.lilac, bg = colors.black })
    hl(0, "MiniStatuslineFileinfo", { fg = colors.surface_6, bg = colors.black })
    hl(0, "MiniStatuslineFilename", { fg = colors.surface_6, bg = colors.black })
    hl(0, "MiniStatuslineInactive", { fg = colors.surface_6, bg = colors.surface_10 })

    -- ==========================================
    -- Lualine Theme Generation
    -- ==========================================
    local lualine_theme = {
        normal = {
            a = { fg = colors.surface_2, bg = colors.surface_9, gui = "bold" },
            b = { fg = colors.lilac, bg = colors.black },
            c = { fg = colors.surface_6, bg = colors.black },
        },
        insert = {
            a = { fg = colors.black, bg = themes.sage, gui = "bold" },
            b = { fg = colors.lilac, bg = colors.black },
            c = { fg = colors.surface_6, bg = colors.black },
        },
        visual = {
            a = { fg = colors.black, bg = colors.lilac, gui = "bold" },
            b = { fg = colors.lilac, bg = colors.black },
            c = { fg = colors.surface_6, bg = colors.black },
        },
        replace = {
            a = { fg = colors.black, bg = colors.diff_delete, gui = "bold" },
            b = { fg = colors.lilac, bg = colors.black },
            c = { fg = colors.surface_6, bg = colors.black },
        },
        command = {
            a = { fg = colors.black, bg = colors.surface_2, gui = "bold" },
            b = { fg = colors.lilac, bg = colors.black },
            c = { fg = colors.surface_6, bg = colors.black },
        },
        inactive = {
            a = { fg = colors.surface_6, bg = colors.surface_10 },
            b = { fg = colors.surface_6, bg = colors.surface_10 },
            c = { fg = colors.surface_6, bg = colors.surface_10 },
        },
    }

    package.loaded["lualine.themes.custom"] = lualine_theme
end

-- Quick theme switcher function
function M.switch(theme)
    M.setup({ theme = theme })
end

return M
