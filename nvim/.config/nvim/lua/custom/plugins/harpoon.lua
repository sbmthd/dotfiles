return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            -- Basic Harpoon setup
            harpoon:setup({
                settings = {
                    save_on_toggle = true,
                    sync_on_ui_close = true,
                    -- key = function()
                    -- return vim.loop.cwd()
                    -- end,
                },
            })

            vim.keymap.set("n", "<leader>p", function()
                harpoon.ui:toggle_quick_menu(harpoon:list(), {
                    title = " Harpoon deez nutz ",
                })
            end, { desc = "Toggle Harpoon deez nutz" })

            -- Basic keymaps
            vim.keymap.set("n", "<leader>a", function()
                harpoon:list():add()
            end, { desc = "Add file to Harpoon" })

            -- Navigation
            vim.keymap.set("n", "<A-]>", function()
                harpoon:list():next({ ui_nav_wrap = true })
            end)
            vim.keymap.set("n", "<A-[>", function()
                harpoon:list():prev({ ui_nav_wrap = true })
            end)
        end,
    },
}
