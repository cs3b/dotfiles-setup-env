local function current_path(absolute)
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then
    return nil
  end
  if absolute then
    return vim.fn.fnamemodify(path, ":p")
  end
  return vim.fn.fnamemodify(path, ":.")
end

local function copy_text(label, text)
  if not text or text == "" then
    vim.notify("No file path available", vim.log.levels.WARN)
    return
  end
  vim.fn.setreg("+", text)
  vim.fn.setreg('"', text)
  vim.notify("Copied " .. label .. ": " .. text)
end

local function copy_file(absolute)
  copy_text(absolute and "absolute file path" or "relative file path", current_path(absolute))
end

local function copy_file_with_line(absolute)
  local path = current_path(absolute)
  if not path then
    copy_text("path", nil)
    return
  end
  local line = vim.api.nvim_win_get_cursor(0)[1]
  copy_text(
    absolute and "absolute file:line path" or "relative file:line path",
    string.format("%s:%d", path, line)
  )
end

local function copy_dir(absolute)
  local path = current_path(absolute)
  if not path then
    copy_text("path", nil)
    return
  end
  copy_text(absolute and "absolute directory path" or "relative directory path", vim.fn.fnamemodify(path, ":h"))
end

return {
  {
    "LazyVim/LazyVim",
    keys = {
      { "ypf", function() copy_file(false) end, desc = "Yank path: relative file" },
      { "ypl", function() copy_file_with_line(false) end, desc = "Yank path: relative file:line" },
      { "ypd", function() copy_dir(false) end, desc = "Yank path: relative directory" },
      { "ypF", function() copy_file(true) end, desc = "Yank path: absolute file" },
      { "ypL", function() copy_file_with_line(true) end, desc = "Yank path: absolute file:line" },
      { "ypD", function() copy_dir(true) end, desc = "Yank path: absolute directory" },
    },
  },
}
