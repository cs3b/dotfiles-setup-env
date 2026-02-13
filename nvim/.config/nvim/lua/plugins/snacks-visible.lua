return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.picker = opts.picker or {}
      opts.picker.sources = opts.picker.sources or {}

      local function set_visible_defaults(source)
        opts.picker.sources[source] = vim.tbl_deep_extend("force", opts.picker.sources[source] or {}, {
          hidden = true,
          ignored = true,
          exclude = { ".git" },
        })
      end

      set_visible_defaults("explorer")
      set_visible_defaults("files")
      set_visible_defaults("grep")
      return opts
    end,
  },
}
