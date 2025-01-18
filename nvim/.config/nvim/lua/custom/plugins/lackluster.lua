return {
  'slugbyte/lackluster.nvim',
  lazy = false,
  priority = 100,
  -- init = function()
  --   vim.cmd.colorscheme 'lackluster-hack'
  -- end,
  config = function()
    -- Apply the colorscheme first
    vim.cmd.colorscheme 'lackluster-hack'
  end,
}
