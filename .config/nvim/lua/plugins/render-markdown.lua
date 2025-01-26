return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    -- Vim modes that will show a rendered view of the markdown file, :h mode(), for
    -- all enabled components. Individual components can be enabled for other modes.
    -- Remaining modes will be unaffected by this plugin. Set to 'true' to enable for all modes.
    render_modes = true,
    heading = {
      sign = true,
      -- Replaces '#+' of 'atx_h._marker'
      -- The number of '#' in the heading determines the 'level'
      -- The 'level' is used to index into the list using a cycle
      -- If the value is a function the input is the nesting level of the heading within sections
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      -- Determines how icons fill the available space:
      --  right:   '#'s are concealed and icon is appended to right side
      --  inline:  '#'s are concealed and icon is inlined on left side
      --  overlay: icon is left padded with spaces and inserted on left hiding any additional '#'
      position = "overlay",
      -- Width of the heading background:
      --  block: width of the heading text
      --  full:  full width of the window
      width = "full",
    },
    code = {
      sign = true,
      style = "full",
    },
  },
  ft = { "markdown", "norg", "rmd", "org", "copilot-chat" },
}
