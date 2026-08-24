local is_light = vim.o.background == "light"

local colors = {
    -- Plain buffer text, from quiet's `Normal` group. Used for lualine_c,
    -- the largest/plainest section (e.g. filename).
    fg = is_light and "#000000" or "#dadada",
    bg = is_light and "#e2e2e2" or "#000000",
    -- The active statusline's own colors, from quiet's `StatusLine` group.
    -- Deliberately inverted polarity vs. `fg`/`bg` above (that's what made
    -- "auto" break) — used for lualine_a, the bold mode indicator.
    statusline_fg = is_light and "#eeeeee" or "#000000",
    statusline_bg = is_light and "#000000" or "#dadada",
    -- The *inactive* statusline's colors, from quiet's `StatusLineNC`
    -- group. Used for lualine_b (branch/diff/diagnostics) and as the
    -- inactive-window variant of lualine_a/b.
    statusline_nc_fg = is_light and "#000000" or "#707070",
    statusline_nc_bg = is_light and "#181818" or "#000000",
    -- Muted fg for softer sections (branch, progress) — quiet, but still
    -- readable on statusline_nc_bg in both variants. In light mode we need
    -- something dark enough to contrast against #181818; in dark mode the
    -- original #bababa on #000000 is what we're preserving.
    muted_fg = is_light and "#eeeeee" or "#bababa",
    -- Accent colors below are quiet's fixed "niceties" (Search, Visual,
    -- DiffAdd, Error) — quiet renders them the same way in both variants,
    -- so unlike the pairs above they don't need a light/dark branch.
    -- Used for lualine_a's background per mode, so each mode is still
    -- visually distinguishable at a glance.
    green = is_light and "#537A79" or "#00af00", -- insert
    orange = is_light and "#c88a3f" or "#ffaf00", -- visual
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
