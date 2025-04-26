vim.keymap.set(
    "n",
    "<A-q>",
    ":lua ToggleQuickfix()<CR>",
    { noremap = true, silent = true, desc = "Toggle quickfix list" }
)

function ToggleQuickfix()
    local qf_exists = false
    for _, win in ipairs(vim.fn.getwininfo()) do
        if win["quickfix"] == 1 then
            qf_exists = true
            break
        end
    end
    if qf_exists then
        vim.cmd("cclose")
    else
        vim.cmd("copen")
    end
end

return {
    "kevinhwang91/nvim-bqf",

    "junegunn/fzf",
    run = function()
        vim.fn["fzf#install"]()
    end,
}
