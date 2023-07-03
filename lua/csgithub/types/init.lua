---@alias SearchProviderEnum
---| '"github"'
---| '"sourcegraph"'

---@class SearchArgs
---@field includeFilename boolean
---@field includeExtension boolean
---@field betaSearch boolean Whether to use the newer "Github Code Search" (https://github.com/features/code-search)
---@field provider SearchProviderEnum

---@alias ConstructQueryOptions fun(args: SearchArgs): table<string>

---@class SearchProvider
---@field construct_query_options ConstructQueryOptions
---@field construct_url fun(encoded_query: string): string
