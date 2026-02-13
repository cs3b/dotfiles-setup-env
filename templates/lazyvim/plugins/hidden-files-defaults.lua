return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.picker = opts.picker or {}
      opts.picker.sources = opts.picker.sources or {}

      local function extend_source(name, config)
        opts.picker.sources[name] = vim.tbl_deep_extend("force", opts.picker.sources[name] or {}, config)
      end

      local visible_defaults = { hidden = true, ignored = true, exclude = { ".git" } }
      extend_source("explorer", visible_defaults)
      extend_source("files", visible_defaults)
      extend_source("grep", visible_defaults)

      return opts
    end,
  },
}
