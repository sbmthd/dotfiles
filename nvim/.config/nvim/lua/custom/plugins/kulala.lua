return {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    keys = {
        { "<leader>rr", "<cmd>lua require('kulala').run()<cr>", desc = "Run request", ft = { "http", "rest" } },
        {
            "<leader>rt",
            "<cmd>lua require('kulala').toggle_view()<cr>",
            desc = "Toggle response view",
            ft = { "http", "rest" },
        },
        { "<leader>rn", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Next request", ft = { "http", "rest" } },
        {
            "<leader>rp",
            "<cmd>lua require('kulala').jump_prev()<cr>",
            desc = "Previous request",
            ft = { "http", "rest" },
        },
    },
    opts = {},
}
