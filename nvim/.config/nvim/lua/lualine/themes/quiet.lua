local is_light = vim.o.background == "light"

local colors = {
    -- The statusline is chrome: in light mode it must carry LESS signal
    -- than the buffer, not more. One flat strip a step darker than the
    -- page bg (#b6b5b2, see custom/colorschemes/quiet.lua) so it recedes
    -- as a frame; the old #000000-on-#e2e2e2 stripe made it the highest
    -- contrast element on screen. Used for lualine_c, the largest/
    -- plainest section (e.g. filename).
    fg = is_light and "#262522" or "#dadada",
    bg = is_light and "#a7a5a1" or "#000000",
    -- The bold mode indicator (lualine_a) — the one deliberate signal on
    -- the strip: a dark block, but warm charcoal rather than pure black.
    -- Deliberately inverted polarity vs. `fg`/`bg` above (that's what made
    -- "auto" break).
    statusline_fg = is_light and "#d9d8d5" or "#000000",
    statusline_bg = is_light and "#45433e" or "#dadada",
    -- Used for lualine_b (branch/diff/diagnostics) and as the
    -- inactive-window variant of lualine_a/b. In light mode b/y share the
    -- c-section surface — a three-step surface gradient left too little
    -- contrast for the diff/diagnostic counts sitting on it.
    statusline_nc_fg = is_light and "#54524D" or "#707070",
    statusline_nc_bg = is_light and "#a7a5a1" or "#000000",
    -- Muted fg for softer sections (branch, progress) — quiet, but still
    -- readable (~4:1) on statusline_nc_bg in both variants. In dark mode
    -- the original #bababa on #000000 is what we're preserving.
    muted_fg = is_light and "#45433e" or "#bababa",
    -- Accent bgs for lualine_a per mode, so each mode is still
    -- distinguishable at a glance. Dark mode keeps quiet's fixed
    -- "niceties" (Search, Visual, DiffAdd, Error); light mode uses the
    -- muted equivalents from the colorscheme's accent families, dark
    -- enough that statusline_fg stays readable on them.
    green = is_light and "#3E7444" or "#00af00", -- insert
    orange = is_light and "#a06a2c" or "#ffaf00", -- visual
    pink = is_light and "#b85670" or "#ff005f", -- replace
    blue = is_light and "#4F6AAF" or "#00afff", -- command
    black = "#000000", -- text on top of the accent colors above
}
return {
    normal = {
        a = { fg = colors.statusline_fg, bg = colors.statusline_bg, gui = "bold" },
        b = { fg = colors.muted_fg, bg = colors.statusline_nc_bg },
        c = { fg = colors.fg, bg = colors.bg },
        y = { fg = colors.muted_fg, bg = colors.statusline_nc_bg },
    },
    insert = {
        a = { fg = colors.statusline_fg, bg = colors.green, gui = "bold" },
    },
    visual = {
        a = { fg = colors.statusline_fg, bg = colors.pink, gui = "bold" },
    },
    replace = {
        a = { fg = colors.statusline_fg, bg = colors.orange, gui = "bold" },
    },
    command = {
        a = { fg = colors.statusline_fg, bg = colors.blue, gui = "bold" },
    },
    -- Statusline of a window that isn't focused.
    inactive = {
        a = { fg = colors.statusline_nc_fg, bg = colors.statusline_nc_bg, gui = "bold" },
        b = { fg = colors.statusline_nc_fg, bg = colors.statusline_nc_bg },
        c = { fg = colors.fg, bg = colors.bg },
    },
}
