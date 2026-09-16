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
                        -- Same accents as the GitSigns gutter bars (see
                        -- custom/colorschemes/quiet.lua's GitSignsAdd/
                        -- Change/Delete) — one palette for "this hunk is
                        -- added/changed/removed" everywhere it shows up,
                        -- gutter and statusline alike.
                        diff_color = {
                            -- Same green as lualine's insert-mode accent
                            -- (lualine/themes/quiet.lua's `green`) — one
                            -- green for "adding something", not a separate
                            -- darker one invented just for diffs.
                            added = { fg = "#3E7444" },
                            -- Same blue as GitSignsChange. The old grey was
                            -- too close to `added`'s darkness to tell apart
                            -- by hue alone, and the first blue tried
                            -- (Statement's #284B63) was still too dark to
                            -- read as anything but another dark mark. This
                            -- is the lighter command-mode blue.
                            modified = { fg = "#4F6AAF" },
                            removed = { fg = "#83334A" },
                        },
                        -- Conventional +/~/- diff-count symbols. Not trying
                        -- to match GitSigns' gutter glyphs here (those are
                        -- bars now, see kickstart/plugins/gitsigns.lua) —
                        -- this is a line count, not a per-line indicator.
                        symbols = { added = "+", modified = "~", removed = "-" },
                    },
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        -- Same glyphs as the diagnostic gutter signs (see
                        -- vim.diagnostic.config in
                        -- kickstart/plugins/lspconfig.lua) for consistency.
                        symbols = { error = "󰅚 ", warn = "󰀪 ", info = "󰋽 ", hint = "󰌶 " },
                    },
                    {
                        -- Attached LSP client name(s) for the current buffer.
                        -- fidget.nvim already surfaces load/progress via its
                        -- own corner notifications, so this stays a static
                        -- "is something attached, and what" readout rather
                        -- than duplicating a spinner.
                        function()
                            local clients = vim.lsp.get_clients({ bufnr = 0 })
                            if #clients == 0 then
                                return ""
                            end
                            local names = {}
                            for _, client in ipairs(clients) do
                                table.insert(names, client.name)
                            end
                            return " " .. table.concat(names, ", ")
                        end,
                    },
                },
                lualine_c = {
                    {
                        "filename",
                        path = 4,
                    },
                },
                lualine_x = {
                    {
                        -- Macro recording is otherwise silent in the UI —
                        -- surface which register is being filled so it's
                        -- never forgotten mid-recording.
                        function()
                            local reg = vim.fn.reg_recording()
                            if reg == "" then
                                return ""
                            end
                            return "󰑊 recording @" .. reg
                        end,
                        -- Same red as the "removed" diff count just above
                        -- (quiet's error/maroon accent) — recording is a
                        -- destructive-ish, pay-attention state.
                        color = { fg = "#83334A", gui = "bold" },
                    },
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
                    {
                        "filetype",
                        colored = false,
                    },
                },
                lualine_y = { "progress" },
                lualine_z = {
                    {
                        "location",
                        cond = function()
                            return vim.fn.mode():match("^[vV\22]") == nil
                        end,
                    },
                    {
                        -- In visual mode, the selection size is more useful
                        -- than the cursor's own line/col.
                        function()
                            local wc = vim.fn.wordcount()
                            return string.format("%dL %dC", wc.visual_lines or 0, wc.visual_chars or 0)
                        end,
                        cond = function()
                            return vim.fn.mode():match("^[vV\22]") ~= nil
                        end,
                    },
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            -- Native quickfix/location-list windows (better-quickfix-list
            -- doesn't change their filetype) get lualine's purpose-built
            -- statusline instead of the generic one.
            extensions = { "quickfix" },
        })
    end,
}
