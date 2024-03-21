return {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
-- or                              , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' },
      lazy = false,
      opts = {},
      keys = {
        {"<leader>fs", function () require('telescope.builtin').lsp_document_symbols() end, desc = "Document symbols"},
        {"<leader>ws", function () require('telescope.builtin').lsp_dynamic_workspace_symbols() end, desc = "Workspace symbols"}
      }
    }