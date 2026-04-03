-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

require("vim._core.ui2").enable({
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

-- [[ Setting options ]]
require("options")

-- [[ Basic Keymaps ]]
require("keymaps")

-- [[ Install `lazy.nvim` plugin manager ]]
require("lazy-bootstrap")

-- Load custom theme
require("custom-theme").setup({ theme = "sage" })

-- [[ Configure and install plugins ]]
require("lazy-plugins")

-- Quick switch command
vim.api.nvim_create_user_command("Theme", function(opts)
    require("custom-theme").switch(opts.args)
end, {
    nargs = 1,
    complete = function()
        return { "sage", "ocean", "amber", "rose", "slate", "olive", "plum", "copper" }
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

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
