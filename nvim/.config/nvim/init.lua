-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- vim._core.ui2 is a private/unstable API present only in recent nightly
-- builds; guard it so an older or future Neovim that lacks/renames it
-- doesn't hard-crash init.lua before options/keymaps/plugins ever load.
local ok_ui2, ui2 = pcall(require, "vim._core.ui2")
if ok_ui2 then
    ui2.enable({
        enable = true, -- Whether to enable or disable the UI.
        msg = { -- Options related to the message module.
            ---@type 'cmd'|'msg' Default message target, either in the
            ---cmdline or in a separate ephemeral message window.
            ---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
            ---or table mapping |ui-messages| kinds and triggers to a target.
            targets = "cmd",
            cmd = { -- Options related to messages in the cmdline window.
                height = 0.5, -- Maximum height while expanded for messages beyond 'cmdheight'.
            },
            dialog = { -- Options related to dialog window.
                height = 0.5, -- Maximum height.
            },
            msg = { -- Options related to msg window.
                height = 0.5, -- Maximum height.
                timeout = 4000, -- Time a message is visible in the message window.
            },
            pager = { -- Options related to message window.
                height = 1, -- Maximum height.
            },
        },
    })
end

-- [[ Setting options ]]
require("options")

-- [[ Basic Keymaps ]]
require("keymaps")

-- [[ Install `lazy.nvim` plugin manager ]]
require("lazy-bootstrap")

-- [[ Configure and install plugins ]]
require("lazy-plugins")

-- Default colorscheme on startup. ambient-stealth.nvim is installed and
-- configured above, but not activated automatically — switch to it with
-- `:Theme <variant>` or `:colorscheme ambient-stealth` when you want it.
-- `background` defaults to "dark" in Neovim, and `quiet` picks its palette
-- based on it, so it must be set to "light" explicitly before loading.
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "quiet",
    callback = function()
        local set = vim.api.nvim_set_hl
        set(0, "Comment", { fg = "#8a8a8a", italic = true })
        set(0, "String", { fg = "#5383A2" })
        set(0, "Constant", { fg = "#505050" })
        set(0, "Statement", { fg = "#000000", bold = true })
        set(0, "Type", { fg = "#000000", bold = true })
        set(0, "Function", { fg = "#202020", bold = true })
        set(0, "Identifier", { fg = "NONE" })
        set(0, "PreProc", { fg = "#505050" })
        set(0, "Special", { fg = "#505050" })
        set(0, "TodoBgTODO", { fg = "#d7d7d7", bg = "#b85670", bold = true })
        set(0, "TodoFgTODO", { fg = "#b85670" })
        set(0, "Cursor", { fg = "#c2c2c2", bg = "#000000" })
    end,
})
vim.o.background = "light"
vim.cmd.colorscheme("quiet")

-- Quick switch command (alias for :AmbientStealth, kept for muscle memory)
vim.api.nvim_create_user_command("Theme", function(opts)
    require("ambient-stealth").switch(opts.args)
end, {
    nargs = 1,
    complete = function()
        return vim.tbl_keys(require("ambient-stealth").variants)
    end,
})

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
            "Normal:NormalDim,NormalNC:NormalDim,LineNr:LineNrDim,LineNrNC:LineNrDim,CursorLineNr:CursorLineNrDim,SignColumn:SignColumnDim,SignColumnNC:SignColumnDim"
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
