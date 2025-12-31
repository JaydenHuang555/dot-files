require("core.options") -- Load general options
require("core.keymaps") -- Load general keymaps
require("core.snippets") -- Custom code snippets

-- Normal Mode mappings
vim.api.nvim_set_keymap("n", "<Up>", "k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Down>", "j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Left>", "h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Right>", "l", { noremap = true, silent = true })

-- Insert Mode mappings (optional, as arrow keys usually work by default)
vim.api.nvim_set_keymap("i", "<Up>", "<C-o>k", { noremap = true, silent = true }) -- <C-o> allows a single normal mode command
vim.api.nvim_set_keymap("i", "<Down>", "<C-o>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<Left>", "<C-o>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<Right>", "<C-o>l", { noremap = true, silent = true })

-- Visual Mode mappings (for selecting text with arrow keys)
vim.api.nvim_set_keymap("v", "<Up>", "k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Down>", "j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Left>", "h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Right>", "l", { noremap = true, silent = true })

vim.opt.fixeol = false

-- Set up the Lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

if vim.env.WAYLAND_DISPLAY and vim.fn.executable("wl-copy") and vim.fn.executable("wl-paste") then
	vim.g.clipboard = {
		name = "wl-copy",
		copy = {
			["+"] = { "wl-copy", "--type", "text/plain" },
			["*"] = { "wl-copy", "--primary", "--type", "text/plain" },
		},
		paste = {
			["+"] = { "wl-paste", "--no-newline" },
			["*"] = { "wl-paste", "--no-newline", "--primary" },
		},
	}
end

vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

-- Set up plugins
require("lazy").setup({
	require("plugins.neotree"),
	require("plugins.signature"),
	require("plugins.colortheme"),
	require("plugins.bufferline"),
	require("plugins.lualine"),
	require("plugins.treesitter"),
	require("plugins.telescope"),
	require("plugins.lsp"),
	require("plugins.autocompletion"),
	require("plugins.none-ls"),
	require("plugins.gitsigns"),
	require("plugins.alpha"),
	require("plugins.indent-blankline"),
	require("plugins.misc"),
	require("plugins.comment"),
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
