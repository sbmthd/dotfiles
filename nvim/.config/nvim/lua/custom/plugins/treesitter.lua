return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      -- Add the languages you want to install
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        'javascript',
        'typescript',
        'vue',
        'scss',
        'css',
        'html',
        'php',
      })
    end,
  },
}
