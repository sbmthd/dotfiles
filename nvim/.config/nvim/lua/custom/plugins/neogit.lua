return {
  'NeogitOrg/neogit',

  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
    -- 'nvim-telescope/telescope.nvim',
    'ibhagwan/fzf-lua',
  },

  config = function()
    vim.keymap.set('n', '<leader>g', ':Neogit kind=replace<CR>', { noremap = true, silent = true, desc = 'Open Neogit' })
    vim.keymap.set('n', '<leader>gs', ':Neogit kind=split<CR>', { noremap = true, silent = true, desc = 'Open Neogit in split' })
    vim.keymap.set('n', '<leader>gb', ':FzfLua git_branches<CR>', { noremap = true, silent = true, desc = 'Search branches' })
    vim.keymap.set('n', '<leader>gc', ':FzfLua git_commits<CR>', { noremap = true, silent = true, desc = 'Search commits' })

    require('neogit').setup {
      integrations = {
        diffview = true,
        -- telescope = true,
        fzf_lua = true,
      },
      graph_style = 'kitty',
    }
  end,
}
