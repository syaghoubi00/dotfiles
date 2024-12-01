return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-emoji",
    "uga-rosa/cmp-dictionary",
    "f3fora/cmp-spell",
  },
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    table.insert(opts.sources, {
      name = "emoji",
      insert = false,
    })
    --[[ table.insert(opts.sources, {
      name = "spell",
      option = {
        keep_all_entries = true,
      },
    }) ]]
    table.insert(opts.sources, {
      name = "dictionary",
      keywork_length = 2,
    })

    -- opts.view = {
    --   entries = {
    --     selection_order = "near_cursor",
    --   },
    -- }

    local cmp = require("cmp")

    require("cmp_dictionary").setup({
      paths = { "/usr/share/dict/words" },
      exact_length = 2,
    })

    vim.api.nvim_set_hl(0, "CmpPmenu", { bg = "NONE", fg = "#ffffff", blend = 0 })
    local win_opt = {
      -- winhighlight = "Normal:Pmenu,FloatBorder:PmenuExtra,CursorLine:PmenuSel,Search:None",
      winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenu,CursorLine:PmenuSel,Search:None",
    }
    opts.window = {
      completion = cmp.config.window.bordered(win_opt),
      -- completion = win_opt,
      documentation = cmp.config.window.bordered(win_opt),
      -- documentation = win_opt,
    }

    -- local has_words_before = function()
    --   unpack = unpack or table.unpack
    --   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    --   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    -- end

    local luasnip = require("luasnip")

    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<Up>"] = cmp.mapping.close(),
      ["<Down>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.close(),

      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm({ select = true })
          -- if #cmp.get_entries() == 1 then
          --   cmp.confirm({ select = true })
          -- else
          --   cmp.select_next_item()
          -- end
        elseif luasnip.locally_jumpable(1) then
          luasnip.jump(1)
          -- elseif has_words_before() then
          -- if #cmp.get_entries() == 1 then
          --   cmp.confirm({ select = true })
          -- end
          -- cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    })
  end,
}
