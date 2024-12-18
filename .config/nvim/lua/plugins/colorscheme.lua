return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      integrations = { blink_cmp = true },
      transparent_background = true,
      color_overrides = { -- Gruvbox
        mocha = {
          rosewater = "#ea6962",
          flamingo = "#ea6962",
          red = "#ea6962",
          maroon = "#ea6962",
          pink = "#d3869b",
          mauve = "#d3869b",
          peach = "#e78a4e",
          yellow = "#d8a657",
          green = "#a9b665",
          teal = "#89b482",
          sky = "#89b482",
          sapphire = "#89b482",
          blue = "#7daea3",
          lavender = "#7daea3",
          text = "#ebdbb2",
          subtext1 = "#d5c4a1",
          subtext0 = "#bdae93",
          overlay2 = "#a89984",
          overlay1 = "#928374",
          overlay0 = "#595959",
          surface2 = "#4d4d4d",
          surface1 = "#404040",
          surface0 = "#292929",
          base = "#1d2021",
          mantle = "#191b1c",
          crust = "#141617",
        },
      },

      -- Make blink.cmp menu transparent
      function()
        vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "NONE", fg = "#ffffff", blend = 0 })
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
