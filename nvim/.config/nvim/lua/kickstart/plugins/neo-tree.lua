-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

vim.keymap.set("n", "<leader>n", "<cmd>Neotree position=current toggle<cr>", { desc = "Toggle Neotree", silent = true })

return {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
        { "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
    },
    opts = {
        filesystem = {
            window = {
                mappings = {
                    ["\\"] = "close_window",
                },
            },
        },
    },
}
