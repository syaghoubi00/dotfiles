-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- YAML key sorting
-- NOTE: There is a Code Action to sort keys, but it is not recursive
vim.api.nvim_create_autocmd("FileType", {
  pattern = "yaml",
  callback = function()
    vim.api.nvim_create_user_command("SortYamlKeys", function()
      vim.cmd('%!yq --prettyPrint "sort_keys(..)" -')
    end, {})

    vim.keymap.set("n", "<leader>cs", "<cmd>SortYamlKeys<CR>", { desc = "Sort YAML Keys", buffer = true })
  end,
})
