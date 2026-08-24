return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                -- Use a tailored lualine theme for whichever colorscheme is
                -- actually active. "auto" is a poor fallback for "quiet":
                -- it mixes fg/bg from unrelated highlight groups and quiet's
                -- inverted StatusLine polarity makes that come out as
                -- black-on-black (see lua/lualine/themes/quiet.lua).
                theme = function()
                    if vim.g.colors_name == "ambient-stealth" then
                        return "ambient-stealth"
                    elseif vim.g.colors_name == "quiet" then
                        return "quiet"
                    end
                    return "auto"
                end,
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    "branch",
                    {
                        "diff",
                        colored = true,
                        diff_color = {
                            added = { fg = "#7ba87b" },
                            modified = { fg = "#d7d7d7" },
                            removed = { fg = "#b85670" },
                        },
                        -- symbols = { added = "+", modified = "~", removed = "-" }, -- TODO: replace with nerd font icons
                    },
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        -- symbols = { error = "󰅚 ", warn = "󰀪 ", info = "󰋽 ", hint = "󰌶 " }, -- TODO: replace with nerd font icons
                    },
                },
                lualine_c = {
                    {
                        "filename",
                        path = 4,
                    },
                },
                lualine_x = {
                    function()
                        local ok, pomo = pcall(require, "pomo")
                        if not ok then
                            return ""
                        end
                        local timer = pomo.get_first_to_finish()
                        if timer == nil then
                            return ""
                        end
                        return "󰄉 " .. tostring(timer)
                    end,
                    require("triforce.lualine").streak,
                    require("triforce.lualine").level,
                    {
                        "filetype",
                        colored = false,
                    },
                },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
        })
    end,
}
