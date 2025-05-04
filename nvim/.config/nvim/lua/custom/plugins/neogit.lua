return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "ibhagwan/fzf-lua",
    },
    config = function()
        vim.keymap.set(
            "n",
            "<leader>g",
            ":Neogit kind=replace<CR>",
            { noremap = true, silent = true, desc = "Open Neogit" }
        )
        vim.keymap.set(
            "n",
            "<leader>gs",
            ":Neogit kind=split<CR>",
            { noremap = true, silent = true, desc = "Open Neogit in split" }
        )
        vim.keymap.set(
            "n",
            "<leader>gb",
            ":FzfLua git_branches<CR>",
            { noremap = true, silent = true, desc = "Search branches" }
        )
        vim.keymap.set(
            "n",
            "<leader>gc",
            ":FzfLua git_commits<CR>",
            { noremap = true, silent = true, desc = "Search commits" }
        )

        -- Set up Neogit first
        require("neogit").setup({
            integrations = {
                diffview = true,
                fzf_lua = true,
            },
            graph_style = "kitty",
        })

        -- Configure diffview separately
        require("diffview").setup({
            enhanced_diff_hl = true,
        })

        -- Set up the autocommand to map 'q' in Diffview buffers
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "DiffviewFiles", "DiffviewFileHistory" },
            callback = function()
                vim.keymap.set("n", "q", ":DiffviewClose<CR>", { buffer = true, noremap = true, silent = true })
            end,
        })

        -- Also add autocmd for regular diff buffers
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "diff",
            callback = function()
                vim.keymap.set("n", "q", ":DiffviewClose<CR>", { buffer = true, noremap = true, silent = true })
            end,
        })

        vim.cmd([[
            highlight DiffviewDiffAdd guifg=NONE guibg=#37453a gui=NONE
            highlight DiffviewDiffChange guifg=#999999 guibg=NONE gui=NONE
            highlight DiffviewDiffDelete guifg=NONE guibg=#3C354D gui=NONE
            highlight DiffviewDiffAddAsDelete guifg=NONE guibg=#3C354D gui=NONE
            highlight DiffviewDiffLine guifg=NONE guibg=NONE gui=NONE
            highlight DiffviewReference guifg=NONE guibg=NONE gui=NONE
            highlight DiffviewDiffText guifg=NONE guibg=#2b2d2e gui=NONE
        ]])
        -- Set diagonal lines for diff view
        vim.opt.fillchars:append({ diff = "╱" })
    end,
}
