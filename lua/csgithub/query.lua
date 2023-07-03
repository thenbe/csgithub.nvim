local M = {}

--- useful for visual line mode when extra whitespace is
--- included in search query
--- @param s string
local function trim_string(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"))
end

M.construct_query_text = function()
	local utils = require("csgithub.utils")
	local text = ""
	local mode = vim.api.nvim_get_mode().mode
	if mode == "v" or mode == "V" then
		-- visual mode, visual line mode
		text = trim_string(utils.get_visual_selection())
	else
		-- normal mode
		text = vim.fn.expand("<cword>")
	end
	return text
end

-- Return search url
---@param args SearchArgs
M.construct_query = function(args)
	local query_parts = {}

	---@type SearchProvider
	local provider = M.get_provider(args)

	-- query options (eg. path:myfile.txt, extension:txt, etc.)
	if args.includeFilename or args.includeExtension then
		query_parts = provider.construct_query_options(args)
	end

	-- text
	local query_text = M.construct_query_text()
	if query_text == "" then
		return nil
	end
	table.insert(query_parts, query_text)

	local query = table.concat(query_parts, " ")
	return query
end

---@param args SearchArgs
---@return SearchProvider
M.get_provider = function(args)
	if args.provider == "sourcegraph" then
		return require("csgithub.providers.sourcegraph")
	else
		return require("csgithub.providers.github")
	end
end

---@param url_query string
---@param args SearchArgs
M.construct_url = function(url_query, args)
	local utils = require("csgithub.utils")
	local encoded_query = utils.url_encode(url_query)
	local provider = M.get_provider(args)
	return provider.construct_url(encoded_query)
end

return M
