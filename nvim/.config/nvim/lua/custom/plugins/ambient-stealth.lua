return {
    dir = vim.fn.expand("~/projects/ambient-stealth.nvim"),
    name = "ambient-stealth.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        -- Only configure the default variant here; don't activate the
        -- colorscheme on startup. "quiet" (built into Neovim) is the
        -- default for now — switch with `:Theme <variant>` or
        -- `:colorscheme ambient-stealth`.
        require("ambient-stealth").setup({ theme = "sage" })
    end,
}
