vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install LazyVim (plugin manager)
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

local opt = vim.opt

opt.rtp:prepend(lazypath)

-- Load plugins from "plugins" directory
require("lazy").setup("plugins", {})

opt.ignorecase = true -- Enable auto write
opt.breakindent = true -- Enable break indent
opt.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience
opt.termguicolors = true -- NOTE: You should make sure your terminal supports this
opt.expandtab = true -- Make tab into space
opt.number = true -- line number
opt.relativenumber = true -- line number
opt.shiftround = true -- Round indent (when increment / decrement)
opt.shiftwidth = 2 -- Size of an indent
opt.sidescrolloff = 8
opt.scrolloff = 999
opt.smartindent = true -- Insert indents automatically
opt.virtualedit = "block" -- Allow cursor to move where there 
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHoldis no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap

-- Design
vim.cmd.colorscheme("tokyonight-night")

-- Highlight on yank
-- https://neovim.io/doc/user/lua.html#vim.highlight
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- keymap
require("keymap")
