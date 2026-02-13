return {
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      -- Enable OSC52 clipboard only in SSH sessions.
      if not vim.env.SSH_TTY then
        return opts
      end

      local ok, osc52 = pcall(require, "vim.ui.clipboard.osc52")
      if not ok then
        vim.notify("OSC52 provider is unavailable in this Neovim build", vim.log.levels.WARN)
        return opts
      end

      local function paste_from_unnamed()
        local text = vim.fn.getreg('"')
        local regtype = vim.fn.getregtype('"')
        if text == "" then
          return { {}, regtype }
        end
        return { vim.split(text, "\n", { plain = true }), regtype }
      end

      vim.g.clipboard = {
        name = "osc52-copy-only",
        copy = {
          ["+"] = osc52.copy("+"),
          ["*"] = osc52.copy("*"),
        },
        paste = {
          ["+"] = paste_from_unnamed,
          ["*"] = paste_from_unnamed,
        },
      }

      if not vim.o.clipboard:find("unnamedplus", 1, true) then
        vim.opt.clipboard:append("unnamedplus")
      end

      return opts
    end,
  },
}
