return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        vim.keymap.set("n", "<leader>sf", ":FzfLua files<CR>", { silent = true, desc = "[S]earch [F]iles" })
        vim.keymap.set("n", "<leader>sh", ":FzfLua highlights<CR>", { silent = true, desc = "[S]earch [H]ighlights" })
        vim.keymap.set("n", "<leader>sg", ":FzfLua live_grep_glob<CR>", { silent = true, desc = "[S]earch by [G]rep" })
        vim.keymap.set("n", "<leader>sr", ":FzfLua resume<CR>", { silent = true, desc = "[S]earch [R]esume" })
        vim.keymap.set("n", "<leader>sk", ":FzfLua keymaps<CR>", { silent = true, desc = "[S]earch [K]eymaps" })
        vim.keymap.set(
            "n",
            "<leader>ss",
            ":FzfLua lsp_document_symbols<CR>",
            { silent = true, desc = "[S]earch LSP Document [S]ymbols" }
        )
        vim.keymap.set(
            "n",
            "<leader>st",
            ":FzfLua awesome_colorschemes<CR>",
            { silent = true, desc = "[S]earch [T]hemes" }
        )
        vim.keymap.set(
            "n",
            "<leader>sit",
            ":FzfLua colorschemes<CR>",
            { silent = true, desc = "[S]earch [I]nstalled [T]hemes" }
        )
        vim.keymap.set("n", "<leader>so", function()
            require("fzf-lua").oldfiles({
                cwd_only = true, -- This filters files to current working directory
            })
        end, { silent = true, desc = "[S]earch [O]ld files" })
        vim.keymap.set(
            "n",
            "<leader>sd",
            ":FzfLua diagnostics_workspace<CR>",
            { silent = true, desc = "[S]earch [D]iagnostics" }
        )
        vim.keymap.set(
            "n",
            "<leader><leader>",
            ":FzfLua buffers<CR>",
            { silent = true, desc = "[ ] Search existing buffers" }
        )
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({
            -- automatically generate an fzf colorscheme from current Neovim colorscheme
            fzf_colors = true,

            winopts = {
                split = "belowright new",
                -- preview = {
                -- winopts = {
                -- number = true,
                -- winhighlight = "LineNr:FzfLuaPreviewLineNr,SignColumn:FzfLuaPreviewLineNr",
                -- },
                -- },
            },
            files = {
                formatter = "path.filename_first",
            },
            buffers = {
                formatter = "path.filename_first",
            },
            grep = {
                formatter = "path.filename_first",
            },
            oldfiles = {
                formatter = "path.filename_first",
            },
        })
    end,
}
