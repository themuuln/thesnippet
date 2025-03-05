local M = {}

local function escape_str(s)
	s = s:gsub("\\", "\\\\")
	s = s:gsub('"', '\\"')
	s = s:gsub("\n", "\\n")
	s = s:gsub("\t", "\\t")
	return s
end

local function create_snippet()
	local prefix = vim.fn.input("Enter prefix: ")
	local description = vim.fn.input("Enter description: ")

	local body_lines = {}
	while true do
		local line = vim.fn.input("Enter snippet body line (or 'END' to finish): ")
		if line == "END" then
			break
		end
		table.insert(body_lines, line)
	end

	local lines = {
		'  "' .. escape_str(description) .. '": {',
		'    "prefix": "' .. escape_str(prefix) .. '",',
		'    "body": [',
	}

	for _, line in ipairs(body_lines) do
		table.insert(lines, '      "' .. escape_str(line) .. '",')
	end

	table.insert(lines, "    ],")
	table.insert(lines, '    "description": "' .. escape_str(description) .. '"')
	table.insert(lines, "  }")

	local cur_buf = vim.api.nvim_get_current_buf()
	local cur_line = vim.api.nvim_win_get_cursor(0)[1] - 1 -- Adjust line index
	vim.api.nvim_buf_set_lines(cur_buf, cur_line, cur_line, false, lines)
end

function M.setup()
	vim.api.nvim_create_user_command("SnippetCreate", create_snippet, {})
end

return M
