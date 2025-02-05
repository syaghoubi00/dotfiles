-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Move Lines
vim.keymap.set("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "Move Line Down" })
vim.keymap.set("n", "<A-Up>", "<cmd>m .-2<cr>==", { desc = "Move Line Up" })
vim.keymap.set("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "Move Block Down" })
vim.keymap.set("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "Move Block Up" })

--[[
Disable opening the neovim help page with F1,
am always hitting F1 instead of escape (right next to eachother on kb),
was going to map to <Nop>, but might as well map to <Esc>,
since that was probably what I was trying to do anyway.
]]
vim.api.nvim_set_keymap("n", "<F1>", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<F1>", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<F1>", "<Esc>", { noremap = true, silent = true })

-- Disable macro recording
vim.api.nvim_set_keymap("n", "q", "<Nop>", { noremap = true, silent = true })
