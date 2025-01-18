return {
  'famiu/bufdelete.nvim',
  config = function()
    vim.keymap.set('n', '<leader>bd', ':Bdelete<CR>', { desc = 'Delete buffer (preserve layout)' })
    vim.keymap.set('n', '<leader>bdd', ':Bdelete!<CR>', { desc = 'Force delete buffer (preserve layout)' })
  end,
}
