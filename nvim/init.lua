if vim.g.vscode then
    vim.opt.syntax = "off"
    vim.keymap.set("n", "<Tab>", ":Tabnext<CR>")
    vim.keymap.set("n", "<S-Tab>", ":Tabprev<CR>")

    keymap("n", "<Space>", "", opts)
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "
    keymap({"n"}, "<leader>f", "<cmd>lua require('vscode').action('workbench.files.action.focusFilesExplorer')<CR>")
    return
end

vim.opt.mouse="a"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
-- vim.opt.colorcolumn = "80"

require("config")
require("config.keymap")
require("config.packer")
