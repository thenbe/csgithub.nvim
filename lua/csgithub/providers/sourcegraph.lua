---@type SearchProvider
local M = {}

--- @param args SearchArgs
local construct_query_path = function(args)
	local ext = vim.fn.expand("%:e")

	local onlyExtension = args.includeExtension and not args.includeFilename

	if onlyExtension then
		return ".*\\." .. ext -- file:.*\.txt
	else
		return "(^|.*\\/)rc\\.lua$" -- file:(^|.*\/)rc\.lua$
	end
end

M.construct_query_options = function(args)
	local path = construct_query_path(args)
	return { "file:" .. path }
end

-- Example: https://sourcegraph.com/search?q=file:.*\.txt+term
M.construct_url = function(encoded_query)
	local base = "https://sourcegraph.com/search?q="
	local url = base .. encoded_query
	return url
end

return M
