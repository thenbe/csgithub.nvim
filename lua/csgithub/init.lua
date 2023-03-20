local M = {}

-- Return search url
---@param args table|nil
M.search = function(args)
	local default_args = {
		includeFilename = false,
		includeExtension = true,
	}

	local merged_args = vim.tbl_extend("force", default_args, args or {})

	local query = require("csgithub.query")
	local q = query.construct_query(merged_args)
	local url = query.construct_url(q)

	return url
end

return M
