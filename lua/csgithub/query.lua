local M = {}

M.construct_query_path = function(args)
	local ext = vim.fn.expand("%:e")

	if args.includeExtension and not args.includeFilename then
		return "*." .. ext
	else
		return vim.fn.expand("%:t")
	end
end

M.construct_query_text = function()
	local utils = require("csgithub.utils")
	local text = ""
	if vim.fn.mode() == "v" then
		-- visual mode
		text = utils.get_visual_selection()
	else
		-- normal mode
		text = vim.fn.expand("<cword>")
	end

	return text
end

-- Return search url
---@param args table
M.construct_query = function(args)
	local query_parts = {}

	-- path:
	if args.includeFilename or args.includeExtension then
		local path = M.construct_query_path(args)
		table.insert(query_parts, "path:" .. path)
	end

	-- text
	table.insert(query_parts, M.construct_query_text())

	return table.concat(query_parts, " ")
end

---@param query string
M.construct_url = function(query)
	local utils = require("csgithub.utils")
	local encoded_query = utils.url_encode(query)
	local base = "https://github.com/search?type=code&q="
	local url = base .. encoded_query
	return url
end

return M
