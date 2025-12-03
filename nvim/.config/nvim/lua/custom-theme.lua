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

        noir_0 = "#ffffff",
        noir_1 = "#f5f5f5",
        noir_2 = "#d5d5d5",
        noir_3 = "#b4b4b4",
        noir_4 = "#a7a7a7",
        noir_5 = "#949494",
        noir_6 = "#737373",
        noir_7 = "#535353",
        noir_8 = "#323232",
        noir_9 = "#212121",
        noir_10 = "#181818",
        black = "#000000",

        -- Additional
        cursorLineNr = "#949494",
        lineNr = "#535353",
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
    hl(0, "Normal", { fg = colors.noir_3, bg = colors.background })
    hl(0, "NormalNC", { fg = colors.noir_4, bg = colors.background })
    hl(0, "LineNr", { fg = colors.lineNr, bg = colors.background })
    hl(0, "CursorLineNr", { fg = colors.cursorLineNr, bg = colors.background })
    hl(0, "Comment", { fg = colors.lineNr })
    --
    -- Core syntax
    hl(0, "@variable", { fg = colors.noir_3 })
    hl(0, "@function", { fg = colors.noir_2 })
    hl(0, "@function.call", { fg = colors.noir_2 })
    hl(0, "@keyword", { fg = colors.noir_5 })
    hl(0, "@keyword.return", { fg = colors.primary })
    hl(0, "@keyword.function", { fg = colors.noir_5 })
    hl(0, "@string", { fg = colors.primary })
    hl(0, "@number", { fg = colors.noir_3 })
    hl(0, "@boolean", { fg = colors.noir_3 })
    hl(0, "@comment", { fg = colors.noir_7 })
    hl(0, "@type", { fg = colors.primary })
    hl(0, "@constant", { fg = colors.noir_2 })
    hl(0, "@operator", { fg = colors.noir_5 })

    -- Structure
    hl(0, "@parameter", { fg = colors.noir_3 })
    hl(0, "@property", { fg = colors.noir_2 })
    hl(0, "@field", { fg = colors.noir_2 })
    hl(0, "@punctuation.bracket", { fg = colors.noir_5 })
    hl(0, "@punctuation.delimiter", { fg = colors.noir_5 })

    -- Additional common groups
    hl(0, "@tag", { fg = colors.noir_3 })
    hl(0, "@tag.attribute", { fg = colors.noir_6 })
    hl(0, "@constructor", { fg = colors.primary })
    hl(0, "@namespace", { fg = colors.noir_2 })
    hl(0, "@label", { fg = colors.primary })

    -- UI groups
    hl(0, "MatchParen", { fg = colors.primary, bold = true })
    hl(0, "Directory", { fg = colors.primary })

    -- Editor UI essentials
    hl(0, "VertSplit", { fg = colors.noir_8, bg = colors.background }) -- legacy name
    hl(0, "WinSeparator", { fg = colors.noir_8, bg = colors.background }) -- current name
    hl(0, "SignColumn", { fg = colors.noir_5, bg = colors.background })
    hl(0, "EndOfBuffer", { fg = colors.noir_8 })
    hl(0, "NonText", { fg = colors.noir_8 }) -- for listchars
    hl(0, "Whitespace", { fg = colors.noir_8 }) -- for trailing spaces

    -- Cursor & current line
    hl(0, "CursorLine", { bg = colors.noir_9 })
    hl(0, "CursorColumn", { bg = colors.noir_9 })
    hl(0, "ColorColumn", { bg = colors.noir_9 })

    -- Visual selection
    hl(0, "Visual", { bg = colors.noir_8 })
    hl(0, "VisualNOS", { bg = colors.noir_8 })

    -- Search
    hl(0, "Search", { fg = colors.background, bg = colors.yellow })
    hl(0, "IncSearch", { fg = colors.background, bg = colors.primary })
    hl(0, "CurSearch", { fg = colors.background, bg = colors.primary })

    -- Popup menus (autocomplete, etc)
    hl(0, "Pmenu", { fg = colors.noir_3, bg = colors.noir_9 })
    hl(0, "PmenuSel", { fg = colors.background, bg = colors.primary })
    hl(0, "PmenuSbar", { bg = colors.noir_8 })
    hl(0, "PmenuThumb", { bg = colors.noir_6 })

    -- Messages & prompts
    hl(0, "ModeMsg", { fg = colors.primary })
    hl(0, "MoreMsg", { fg = colors.primary })
    hl(0, "Question", { fg = colors.primary })
    hl(0, "ErrorMsg", { fg = colors.diff_delete })
    hl(0, "WarningMsg", { fg = colors.yellow })

    -- Folding
    hl(0, "Folded", { fg = colors.noir_5, bg = colors.noir_9 })
    hl(0, "FoldColumn", { fg = colors.noir_5, bg = colors.background })

    -- Additional syntax basics
    hl(0, "Statement", { fg = colors.primary })
    hl(0, "Operator", { fg = colors.noir_3 })
    hl(0, "Number", { fg = colors.noir_3 })
    hl(0, "Boolean", { fg = colors.noir_3 })
    hl(0, "MatchParen", { fg = colors.yellow, bold = true })
    hl(0, "Directory", { fg = colors.primary })
    hl(0, "Special", { fg = colors.noir_2 })

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
    hl(0, "DiffviewDiffText", { fg = colors.noir_0, bg = colors.diff_add_bg }) -- highlighted changes within lines

    -- Standard Vim diff highlights (used by Diffview)
    hl(0, "DiffAdd", { fg = colors.diff_add, bg = colors.diff_add_bg })
    hl(0, "DiffDelete", { fg = colors.diff_delete, bg = colors.diff_delete_bg })
    hl(0, "DiffChange", { fg = colors.noir_3, bg = colors.noir_9 })
    hl(0, "DiffText", { fg = colors.noir_0, bg = colors.diff_add_bg })

    -- ==========================================
    -- FZF Lua
    -- ==========================================
    -- hl(0, "FzfLuaNormal", { fg = colors.noir_4, bg = colors.black })
    -- hl(0, "FzfLuaBorder", { fg = colors.noir_6, bg = colors.black })
    -- hl(0, "FzfLuaTitle", { fg = colors.primary, bg = colors.black })
    -- hl(0, "FzfLuaPreviewTitle", { fg = colors.primary, bg = colors.black })
    hl(0, "FzfLuaPreviewBorder", { fg = colors.noir_8, bg = colors.background })
    hl(0, "FzfLuaFzfScrollbar", { fg = colors.noir_8, bg = colors.background })
    -- hl(0, "FzfLuaPreviewNormal", { fg = colors.noir_3, bg = colors.black })
    -- hl(0, "FzfLuaCursor", { fg = colors.background, bg = colors.primary })
    -- hl(0, "FzfLuaSearch", { fg = colors.yellow, bg = colors.black })
    -- hl(0, "FzfLuaScrollBorderEmpty", { fg = colors.noir_6, bg = colors.black })
    -- hl(0, "FzfLuaScrollBorderFull", { fg = colors.primary, bg = colors.black })
    -- hl(0, "FzfLuaHeaderBind", { fg = colors.primary, bg = colors.black })
    -- hl(0, "FzfLuaHeaderText", { fg = colors.noir_5, bg = colors.black })
    -- hl(0, "FzfLuaPathLineNr", { fg = colors.yellow, bg = colors.black })
    -- hl(0, "FzfLuaPathColNr", { fg = colors.yellow, bg = colors.black })
    -- hl(0, "FzfLuaBufName", { fg = colors.primary, bg = colors.black })
    -- hl(0, "FzfLuaBufNr", { fg = colors.noir_5, bg = colors.black })
    -- hl(0, "FzfLuaTabTitle", { fg = colors.noir_2, bg = colors.black })
    -- hl(0, "FzfLuaTabMarker", { fg = colors.primary, bg = colors.black })
    -- hl(0, "FzfLuaCursorLine", { fg = colors.cursorLineNr, bg = colors.black })
    -- hl(0, "FzfLuaCursorLineNr", { fg = colors.cursorLineNr, bg = colors.black })
    -- hl(0, "FzfLuaLineNr", { fg = colors.cursorLineNr, bg = colors.black })
    -- hl(0, "FzfLuaPreviewLineNr", { fg = colors.lineNr, bg = colors.black })
    -- hl(0, "FzfLuaSignColumn", { fg = colors.noir_4, bg = colors.black })
    -- hl(0, "FzfLuaSignColumn", { fg = colors.noir_4, bg = colors.black })
    -- hl(0, "FzfLuaFzfMatch", { fg = colors.noir_4, bg = colors.black })
    -- hl(0, "FzfLuaDirPart", { fg = colors.noir_4, bg = colors.black })
    -- hl(0, "FzfLuaFilePart", { fg = colors.noir_4, bg = colors.black })
    -- hl(0, "FzfLuaFzfInfo", { fg = colors.noir_4, bg = colors.black })
    --
    -- ==========================================
    -- Neogit
    -- ==========================================
    hl(0, "NeogitDiffAdd", { fg = colors.diff_add, bg = colors.background })
    hl(0, "NeogitDiffAddHighlight", { fg = colors.diff_add, bg = colors.diff_add_bg })
    hl(0, "NeogitDiffDelete", { fg = colors.diff_delete, bg = colors.background })
    hl(0, "NeogitDiffDeleteHighlight", { fg = colors.diff_delete, bg = colors.diff_delete_bg })
    hl(0, "NeogitDiffContext", { fg = colors.noir_4, bg = colors.background })
    hl(0, "NeogitDiffContextHighlight", { fg = colors.noir_3, bg = colors.noir_9 })
    hl(0, "NeogitHunkHeader", { fg = colors.primary, bg = colors.background })
    hl(0, "NeogitHunkHeaderHighlight", { fg = colors.primary, bg = colors.noir_9 })

    -- ==========================================
    -- Diffview
    -- ==========================================
    hl(0, "DiffviewDiffAdd", { fg = colors.diff_add, bg = colors.diff_add_bg })
    hl(0, "DiffviewDiffAddAsDelete", { fg = colors.diff_delete, bg = colors.diff_delete_bg })
    hl(0, "DiffviewDiffDelete", { fg = colors.noir_6, bg = colors.diff_delete_bg })
    hl(0, "DiffviewDiffChange", { fg = colors.yellow, bg = colors.background })
    hl(0, "DiffviewDiffText", { fg = colors.yellow, bg = colors.noir_8 })
    hl(0, "DiffviewDiffLine", { fg = colors.primary, bg = colors.background })
    hl(0, "DiffviewReference", { fg = colors.primary, bg = colors.background })
    hl(0, "DiffviewFilePanelTitle", { fg = colors.primary, bg = colors.background })
    hl(0, "DiffviewFilePanelCounter", { fg = colors.noir_5, bg = colors.background })
    hl(0, "DiffviewFilePanelFileName", { fg = colors.noir_2, bg = colors.background })
    hl(0, "DiffviewFilePanelPath", { fg = colors.noir_5, bg = colors.background })
    hl(0, "DiffviewFilePanelInsertions", { fg = colors.diff_add, bg = colors.background })
    hl(0, "DiffviewFilePanelDeletions", { fg = colors.diff_delete, bg = colors.background })
    hl(0, "DiffviewFilePanelSelected", { fg = colors.primary, bg = colors.background })
    hl(0, "DiffviewStatusAdded", { fg = colors.diff_add, bg = colors.background })
    hl(0, "DiffviewStatusModified", { fg = colors.yellow, bg = colors.background })
    hl(0, "DiffviewStatusRenamed", { fg = colors.primary, bg = colors.background })
    hl(0, "DiffviewStatusDeleted", { fg = colors.diff_delete, bg = colors.background })
    hl(0, "DiffviewStatusUntracked", { fg = colors.noir_5, bg = colors.background })
    hl(0, "DiffviewFolderName", { fg = colors.primary, bg = colors.background })
    hl(0, "DiffviewFolderSign", { fg = colors.noir_6, bg = colors.background })
    hl(0, "DiffviewNormal", { fg = colors.noir_3, bg = colors.background })
    hl(0, "DiffviewVertSplit", { fg = colors.noir_6, bg = colors.background })
    hl(0, "DiffviewEndOfBuffer", { fg = colors.noir_8, bg = colors.background })
    hl(0, "DiffviewCursorLine", { bg = colors.noir_9 })

    -- Float window backgrounds
    hl(0, "NormalFloat", { fg = colors.noir_3, bg = colors.black })
    hl(0, "FloatBorder", { fg = colors.noir_8, bg = colors.black })
    hl(0, "FloatTitle", { fg = colors.noir_7, bg = colors.black })

    -- ==========================================
    -- Status Line (Inverted)
    -- ==========================================
    hl(0, "StatusLine", { fg = colors.noir_9, bg = colors.noir_6 }) -- Light bg, dark text
    hl(0, "StatusLineNC", { fg = colors.noir_8, bg = colors.noir_6 }) -- Slightly dimmer

    -- ==========================================
    -- Command Line / Messages (Inverted)
    -- ==========================================
    hl(0, "MsgArea", { fg = colors.noir_9, bg = colors.noir_6 }) -- Match statusline
    hl(0, "CmdLine", { fg = colors.noir_9, bg = colors.noir_6 })
    hl(0, "CmdLinePrompt", { fg = colors.primary, bg = colors.noir_3 }) -- Primary accent

    -- Mode messages
    hl(0, "ModeMsg", { fg = colors.noir_9, bg = colors.noir_3, bold = true })
    hl(0, "MoreMsg", { fg = colors.noir_9, bg = colors.noir_3 })

    -- ==========================================
    -- Mode Indicators (for statusline)
    -- ==========================================
    hl(0, "MiniStatuslineModeNormal", { fg = colors.noir_9, bg = colors.noir_3 })
    hl(0, "MiniStatuslineModeInsert", { fg = colors.background, bg = colors.yellow })
    hl(0, "MiniStatuslineModeVisual", { fg = colors.background, bg = colors.lilac })
    hl(0, "MiniStatuslineModeReplace", { fg = colors.background, bg = colors.diff_delete })
    hl(0, "MiniStatuslineModeCommand", { fg = colors.background, bg = colors.primary })
    hl(0, "MiniStatuslineModeOther", { fg = colors.noir_9, bg = colors.noir_4 })

    -- Corrected Mayhem colors
    local mayhem_bg = "#000000" -- Nearly black background (color 0)
    local mayhem_fg = "#e8e8e8" -- Light foreground (color 7/15)
    local mayhem_cyan = "#5f8786" -- Cyan (color 1/9)
    local mayhem_cream = "#ffffdf" -- Cream (color 2/10)
    local mayhem_yellow = "#ffdf87" -- Yellow (color 3/11)
    local mayhem_gray_dark = "#3f3f3f" -- Dark gray (color 4/12)
    local mayhem_gray = "#626262" -- Medium gray (color 8)
    local mayhem_gray_med = "#9e9e9e" -- Medium-light gray (color 5/13)
    local mayhem_gray_light = "#bcbcbc" -- Light gray (color 6/14)

    -- Update your statusline highlights with the darker background
    hl(0, "StatusLine", { fg = mayhem_fg, bg = mayhem_bg })
    hl(0, "StatusLineNC", { fg = mayhem_gray, bg = mayhem_bg })

    -- Mode indicators
    hl(0, "MiniStatuslineModeNormal", { fg = mayhem_fg, bg = mayhem_gray_dark })
    hl(0, "MiniStatuslineModeInsert", { fg = mayhem_bg, bg = mayhem_yellow })
    hl(0, "MiniStatuslineModeVisual", { fg = mayhem_bg, bg = mayhem_cyan })
    hl(0, "MiniStatuslineModeCommand", { fg = mayhem_bg, bg = mayhem_cream })

    -- Command line area
    hl(0, "MsgArea", { fg = mayhem_fg, bg = mayhem_bg })
end

-- Quick theme switcher function
function M.switch(theme)
    M.setup({ theme = theme })
end

return M
