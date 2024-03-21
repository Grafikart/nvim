return { -- lspconfig
{
    "neovim/nvim-lspconfig",
    dependencies = { -- Automatically install LSPs to stdpath for neovim
    {
        "williamboman/mason.nvim",
        config = true
    }, "williamboman/mason-lspconfig.nvim", -- Notification for updates on the LSP
    {
        "j-hui/fidget.nvim",
        opts = {}
    }, -- init.lua support
    "folke/neodev.nvim"},
    config = function(_, opts)
        local lspconfig = require("lspconfig")
        lspconfig.gopls.setup({})
        lspconfig.tsserver.setup({})
        lspconfig.phpactor.setup({})
        lspconfig.docker_compose_language_service.setup({})
        lspconfig.dockerls.setup({})
        lspconfig.emmet_language_server.setup({
            filetypes = {"css", "html", "javascript", "javascriptreact", "less", "sass", "scss", "php",
                         "typescriptreact"},
            -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
            init_options = {
                --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
                preferences = {},
                --- @type boolean Defaults to `true`
                showAbbreviationSuggestions = true,
                --- @type "always" | "never" Defaults to `"always"`
                showExpandedAbbreviation = "always",
                --- @type boolean Defaults to `false`
                showSuggestionsAsSnippets = false,
                --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
                syntaxProfiles = {},
                --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
                variables = {}
            }
        })
        require("mason").setup()

        -- lsp
        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = {
                    buffer = ev.buf
                }
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set("n", "<space>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
                vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
                vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set({"n", "v"}, "<space>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<space>f", function()
                    vim.lsp.buf.format({
                        async = true
                    })
                end, opts)
            end
        })
    end
}, -- autocomplete
{
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", -- "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline", -- Snippets (like foreach, html...)
    "rafamadriz/friendly-snippets", -- Icon for suggestion
    "onsails/lspkind.nvim", -- Snippet engine
    "L3MON4D3/LuaSnip"},
    config = function(_, opts)
        local cmp = require("cmp")
        vim.opt.completeopt = {"menu", "menuone", "noselect"}

        -- Add () when inserting a method
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

        cmp.setup({
            formatting = {
                fields = {"kind", "abbr", "menu"},
                format = function(entry, vim_item)
                    local kind = require("lspkind").cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50
                    })(entry, vim_item)
                    local strings = vim.split(kind.kind, "%s", {
                        trimempty = true
                    })
                    kind.kind = " " .. (strings[1] or "") .. " "
                    -- kind.menu = "    (" .. (strings[2] or "") .. ")"

                    return kind
                end
            },
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                end
            },
            window = {
                -- completion = cmp.config.window.bordered(),
                completion = {
                    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                    col_offset = -3,
                    side_padding = 0
                },
                documentation = cmp.config.window.bordered()
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<Tab>"] = cmp.mapping.select_next_item(),
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
    opts = {
        floating_window = true,
        hint_prefix = "🐤",
        hint_enable = true
    }
}}
