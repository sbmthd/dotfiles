return {
    {
        "tpope/vim-dadbod",
        dependencies = {
            "kristijanhusak/vim-dadbod-ui",
            "kristijanhusak/vim-dadbod-completion",
        },
        cmd = { "DB", "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
        keys = {
            { "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Toggle DBUI" },
        },
        init = function()
            -- DBUI config — must be set before plugin loads
            vim.g.db_ui_use_nerd_fonts = 1
            vim.g.db_ui_show_database_icon = 1
            vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
        end,
    },
}
