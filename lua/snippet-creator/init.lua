local M = {}

local function escape_str(s)
	s = s:gsub("\\", "\\\\")
	s = s:gsub('"', '\\"')
	s = s:gsub("\n", "\\n")
	s = s:gsub("\t", "\\t")
	return s
end

local function get_input(prompt, callback)
	vim.ui.input({ prompt = prompt, default = "" }, function(input)
		if input and input ~= "" then
			callback(input)
		else
			print("Aborted: No input provided for " .. prompt)
		end
	end)
end

local function create_snippet()
	print("[Snippet Creator] Starting...")

	get_input("Enter prefix: ", function(prefix)
		get_input("Enter description: ", function(description)
			local body_lines = {}

			local function collect_body()
				get_input("Enter snippet body line (or 'END' to finish): ", function(line)
					if line == "END" then
						local lines = {
							'  "' .. escape_str(description) .. '": {',
							'    "prefix": "' .. escape_str(prefix) .. '",',
							'    "body": [',
						}

						for _, body_line in ipairs(body_lines) do
							table.insert(lines, '      "' .. escape_str(body_line) .. '",')
						end

						table.insert(lines, "    ],")
						table.insert(lines, '    "description": "' .. escape_str(description) .. '"')
						table.insert(lines, "  }")

						local cur_buf = vim.api.nvim_get_current_buf()
						local cur_line = vim.api.nvim_win_get_cursor(0)[1]
						vim.api.nvim_buf_set_lines(cur_buf, cur_line, cur_line, false, lines)

						print("[Snippet Creator] Snippet inserted successfully!")
					else
						table.insert(body_lines, line)
						collect_body()
					end
				end)
			end

			collect_body()
		end)
	end)
end

function M.setup()
	vim.api.nvim_create_user_command("SnippetCreate", create_snippet, {})
	print("[Snippet Creator] Plugin Loaded! Use :SnippetCreate")
end

return M
