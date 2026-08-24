vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

require("options")
require("keymaps")
require("lazy-bootstrap")
require("lazy-plugins")
require("custom.colorschemes.quiet").setup()

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
