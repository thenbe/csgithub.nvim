local M = {}

---@param str string
function M.url_encode(str)
	return string.gsub(str, "[^%w%-%.%_~]", function(char)
		return string.format("%%%02X", string.byte(char))
	end)
end

function M.get_visual_selection()
	-- Exit visual mode, otherwise `getpost` will return postion of the last visual selection
	local ESC_FEEDKEY = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
	vim.api.nvim_feedkeys(ESC_FEEDKEY, "n", true)
	vim.api.nvim_feedkeys("gv", "x", false)
	vim.api.nvim_feedkeys(ESC_FEEDKEY, "n", true)

	local _, start_row, start_col, _ = unpack(vim.fn.getpos("'<"))
	local _, end_row, end_col, _ = unpack(vim.fn.getpos("'>"))
	start_row = start_row - 1
	end_row = end_row - 1

	local lines = vim.api.nvim_buf_get_lines(0, start_row, end_row + 1, false)
	if #lines == 1 then
		lines[1] = string.sub(lines[1], start_col, end_col)
	else
		lines[1] = string.sub(lines[1], start_col)
		lines[#lines] = string.sub(lines[#lines], 1, end_col)
	end
	return table.concat(lines, "\n")
end

return M
