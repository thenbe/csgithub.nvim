---@type SearchProvider
local M = {}

--- @param args SearchArgs
local construct_search_field = function(args)
	if not args.betaSearch and args.includeFilename then
		return "filename:"
	elseif not args.betaSearch and args.includeExtension then
		return "extension:"
	else
		return "path:"
	end
end

--- @param args SearchArgs
local construct_query_path = function(args)
	local ext = vim.fn.expand("%:e")

	local onlyExtension = args.includeExtension and not args.includeFilename

	if onlyExtension and args.betaSearch then
		return "*." .. ext
	elseif onlyExtension then
		return "." .. ext
	else
		return vim.fn.expand("%:t")
	end
end

M.construct_query_options = function(args)
	local path = construct_query_path(args)
	local search_field = construct_search_field(args)
	return { search_field .. path }
end

M.construct_url = function(encoded_query)
	local base = "https://github.com/search?type=code&q="
	local url = base .. encoded_query
	return url
end

return M
