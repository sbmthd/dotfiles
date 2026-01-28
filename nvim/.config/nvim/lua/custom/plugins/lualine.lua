return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("custom-theme").setup({ theme = "sage" })
        local lualine_theme = package.loaded["lualine.themes.custom"]

        require("lualine").setup({
            options = {
                theme = lualine_theme,
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    {
                        "branch",
                        -- color = { fg = "#bababa" },
                    },
                    {
                        "diff",
                        colored = true,
                        diff_color = {
                            added = { fg = "#869782" },
                            -- modified = { fg = "#edcb6c" },
                            removed = { fg = "#b37a7a" },
                        },
                        symbols = { added = "+", modified = "~", removed = "-" }, -- TODO: replace with nerd font icons
                    },
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        symbols = { error = " ", warn = " ", info = " ", hint = " " }, -- TODO: replace with nerd font icons
                    },
                },
                lualine_c = {
                    {
                        "filename",
                        -- color = { bg = "#000000" },
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
                    "filetype",
                    -- color = { bg = "#000000" },
                },
                lualine_y = {
                    {
                        "progress",
                        color = { fg = "#bababa" },
                    },
                },
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

-- temp
