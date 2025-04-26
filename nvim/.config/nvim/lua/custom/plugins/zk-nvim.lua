local opts = { noremap = true, silent = false }

-- Create a new note after asking for its title.
vim.keymap.set("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)

-- Open notes.
vim.keymap.set("n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)
-- Open notes associated with the selected tags.
vim.keymap.set("n", "<leader>zt", "<Cmd>ZkTags<CR>", opts)

-- Search for the notes matching a given query.
vim.keymap.set(
    "n",
    "<leader>zf",
    "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
    opts
)
-- Search for the notes matching the current visual selection.
vim.keymap.set("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opts)

return {
    "zk-org/zk-nvim",
    config = function()
        require("zk").setup({
            -- can be "telescope", "fzf", "fzf_lua", "minipick", or "select" (`vim.ui.select`)
            -- it's recommended to use "telescope", "fzf", "fzf_lua", or "minipick"
            picker = "fzf_lua",

            lsp = {
                -- `config` is passed to `vim.lsp.start_client(config)`
                config = {
                    cmd = { "zk", "lsp" },
                    name = "zk",
                    -- on_attach = ...
                    -- etc, see `:h vim.lsp.start_client()`
                },

                -- automatically attach buffers in a zk notebook that match the given filetypes
                auto_attach = {
                    enabled = true,
                    filetypes = { "markdown" },
                },
            },
        })
    end,
}
