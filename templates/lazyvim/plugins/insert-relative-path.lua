return {
  {
    "LazyVim/LazyVim",
    keys = {
      {
        "<C-g>p",
        function()
          return vim.fn.expand("%:.")
        end,
        mode = "i",
        expr = true,
        desc = "Insert relative path of current buffer",
      },
    },
  },
}
