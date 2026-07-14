return {
    { -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        lazy = false,
        config = function()
            -- The main branch has no ensure_installed / auto_install;
            -- install() is idempotent and async, so calling it at startup is fine.
            require("nvim-treesitter").install({
                "bash",
                "c",
                "diff",
                "html",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "query",
                "vim",
                "vimdoc",
                "php",
                "javascript",
                "typescript",
                "vue",
                "css",
                "scss",
                "json",
                "sql",
            })

            -- Highlighting and indent are now opt-in per buffer.
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
                callback = function(args)
                    -- start() errors if no parser exists for the filetype,
                    -- so guard it — this replaces auto_install gracefully.
                    local ok = pcall(vim.treesitter.start, args.buf)
                    if ok then
                        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("nvim-treesitter-textobjects").setup({
                select = {
                    lookahead = true,
                    selection_modes = {
                        ["@parameter.outer"] = "v", -- charwise
                        ["@function.outer"] = "V", -- linewise
                        ["@class.outer"] = "<c-v>", -- blockwise
                    },
                    include_surrounding_whitespace = false,
                },
                move = {
                    set_jumps = true,
                },
            })

            -- The module no longer sets keymaps from opts; you map them yourself.
            local ts_select = require("nvim-treesitter-textobjects.select")
            local ts_move = require("nvim-treesitter-textobjects.move")

            local select_maps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",
                ["ai"] = "@conditional.outer",
                ["ii"] = "@conditional.inner",
                ["a/"] = "@comment.outer",
                ["i/"] = "@comment.inner",
                ["ar"] = "@return.outer",
                ["ir"] = "@return.inner",
                ["am"] = "@method.outer",
                ["im"] = "@method.inner",
            }
            for lhs, capture in pairs(select_maps) do
                vim.keymap.set({ "x", "o" }, lhs, function()
                    ts_select.select_textobject(capture, "textobjects")
                end, { desc = "Select " .. capture })
            end

            -- { lhs, query(s), optional query_group }
            local move_maps = {
                goto_next_start = {
                    { "]m", "@function.outer" },
                    { "]]", "@class.outer" },
                    { "]o", { "@loop.inner", "@loop.outer" } },
                    { "]s", "@scope", "locals" },
                    { "]z", "@fold", "folds" },
                },
                goto_next_end = {
                    { "]M", "@function.outer" },
                    { "][", "@class.outer" },
                },
                goto_previous_start = {
                    { "[m", "@function.outer" },
                    { "[[", "@class.outer" },
                    { "[o", { "@loop.inner", "@loop.outer" } },
                    { "[s", "@scope", "locals" },
                    { "[z", "@fold", "folds" },
                },
                goto_previous_end = {
                    { "[M", "@function.outer" },
                    { "[]", "@class.outer" },
                },
                goto_next = {
                    { "]i", "@conditional.inner" },
                },
                goto_previous = {
                    { "[i", "@conditional.inner" },
                },
            }
            for fn_name, maps in pairs(move_maps) do
                for _, map in ipairs(maps) do
                    local lhs, query, group = map[1], map[2], map[3]
                    vim.keymap.set({ "n", "x", "o" }, lhs, function()
                        ts_move[fn_name](query, group or "textobjects")
                    end, { desc = fn_name .. " " .. vim.inspect(query) })
                end
            end
        end,
    },
}
-- vim: ts=2 sts=2 sw=2 et
