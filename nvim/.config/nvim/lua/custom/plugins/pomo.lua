return {
    "epwalsh/pomo.nvim",
    version = "*", -- Recommended, use latest release instead of latest commit
    lazy = true,
    cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
    dependencies = {
        -- Optional, but highly recommended if you want to use the "Default" timer
        "rcarriga/nvim-notify",
    },
    opts = {
        notifiers = {
            {
                name = "Default",
                opts = {
                    sticky = false,
                },
            },
        },
        sessions = {
            light1h = {
                { name = "Focus", duration = "25m" },
                { name = "Break", duration = "5m" },
                { name = "Focus", duration = "25m" },
                { name = "Break", duration = "5m" },
            },
            light2h = {
                { name = "Focus", duration = "25m" },
                { name = "Break", duration = "5m" },
                { name = "Focus", duration = "25m" },
                { name = "Break", duration = "5m" },
                { name = "Focus", duration = "25m" },
                { name = "Break", duration = "5m" },
                { name = "Focus", duration = "25m" },
                { name = "Break", duration = "5m" },
            },
            focus1h = {
                { name = "Focus", duration = "50m" },
                { name = "Break", duration = "10m" },
            },
            focus2h = {
                { name = "Focus", duration = "50m" },
                { name = "Break", duration = "10m" },
                { name = "Focus", duration = "50m" },
                { name = "Break", duration = "10m" },
            },
        },
    },
}
