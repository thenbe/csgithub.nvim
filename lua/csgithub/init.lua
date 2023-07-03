local M = {}

-- Return search url
---@param args SearchArgs|nil
M.search = function(args)
	---@type SearchArgs
	local default_args = {
		includeFilename = false,
		includeExtension = true,
		betaSearch = true,
		provider = "github",
	}

	local merged_args = vim.tbl_extend("force", default_args, args or {})

	local query = require("csgithub.query")
	local q = query.construct_query(merged_args)
	if q == nil then
		return nil
	end
	local url = query.construct_url(q, merged_args)

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
