return { -- indent guides for Neovim
{
    "lukas-reineke/indent-blankline.nvim",
    event = {"BufReadPost", "BufNewFile", "BufWritePre"},
    opts = {
        indent = {
            char = "│",
            tab_char = "│"
        },
        scope = {
            enabled = true
        },
        exclude = {
            filetypes = {"help", "alpha", "dashboard", "neo-tree", "Trouble", "trouble", "lazy", "mason", "notify",
                         "toggleterm", "lazyterm"}
        }
    },
    main = "ibl"
}}
