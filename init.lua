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

if vim.loop.os_uname().sysname == 'Linux' then vim.opt.shell = 'bash' else  vim.opt.shell = 'cmd.exe' end
vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])


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
local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup { indent = { highlight = highlight } }
-- Final settings
require("core")
pcall(require, "custom")
