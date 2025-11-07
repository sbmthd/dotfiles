return {
    "jesseleite/nvim-noirbuddy",
    dependencies = {
        { "tjdevries/colorbuddy.nvim" },
    },
    lazy = false,
    priority = 1000,
    config = function()
        -- ==========================================
        -- Theme Variants - just change active_theme
        -- ==========================================
        local themes = {
            sage = "#869782", -- Current sage green
            ocean = "#7aa2b3", -- Soft blue
            amber = "#b39169", -- Warm amber
            rose = "#b37a8b", -- Dusty rose
            slate = "#8691a3", -- Blue-gray
            olive = "#96a369", -- Yellow-green
            plum = "#9b7aa3", -- Muted purple
            copper = "#b38969", -- Copper/bronze
        }

        local active_theme = "sage" -- ← Change this to switch themes

        require("noirbuddy").setup({
            preset = "minimal",
            colors = {
                background = "#1b1d1e",
                diff_add = "#35F09D",
                diff_delete = "#BCA5F0",
                primary = themes[active_theme],
            },
        })

        local noirbuddy = require("noirbuddy.colors").all()
        local Group = require("colorbuddy").Group
        local Color = require("colorbuddy").Color

        -- ==========================================
        -- Color Definitions
        -- ==========================================
        -- Core colors
        local background = Color.new("background", noirbuddy.background)
        local primary = Color.new("primary", noirbuddy.primary)

        -- Noir grayscale
        local noir_2 = Color.new("noir_2", noirbuddy.noir_2)
        local noir_3 = Color.new("noir_3", noirbuddy.noir_3)
        local noir_4 = Color.new("noir_4", noirbuddy.noir_4)
        local noir_5 = Color.new("noir_5", noirbuddy.noir_5)
        local noir_6 = Color.new("noir_6", noirbuddy.noir_6)
        local noir_8 = Color.new("noir_8", noirbuddy.noir_8)
        local noir_9 = Color.new("noir_9", noirbuddy.noir_9)

        -- Additional colors
        local gray6 = Color.new("gray6", noirbuddy.gray6)
        local lineNr = Color.new("lineNr", "#535353")
        local yellow = Color.new("yellow", "#e6dc44")

        -- Diff colors
        local diff_add = Color.new("diff_add", noirbuddy.diff_add)
        local diff_delete = Color.new("diff_delete", noirbuddy.diff_delete)
        local diff_add_bg = Color.new("diff_add_bg", "#1d2520")
        local diff_delete_bg = Color.new("diff_delete_bg", "#252029")

        -- ==========================================
        -- Neovim Core
        -- ==========================================
        Group.new("NormalNC", noir_4, background) -- inactive buffer
        Group.new("LineNr", lineNr, background)
        Group.new("CursorLineNr", gray6, background)
        Group.new("ministatuslinemodeinsert", background, yellow)

        -- ==========================================
        -- FZF Lua
        -- ==========================================
        -- Main window
        Group.new("FzfLuaNormal", noir_4, background)
        Group.new("FzfLuaBorder", noir_6, background)
        Group.new("FzfLuaTitle", primary, background)

        -- Preview window
        Group.new("FzfLuaPreviewTitle", primary, background)
        Group.new("FzfLuaPreviewBorder", noir_6, background)
        Group.new("FzfLuaPreviewNormal", noir_3, background)

        -- Search and selection
        Group.new("FzfLuaCursor", background, primary)
        Group.new("FzfLuaSearch", yellow, background)

        -- Scrollbars
        Group.new("FzfLuaScrollBorderEmpty", noir_6, background)
        Group.new("FzfLuaScrollBorderFull", primary, background)
        Group.new("FzfLuaScrollFloatEmpty", noir_6, background)
        Group.new("FzfLuaScrollFloatFull", primary, background)

        -- Headers and paths
        Group.new("FzfLuaHeaderBind", primary, background)
        Group.new("FzfLuaHeaderText", noir_5, background)
        Group.new("FzfLuaPathLineNr", yellow, background)
        Group.new("FzfLuaPathColNr", yellow, background)

        -- Buffers and tabs
        Group.new("FzfLuaBufName", primary, background)
        Group.new("FzfLuaBufNr", noir_5, background)
        Group.new("FzfLuaTabTitle", noir_2, background)
        Group.new("FzfLuaTabMarker", primary, background)

        -- ==========================================
        -- Neogit (Status Buffer)
        -- ==========================================
        Group.new("NeogitDiffAdd", diff_add, background)
        Group.new("NeogitDiffAddHighlight", diff_add, diff_add_bg)
        Group.new("NeogitDiffDelete", diff_delete, background)
        Group.new("NeogitDiffDeleteHighlight", diff_delete, diff_delete_bg)
        Group.new("NeogitDiffContext", noir_4, background)
        Group.new("NeogitDiffContextHighlight", noir_3, noir_9)
        Group.new("NeogitHunkHeader", primary, background)
        Group.new("NeogitHunkHeaderHighlight", primary, noir_9)

        -- ==========================================
        -- Diffview
        -- ==========================================
        -- Core diff highlights
        Group.new("DiffviewDiffAdd", diff_add, diff_add_bg)
        Group.new("DiffviewDiffAddAsDelete", diff_delete, diff_delete_bg)
        Group.new("DiffviewDiffDelete", noir_6, diff_delete_bg)
        Group.new("DiffviewDiffChange", yellow, background)
        Group.new("DiffviewDiffText", yellow, noir_8)
        Group.new("DiffviewDiffLine", primary, background)
        Group.new("DiffviewReference", primary, background)

        -- File panel
        Group.new("DiffviewFilePanelTitle", primary, background)
        Group.new("DiffviewFilePanelCounter", noir_5, background)
        Group.new("DiffviewFilePanelFileName", noir_2, background)
        Group.new("DiffviewFilePanelPath", noir_5, background)
        Group.new("DiffviewFilePanelInsertions", diff_add, background)
        Group.new("DiffviewFilePanelDeletions", diff_delete, background)
        Group.new("DiffviewFilePanelSelected", primary, background)

        -- Status indicators
        Group.new("DiffviewStatusAdded", diff_add, background)
        Group.new("DiffviewStatusModified", yellow, background)
        Group.new("DiffviewStatusRenamed", primary, background)
        Group.new("DiffviewStatusDeleted", diff_delete, background)
        Group.new("DiffviewStatusUntracked", noir_5, background)

        -- UI elements
        Group.new("DiffviewFolderName", primary, background)
        Group.new("DiffviewFolderSign", noir_6, background)
        Group.new("DiffviewNormal", noir_3, background)
        Group.new("DiffviewVertSplit", noir_6, background)
        Group.new("DiffviewEndOfBuffer", noir_8, background)
        Group.new("DiffviewCursorLine", nil, noir_9)

        -- ==========================================
        -- WhichKey
        -- ==========================================
        Group.new("Whichkey", noir_2, background)
        Group.new("WhichkeyTitle", noir_5, background)
        Group.new("WhichkeyDesc", noir_5, background)
        Group.new("WhichkeyGroup", noir_5, background)
    end,
}
