local M = {}

-- Return search url
---@param args table|nil
M.search = function(args)
  local default_args = {
    includeFilename = false,
    includeExtension = true,
    betaSearch = false,
  }

  local merged_args = vim.tbl_extend("force", default_args, args or {})

  local query = require("csgithub.query")
  local q = query.construct_query(merged_args)
  local url = query.construct_url(q)

  return url
end

function M.open(url)
  -- return if url is empty
  if url == nil or url == "" then
    print("Error: url is empty!")
    return
  end

  if vim.fn.has("mac") == 1 then
    vim.fn.jobstart({ "open", url }, { detach = true })
  elseif vim.fn.has("unix") == 1 then
    vim.fn.jobstart({ "xdg-open", url }, { detach = true })
  else
    print("Error: unknown open command on this OS!")
  end
end

return M
