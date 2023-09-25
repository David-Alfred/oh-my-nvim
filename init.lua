-- Basic settings
require("basic")

-- Load plugins
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

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"


vim.g.mapleader = require("custom_keys").leader
vim.g.maplocalleader = "\\"
vim.g.encoding="utf-8"
vim.o.fileencodings="utf-8"
vim.g.goyo_height="95%"
vim.wo.wrap = true
vim.wo.linebreak = true
vim.wo.list = false -- extra option I set in addition to the ones in your question
require("lazy").setup({
	spec = {
		{ import = "plugins" },
		{ import = "languages" },
		{ import = "my_plugins" },
	},
	ui = {
		border = "rounded",
	},
	change_detection = {
		enabled = true,
		notify = false, -- get a notification when changes are found
	},
})
require('bookmarks').setup {
	-- sign_priority = 8,  --set bookmark sign priority to cover other sign
	save_file = vim.fn.expand "$HOME/.bookmarks", -- bookmarks save file path
	keywords =  {
	  ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
	  ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
	  ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
	  ["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
	},
	on_attach = function(bufnr)
	  local bm = require "bookmarks"
	  local map = vim.keymap.set
	  map("n","mm",bm.bookmark_toggle) -- add or remove bookmark at current line
	  map("n","mi",bm.bookmark_ann) -- add or edit mark annotation at current line
	  map("n","mc",bm.bookmark_clean) -- clean all marks in local buffer
	  map("n","mn",bm.bookmark_next) -- jump to next mark in local buffer
	  map("n","mp",bm.bookmark_prev) -- jump to previous mark in local buffer
	  map("n","ml",bm.bookmark_list) -- show marked file list in quickfix window
	end
}
require'lspconfig'.typst_lsp.setup{
	settings = {
		exportPdf = "onSave" -- Choose onType, onSave or never.
        -- serverPath = "" -- Normally, there is no need to uncomment it.
	}
}
vim.filetype.add({ extension = {typ = "typst"}})
-- Final settings
require("core")
pcall(require, "custom")
