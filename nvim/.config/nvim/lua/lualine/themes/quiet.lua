-- Tailored lualine theme for Neovim's builtin "quiet" colorscheme.
--
-- lualine's "auto" theme doesn't work here: quiet deliberately renders its
-- StatusLine group with inverted polarity relative to the background (e.g.
-- a light-on-dark statusline while the buffer itself is light-on-dark's
-- opposite), and "auto" mixes fg/bg pulled from unrelated highlight groups
-- across that inversion — e.g. Normal's text color ends up paired with
-- StatusLine's background, both landing on black in the light variant,
-- so lualine_c renders as unreadable black-on-black. Define the palette
-- explicitly instead, using quiet's actual rendered colors (i.e. with its
-- `gui=reverse` groups already resolved).
local is_light = vim.o.background == "light"
local colors = {
    -- Plain buffer text, from quiet's `Normal` group. Used for lualine_c,
    -- the largest/plainest section (e.g. filename).
    fg = is_light and "#000000" or "#dadada",
    bg = is_light and "#c2c2c2" or "#000000",
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
    green = is_light and "#7ba87b" or "#00af00", -- insert
    orange = is_light and "#c88a3f" or "#ffaf00", -- visual
    pink = is_light and "#b85670" or "#ff005f", -- replace
    blue = is_light and "#5383A2" or "#00afff", -- command
    black = "#000000", -- text on top of the accent colors above
}
return {
    -- normal/insert/visual/replace/command each style lualine_a (the mode
    -- indicator, leftmost). Only "normal" also sets b/c/y (branch+diagnostics,
    -- filename, progress) — lualine falls back to normal's sections for every
    -- other mode when they're left unset, so we don't repeat them below.
    normal = {
        a = { fg = colors.statusline_fg, bg = colors.statusline_bg, gui = "bold" },
        b = { fg = colors.muted_fg, bg = colors.statusline_nc_bg },
        c = { fg = colors.fg, bg = colors.bg },
        y = { fg = colors.muted_fg, bg = colors.statusline_nc_bg },
    },
    insert = {
        a = { fg = colors.black, bg = colors.green, gui = "bold" },
    },
    visual = {
        a = { fg = colors.black, bg = colors.orange, gui = "bold" },
    },
    replace = {
        a = { fg = colors.black, bg = colors.pink, gui = "bold" },
    },
    command = {
        a = { fg = colors.black, bg = colors.blue, gui = "bold" },
    },
    -- Statusline of a window that isn't focused.
    inactive = {
        a = { fg = colors.statusline_nc_fg, bg = colors.statusline_nc_bg, gui = "bold" },
        b = { fg = colors.statusline_nc_fg, bg = colors.statusline_nc_bg },
        c = { fg = colors.fg, bg = colors.bg },
    },
}
