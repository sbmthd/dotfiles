local M = {}

function M.apply()
    local set = vim.api.nvim_set_hl
    set(0, "Normal", { bg = "#b6b5b2", fg = "#262522" })
    -- Muted roles sit in a 2.6–4:1 contrast band against the grey bg:
    -- quieter than body text (7.5:1) but never below ~2.6:1, so nothing
    -- needs squinting at.
    --
    -- Comment was tried both ways: lighter than the page (a near-white
    -- "chalk" fg) and lighter-than-text-but-darker-than-bg (this). The
    -- chalk direction is a dead end on this specific bg — #b6b5b2 is
    -- already a light-medium grey, so pure white against it only reaches
    -- ~2:1 contrast; there's no headroom above the bg to be legibly
    -- "pale" with. Low contrast reads as soft in a screenshot but is more
    -- eye strain over real reading, not less. So: still lighter than the
    -- old #54524D (which sat too close to body text's own darkness and
    -- read as dimmed code rather than a distinct voice — it bled in), but
    -- staying on the dark-side-of-bg band above, just at its paler end
    -- (~2.5:1) instead of crossing over it.
    set(0, "Comment", { fg = "#706E67", italic = true })
    set(0, "String", { fg = "#29494C" })
    set(0, "Constant", { fg = "#262522" })
    set(0, "@keyword.return", { fg = "#83334A", bold = true })
    set(0, "Statement", { fg = "#284B63", bold = true })
    set(0, "Type", { fg = "#284B63", bold = true })
    set(0, "Function", { fg = "#262522", bold = true })
    set(0, "Identifier", { fg = "NONE" })
    set(0, "PreProc", { fg = "#5A5C68" })
    set(0, "Special", { fg = "#5A5C68" })
    -- The terminal paints the cursor block from bg but draws the glyph in
    -- its own fg, so bg must contrast with Normal's #262522 ink — a dark
    -- block hides the character under it. fg only matters in GUIs.
    set(0, "Cursor", { fg = "#262522", bg = "#ffffff" })
    set(0, "CursorLine", { bg = "#c6c4c0" })
    set(0, "CursorLineNr", { bg = "#c6c4c0" })
    set(0, "LineNr", { fg = "#6B6A66" })
    set(0, "SignColumn", { bg = "#b6b5b2" })
    set(0, "WinSeparator", { fg = "#8f8e8b", bg = "#b6b5b2" })
    set(0, "VertSplit", { fg = "#8f8e8b", bg = "#b6b5b2" })

    -- Match lualine's light bg/fg (lua/lualine/themes/quiet.lua) so the
    -- message/cmdline window (vim._core.ui2, see init.lua) reads as part
    -- of the same statusline-adjacent surface instead of an unstyled one.
    set(0, "MsgArea", { fg = "#262522", bg = "#a7a5a1" })
    set(0, "MsgSeparator", { fg = "#8f8e8b", bg = "#a7a5a1" })

    -- gitsigns' default signs (┃ add/change, ▁/▔ delete, see
    -- kickstart/plugins/gitsigns.lua) are thin line-strokes drawn in the
    -- sign's fg, not filled icon glyphs — a bg pill behind a stroke just
    -- reads as a mismatched border rather than a solid colored bar. fg
    -- only, reusing the exact same accents as lualine's diff component
    -- (lua/custom/plugins/lualine.lua's diff_color) so the gutter bars and
    -- statusline diff counts are one palette.
    --
    -- "change" was originally the same muted grey as Comment (#54524D),
    -- but at equal darkness to the add-green (~3.8:1 vs ~3.9:1 contrast on
    -- this bg) a thin stroke reads by hue alone, and grey-vs-green is too
    -- subtle a hue shift to tell apart at a glance. Statement/Type's dark
    -- blue (#284B63) fixed the hue but was still too dark to read as
    -- anything but another dark stroke — same problem, different color.
    -- The lualine command-mode blue is the same hue family, several steps
    -- lighter, and already established elsewhere in this system.
    --
    -- "add" reuses lualine's insert-mode green (see lualine/themes/
    -- quiet.lua's `green`) rather than a separate darker green invented
    -- just for diffs — one green accent for "adding something" everywhere,
    -- not two.
    set(0, "GitSignsAdd", { fg = "#3E7444" })
    set(0, "GitSignsChange", { fg = "#4F6AAF" })
    set(0, "GitSignsDelete", { fg = "#83334A" })
    set(0, "GitSignsChangedelete", { fg = "#4F6AAF" })
    set(0, "GitSignsTopdelete", { fg = "#83334A" })

    -- Diagnostic gutter signs are a solid colored block, no icon glyph
    -- (kickstart/plugins/lspconfig.lua's sign text is blank) — the pill
    -- already fills the full gutter width, so severity is legible from
    -- color + position alone; an icon on top was redundant. No fg needed
    -- since there's no glyph left to color. Bgs are muted versions of
    -- quiet's error red / warn orange.
    set(0, "DiagnosticSignError", { bg = "#A33F3F" })
    set(0, "DiagnosticSignWarn", { bg = "#C08D3D" })

    -- Diagnostic virtual/float text. Quiet doesn't define these, and the
    -- nvim defaults fall through as pure #ff0000/#ffa500 (loud) and
    -- #add8e6/#d3d3d3 (lighter than our bg, i.e. invisible). Muted fgs in
    -- the same family as the sign pills, undercurls to match.
    set(0, "DiagnosticError", { fg = "#8F3437" })
    set(0, "DiagnosticWarn", { fg = "#6F521C" })
    set(0, "DiagnosticInfo", { fg = "#3F5F73" })
    set(0, "DiagnosticHint", { fg = "#5C5A55" })
    set(0, "DiagnosticUnderlineError", { sp = "#8F3437", undercurl = true })
    set(0, "DiagnosticUnderlineWarn", { sp = "#6F521C", undercurl = true })
    set(0, "DiagnosticUnderlineInfo", { sp = "#3F5F73", undercurl = true })
    set(0, "DiagnosticUnderlineHint", { sp = "#5C5A55", undercurl = true })

    -- Quiet's light variant assumes a #d7d7d7 page: on our darker grey its
    -- #a8a8a8 menus barely separate from Normal (1.16:1) and its #d7d7d7
    -- surfaces (Folded, MatchParen, Spell*) show up as bright strips.
    -- Re-seat those surfaces just above the bg instead.
    set(0, "Pmenu", { fg = "#262522", bg = "#C9C8C4" })
    set(0, "PmenuExtra", { fg = "#54524D", bg = "#C9C8C4" })
    set(0, "PmenuKind", { fg = "#54524D", bg = "#C9C8C4", bold = true })
    set(0, "PmenuMatch", { fg = "#83334A", bg = "#C9C8C4" })
    set(0, "PmenuSbar", { bg = "#b6b5b2" })
    set(0, "NormalFloat", { fg = "#262522", bg = "#C9C8C4" })
    set(0, "FloatBorder", { fg = "#6B6A66", bg = "#C9C8C4" })
    set(0, "Folded", { fg = "#54524D", bg = "#C2C0BC" })
    set(0, "MatchParen", { bg = "#A9B2C4", bold = true })
    set(0, "SpellBad", { sp = "#A33F3F", undercurl = true })
    set(0, "SpellCap", { sp = "#3F5F73", undercurl = true })
    set(0, "SpellLocal", { sp = "#6E4A78", undercurl = true })
    set(0, "SpellRare", { sp = "#2F5A5D", undercurl = true })

    -- Visual is quiet's loudest "nicety" (renders as black-on-amber via
    -- reverse). Selections are constant-use, so give them a muted
    -- blue-grey wash instead; Search/IncSearch/CurSearch stay loud on
    -- purpose — they're transient and need to be findable at a glance.
    set(0, "Visual", { bg = "#A3ABBE" })

    -- QuickFixLine (the active entry in a quickfix/location list) is
    -- another of quiet.vim's fixed reversals — fluorescent pink
    -- (guifg=#ff5fff) rather than amber, but the same "loud nicety"
    -- problem as Visual above. It marks "you are here" in a list, not a
    -- transient thing to spot, so it gets the same muted wash.
    set(0, "QuickFixLine", { bg = "#A3ABBE" })

    -- Diff view surfaces (codediff, gitsigns previews): quiet's reversed
    -- neon blocks, remade as muted washes that keep Normal fg readable.
    set(0, "DiffAdd", { bg = "#A6BDA2" })
    set(0, "DiffDelete", { fg = "#8F8E8B", bg = "#C2A0A4" })
    set(0, "DiffChange", { bg = "#ADB3C0" })
    set(0, "DiffText", { bg = "#98A3BD", bold = true })

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

    -- Muted pills, one per accent family already on screen: FIX shares the
    -- diagnostic-error red, HACK/WARN the diagnostic-warn amber, TEST the
    -- GitSignsAdd green, TODO the PreProc/Special slate.
    local todo_accents = {
        FIX = { bg = "#A33F3F", fg = "#ffffff" },
        TODO = { bg = "#5A5C68", fg = "#e2e2e2" },
        HACK = { bg = "#C08D3D", fg = "#262522" },
        WARN = { bg = "#C08D3D", fg = "#262522" },
        PERF = { bg = "#6E4A78", fg = "#eeeeee" },
        NOTE = { bg = "#4F6AAF", fg = "#eeeeee" },
        TEST = { bg = "#7ba87b", fg = "#262522" },
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
