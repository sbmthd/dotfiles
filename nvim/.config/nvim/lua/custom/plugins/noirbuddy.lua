return {
    "jesseleite/nvim-noirbuddy",
    dependencies = {
        { "tjdevries/colorbuddy.nvim" },
    },
    lazy = false,
    priority = 1000,
    config = function()
        require("noirbuddy").setup({
            preset = "minimal",
            colors = {
                background = "#1b1d1e",
                -- black = "#000000",
                -- diagnostic_error = "#ff0038",
                -- diagnostic_hint = "#47eae0",
                -- diagnostic_info = "#47eae0",
                -- diagnostic_warning = "#ff7700",
                diff_add = "#35F09D", -- "#00ff77",
                -- diff_change = "#47eae0",
                diff_delete = "#BCA5F0", -- "#ff0038",
                -- gray0 = "#111111",
                -- gray1 = "#282a2e",
                -- gray2 = "#373b41",
                -- gray3 = "#969896",
                -- gray4 = "#b4b7b4",
                -- gray5 = "#c5c8c6",
                -- gray6 = "#e0e0e0",
                -- gray7 = "#ffffff",
                -- noir_0 = "#ffffff",
                -- noir_1 = "#f5f5f5",
                -- noir_2 = "#d5d5d5",
                -- noir_3 = "#b4b4b4",
                -- noir_4 = "#a7a7a7",
                -- noir_5 = "#949494",
                -- noir_6 = "#737373",
                -- noir_7 = "#535353",
                -- noir_8 = "#323232",
                -- noir_9 = "#212121",
                -- none = "none",
                -- primary = "#c8be46", -- "#89a7b1",
                primary = "#75C7F0",
                -- secondary = "#949494", -- #566981",
                -- white = "#ffffff",
            },
        })

        local noirbuddy = require("noirbuddy.colors").all()

        local Group = require("colorbuddy").Group
        local Color = require("colorbuddy").Color

        local background = Color.new("background", noirbuddy.background)
        local diff_change = Color.new("diff_change", noirbuddy.diff_change)
        local noir_2 = Color.new("noir_2", noirbuddy.noir_2)
        local noir_3 = Color.new("noir_3", noirbuddy.noir_3)
        local noir_4 = Color.new("noir_4", noirbuddy.noir_4)
        local noir_5 = Color.new("noir_5", noirbuddy.noir_5)
        local noir_6 = Color.new("noir_6", noirbuddy.noir_6)
        local primary = Color.new("primary", noirbuddy.primary)
        local yellow = Color.new("yellow", "#e6dc44")

        -- Neovim
        Group.new("NormalNC", noir_4, background) -- inactive buffer

        Group.new("ministatuslinemodeinsert", background, yellow)

        -- FZF Lua
        Group.new("FzfLuaNormal", noir_4, background)

        -- Diffview
        -- Group.new("DiffviewDiffAdd",

        -- Whichkey
        Group.new("Whichkey", noir_2, background)
        Group.new("WhichkeyTitle", noir_5, background)
        Group.new("WhichkeyDesc", noir_5, background)
        Group.new("WhichkeyGroup", noir_5, background)
    end,
}
