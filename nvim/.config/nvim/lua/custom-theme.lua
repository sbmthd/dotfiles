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
}

function M.setup(opts)
    opts = opts or {}
    local theme = opts.theme or "sage"

    -- Core colors
    local colors = {
        background = "#1b1d1e",
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

        -- Additional
        cursorLineNr = "#737373",
        lineNr = "#535353",
        yellow = "#e6dc44",

        -- Diff colors
        diff_add = "#00ff77",
        diff_delete = "#ff0038",
        diff_add_bg = "#1d2520",
        diff_delete_bg = "#252029",
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
    hl(0, "String", { fg = colors.primary })
    hl(0, "Function", { fg = colors.noir_5 })
    hl(0, "Keyword", { fg = colors.noir_5 })
    hl(0, "Identifier", { fg = colors.noir_3 })
    hl(0, "Type", { fg = colors.noir_2 })
    hl(0, "Constant", { fg = colors.noir_3 })

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

    -- ==========================================
    -- FZF Lua
    -- ==========================================
    hl(0, "FzfLuaNormal", { fg = colors.noir_4, bg = colors.background })
    hl(0, "FzfLuaBorder", { fg = colors.noir_6, bg = colors.background })
    hl(0, "FzfLuaTitle", { fg = colors.primary, bg = colors.background })
    hl(0, "FzfLuaPreviewTitle", { fg = colors.primary, bg = colors.background })
    hl(0, "FzfLuaPreviewBorder", { fg = colors.noir_6, bg = colors.background })
    hl(0, "FzfLuaPreviewNormal", { fg = colors.noir_3, bg = colors.background })
    hl(0, "FzfLuaCursor", { fg = colors.background, bg = colors.primary })
    hl(0, "FzfLuaSearch", { fg = colors.yellow, bg = colors.background })
    hl(0, "FzfLuaScrollBorderEmpty", { fg = colors.noir_6, bg = colors.background })
    hl(0, "FzfLuaScrollBorderFull", { fg = colors.primary, bg = colors.background })
    hl(0, "FzfLuaHeaderBind", { fg = colors.primary, bg = colors.background })
    hl(0, "FzfLuaHeaderText", { fg = colors.noir_5, bg = colors.background })
    hl(0, "FzfLuaPathLineNr", { fg = colors.yellow, bg = colors.background })
    hl(0, "FzfLuaPathColNr", { fg = colors.yellow, bg = colors.background })
    hl(0, "FzfLuaBufName", { fg = colors.primary, bg = colors.background })
    hl(0, "FzfLuaBufNr", { fg = colors.noir_5, bg = colors.background })
    hl(0, "FzfLuaTabTitle", { fg = colors.noir_2, bg = colors.background })
    hl(0, "FzfLuaTabMarker", { fg = colors.primary, bg = colors.background })

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

    -- ==========================================
    -- WhichKey
    -- ==========================================
    -- Float window backgrounds (WhichKey uses these)
    hl(0, "NormalFloat", { fg = colors.noir_3, bg = "#121212" })
    hl(0, "FloatBorder", { fg = colors.noir_6, bg = "#121212" })
    hl(0, "FloatTitle", { fg = colors.noir_2, bg = "#212121" })

    -- hl(0, "WhichKey", { fg = colors.primary })
    -- hl(0, "WhichKeyGroup", { fg = colors.primary })
    -- hl(0, "WhichKeyDesc", { fg = colors.noir_3 })
    -- hl(0, "WhichKeySeperator", { fg = colors.noir_6 })
    -- hl(0, "WhichKeySeparator", { fg = colors.noir_6 }) -- both spellings
    -- hl(0, "WhichKeyFloat", { bg = colors.noir_7 })
    -- hl(0, "WhichKeyValue", { fg = colors.noir_5 })
    -- hl(0, "WhichKeyBorder", { fg = colors.noir_6, bg = colors.noir_7 })
end

-- Quick theme switcher function
function M.switch(theme)
    M.setup({ theme = theme })
end

return M
