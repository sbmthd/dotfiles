local M = {}

function M.apply()
    local set = vim.api.nvim_set_hl
    set(0, "Normal", { bg = "#b6b5b2", fg = "#262522" })
    set(0, "Comment", { fg = "#efefef", italic = true })
    set(0, "String", { fg = "#2F5A5D" })
    set(0, "Constant", { fg = "#262522" })
    set(0, "@keyword.return", { fg = "#9A3D56", bold = true })
    set(0, "Statement", { fg = "#284B63", bold = true })
    set(0, "Type", { fg = "#284B63", bold = true })
    set(0, "Function", { fg = "#262522", bold = true })
    set(0, "Identifier", { fg = "NONE" })
    set(0, "PreProc", { fg = "#7D7F8A" })
    set(0, "Special", { fg = "#7D7F8A" })
    set(0, "Cursor", { fg = "#ffffff", bg = "#ffffff" })
    set(0, "CursorLine", { bg = "#d6d5d2" })
    set(0, "CursorLineNr", { bg = "#d6d5d2" })
    set(0, "LineNr", { fg = "#868582" })
    set(0, "SignColumn", { bg = "#b6b5b2" })
    set(0, "WinSeparator", { fg = "#8f8e8b", bg = "#b6b5b2" })
    set(0, "VertSplit", { fg = "#8f8e8b", bg = "#b6b5b2" })

    -- Same accent colors as lualine's git diff component (see
    -- lua/custom/plugins/lualine.lua's diff_color), so the gutter signs and
    -- statusline diff counts read as one system.
    set(0, "GitSignsAdd", { fg = "#ffffff", bg = "#7ba87b" })
    set(0, "GitSignsChange", { fg = "#262522", bg = "#d7d7d7" })
    set(0, "GitSignsDelete", { fg = "#ffffff", bg = "#b85670" })
    set(0, "GitSignsChangedelete", { fg = "#262522", bg = "#d7d7d7" })
    set(0, "GitSignsTopdelete", { fg = "#ffffff", bg = "#b85670" })

    -- Neogit derives its diff colors by sampling groups like Error/String
    -- via reverse-aware helpers (see neogit/lib/hl.lua). We never overrode
    -- Error, so it's still quiet.vim's original
    -- `guifg=#ff005f guibg=#000000 gui=reverse` — Neogit reads that reverse
    -- as "foreground = #000000" and seeds its whole red accent from it,
    -- which is why hunk headers and inline word-diffs render black. Skip
    -- the derived palette for those groups and set them directly instead.
    set(0, "NeogitHunkHeader", { fg = "#ffffff", bg = "#8f8e8b", bold = true })
    set(0, "NeogitHunkHeaderHighlight", { fg = "#ffffff", bg = "#262522", bold = true })
    set(0, "NeogitHunkHeaderCursor", { fg = "#ffffff", bg = "#262522", bold = true })
    set(0, "NeogitDiffAddInline", { fg = "#ffffff", bg = "#5f8f5f", bold = true })
    set(0, "NeogitDiffDeleteInline", { fg = "#ffffff", bg = "#8f4058", bold = true })

    local todo_accents = {
        FIX = { bg = "#ff005f", fg = "#000000" }, -- quiet's Error
        TODO = { bg = "#7D7F8A", fg = "#d7d7d7" },
        HACK = { bg = "#ffaf00", fg = "#000000" }, -- quiet's IncSearch
        WARN = { bg = "#ffaf00", fg = "#000000" }, -- quiet's IncSearch
        PERF = { bg = "#870087", fg = "#d7d7d7" },
        NOTE = { bg = "#4F6AAF", fg = "#eeeeee" }, -- quiet's Search
        TEST = { bg = "#87d787", fg = "#000000" }, -- quiet's DiffAdd
    }
    for kw, accent in pairs(todo_accents) do
        set(0, "TodoBg" .. kw, { fg = accent.fg, bg = accent.bg, bold = true })
        set(0, "TodoFg" .. kw, { fg = accent.bg })
    end

    set(0, "NormalDim", { bg = "#d2d1ce", fg = "#8a8a8a" })
    set(0, "LineNrDim", { bg = "#d2d1ce", fg = "#b0b0b0" })
    set(0, "CursorLineDim", { bg = "#b6b5b2" })
    set(0, "CursorLineNrDim", { bg = "#b6b5b2", fg = "#b0b0b0" })
    set(0, "SignColumnDim", { bg = "#b6b5b2", fg = "#8a8a8a" })
end

function M.setup()
    vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "quiet",
        callback = M.apply,
    })

    vim.api.nvim_create_autocmd("OptionSet", {
        pattern = "background",
        callback = function()
            if vim.o.background ~= "light" then
                vim.o.background = "light"
                if vim.g.colors_name == "quiet" then
                    M.apply()
                end
            end
        end,
    })

    vim.o.background = "light"
    vim.cmd.colorscheme("quiet")
end

return M
