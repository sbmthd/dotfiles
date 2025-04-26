-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		vim.api.nvim_set_hl(0, "MsgArea", { bg = "#282c34" })
	end,
})

-- Define the dim highlight for normal text
vim.api.nvim_set_hl(0, "NormalDim", {
	bg = "#212121",
	fg = "#aaaaaa",
})

-- Define dim highlight for line numbers
vim.api.nvim_set_hl(0, "LineNrDim", {
	bg = "#212121",
	fg = "#313131", -- Dimmer color for line numbers
})

-- Define dim highlight for the sign column
vim.api.nvim_set_hl(0, "SignColumnDim", {
	bg = "#212121",
	fg = "#aaaaaa",
})

-- Set up highlighting for active windows
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	callback = function()
		vim.opt_local.winhighlight =
			"Normal:Normal,NormalNC:NormalDim,LineNr:LineNr,LineNrNC:LineNrDim,SignColumn:SignColumn,SignColumnNC:SignColumnDim"
	end,
})

-- Set up highlighting for inactive windows
vim.api.nvim_create_autocmd("WinLeave", {
	callback = function()
		vim.opt_local.winhighlight =
			"Normal:NormalDim,NormalNC:NormalDim,LineNr:LineNrDim,LineNrNC:LineNrDim,SignColumn:SignColumnDim,SignColumnNC:SignColumnDim"
	end,
})

-- [[ Setting options ]]
require("options")

-- [[ Basic Keymaps ]]
require("keymaps")

-- [[ Install `lazy.nvim` plugin manager ]]
require("lazy-bootstrap")

-- [[ Configure and install plugins ]]
require("lazy-plugins")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
