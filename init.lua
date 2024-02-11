vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Install LazyVim (plugin manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)
-- Load plugins from "plugins" directory
require("lazy").setup("plugins", {})

vim.o.ignorecase = true -- Enable auto write
vim.o.breakindent = true -- Enable break indent
vim.o.completeopt = "menuone,noselect" -- Set completeopt to have a better completion experience
vim.o.termguicolors = true -- NOTE: You should make sure your terminal supports this
vim.o.backup = false
vim.o.swapfile = false
vim.o.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.o.expandtab = true -- Make tab into space
vim.o.timeoutlen = 750 -- Time to press multi caracter shortcut
-- line number
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorlineopt = "number"
vim.o.cursorline = true -- highlight the current line
-- Tabs / Space
vim.o.tabstop = 4
vim.o.shiftround = true -- Round indent (when increment / decrement)
vim.o.shiftwidth = 2 -- Size of an indent
vim.o.sidescrolloff = 8
vim.o.scrolloff = 999
vim.o.smartindent = true -- Insert indents automatically
vim.o.virtualedit = "block" -- Allow cursor to move where there
vim.o.undofile = true
vim.o.undolevels = 10000
vim.o.updatetime = 200 -- Save swap file and trigger CursorHoldis no text in visual block mode
vim.o.wildmode = "longest:full,full" -- Command-line completion mode
vim.o.winminwidth = 5 -- Minimum window width
vim.o.wrap = false -- Disable line wrap

-- Design
vim.cmd.colorscheme("tokyonight-night")
-- vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#787C99", bold = true })
-- vim.api.nvim_set_hl(0, "LineNr", { fg = "#E69B1F", bold = true })
-- vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#787C99", bold = true })

-- -- Highlight on yank
-- -- https://neovim.io/doc/user/lua.html#vim.highlight
-- -- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
--
-- keymap
require("keymap")
require("autocommands")
