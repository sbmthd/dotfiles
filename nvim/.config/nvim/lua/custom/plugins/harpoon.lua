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

			-- Telescope integration
			-- local conf = require('telescope.config').values
			-- local function toggle_telescope(harpoon_files)
			--   local file_paths = {}
			--   for _, item in ipairs(harpoon_files.items) do
			--     table.insert(file_paths, item.value)
			--   end
			--
			--   require('telescope.pickers')
			--     .new({}, {
			--       prompt_title = 'Harpoon deez nutz',
			--       finder = require('telescope.finders').new_table {
			--         results = file_paths,
			--       },
			--       previewer = conf.file_previewer {},
			--       sorter = conf.generic_sorter {},
			--     })
			--     :find()
			-- end

			-- Keymap to open Harpoon marks in Telescope
			-- vim.keymap.set('n', '<leader>sp', function()
			--   toggle_telescope(harpoon:list())
			-- end, { desc = 'Open Harpoon marks in Telescope' })
		end,
	},
}
