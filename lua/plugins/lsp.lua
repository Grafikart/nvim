return { -- lspconfig
{
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        {"williamboman/mason.nvim", config = true}, 
        "williamboman/mason-lspconfig.nvim",
        -- Notification for updates on the LSP        
        { 'j-hui/fidget.nvim', opts = {} },
        -- init.lua support
        'folke/neodev.nvim'
    },
    config = function(_, opts)
        local lspconfig = require("lspconfig")
        lspconfig.gopls.setup({})
        lspconfig.tsserver.setup({})
        lspconfig.phpactor.setup({})
        lspconfig.docker_compose_language_service.setup({})
        lspconfig.dockerls.setup({})
        require("mason").setup()
    end
}, -- autocomplete
{
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp", 
        "hrsh7th/cmp-buffer", 
        "hrsh7th/cmp-path", 
        "hrsh7th/cmp-cmdline",
        -- Snippets (like foreach, html...)
        "rafamadriz/friendly-snippets"
    },
    config = function(_, opts)
        local cmp = require("cmp")
        vim.opt.completeopt = {"menu", "menuone", "noselect"}

        cmp.setup({
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered()
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({
                    select = true
                }) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({{
                name = "nvim_lsp"
            } -- { name = "orgmode" },
            }, {{
                name = "buffer"
            }, {
                name = "path"
            }})
        })
    end
}, {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
        require'lsp_signature'.setup(opts)
    end
}}
