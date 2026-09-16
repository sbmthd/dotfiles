local dir = vim.fn.expand("~/projects/ambient-stealth.nvim")

return {
    dir = dir,
    name = "ambient-stealth.nvim",
    lazy = false,
    priority = 1000,
    -- Local dev checkout — only exists on machines actively working on the
    -- plugin. Skip it silently elsewhere instead of lazy.nvim erroring
    -- "Plugin ambient-stealth.nvim is not installed" on every startup.
    cond = function()
        return vim.uv.fs_stat(dir) ~= nil
    end,
    config = function()
        -- Only configure the default variant here; don't activate the
        -- colorscheme on startup. "quiet" (built into Neovim) is the
        -- default for now — switch with `:Theme <variant>` or
        -- `:colorscheme ambient-stealth`.
        require("ambient-stealth").setup({ theme = "sage" })
    end,
}
