return {
  "iamcco/markdown-preview.nvim",
  init = function()
    vim.cmd([[
      function OpenMarkdownPreview (url)
        " Check if inside toolbox/distrobox to use host browser
        if filereadable("/run/.containerenv") && executable("/bin/flatpak-spawn")
          " use xdg-open to default to preferred browser
          execute "silent ! flatpak-spawn --host xdg-open " . a:url
        else
          execute "silent ! xdg-open " . a:url
        endif
      endfunction
      ]])
    vim.g.mkdp_browserfunc = "OpenMarkdownPreview"

    -- Show URL of preview in notification
    -- vim.g.mkdp_echo_preview_url = 1
  end,
}
