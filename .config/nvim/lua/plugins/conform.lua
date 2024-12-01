return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      shfmt = {
        -- Indent with 2 spaces instead of tabs and indent case statements per Google style guide (https://google.github.io/styleguide/shell.xml)
        prepend_args = { "-i", "2", "-ci" },
      },
    },
  },
}
