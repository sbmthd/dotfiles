vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

require("options")
require("keymaps")
require("lazy-bootstrap")
require("lazy-plugins")
-- require("custom.colorschemes.quiet").setup() -- swapped for zenburn.nvim, see custom/plugins/zenburn.lua

-- Set up window dimming autocmds (after theme loads)
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    callback = function()
        vim.opt_local.winhighlight =
            "Normal:Normal,NormalNC:NormalDim,LineNr:LineNr,LineNrNC:LineNrDim,SignColumn:SignColumn,SignColumnNC:SignColumnDim"
    end,
})

vim.api.nvim_create_autocmd("WinLeave", {
    callback = function()
        vim.opt_local.winhighlight =
            -- "Normal:NormalDim,NormalNC:NormalDim,LineNr:LineNrDim,LineNrNC:LineNrDim,CursorLine:CursorLineDim,CursorLineNr:CursorLineNrDim,SignColumn:SignColumnDim,SignColumnNC:SignColumnDim"
            "CursorLine:CursorLineDim,CursorLineNr:CursorLineNrDim"
    end,
})

-- Force Harpoon background highlight group to use NormalFloat
vim.api.nvim_create_autocmd("FileType", {
    pattern = "harpoon",
    callback = function()
        vim.wo.winhighlight = "Normal:NormalFloat"
    end,
})

-- Enable packaged Undotree
vim.cmd("packadd nvim.undotree")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
