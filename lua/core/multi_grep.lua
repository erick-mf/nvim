-- local pickers = require("telescope.pickers")
-- local finders = require("telescope.finders")
-- local maker_entry = require("telescope.make_entry")
-- local conf = require("telescope.config").values
--
-- local live_multigrep = function(opts)
-- 	opts = opts or {}
-- 	opts.cwd = opts.cwd or vim.uv.cwd()
--
-- 	local finder = finders.new_async_job({
-- 		command_generator = function(prompt)
-- 			if not prompt or prompt == "" then
-- 				return nil
-- 			end
--
-- 			local pieces = vim.split(prompt, " ") -- Usa dos espacios para separar
-- 			local args = { "rg" }
--
-- 			-- Manejo del patrón de búsqueda en el contenido
-- 			if pieces[1] then
-- 				table.insert(args, "-e")
-- 				table.insert(args, pieces[1]) -- Este es el patrón de búsqueda en el contenido
-- 			end
--
-- 			-- Manejo del filtro de archivos
-- 			if pieces[2] then
-- 				local pattern = pieces[2]:gsub("%*", "*") -- Reemplaza * por .*
-- 				table.insert(args, "--glob")
-- 				table.insert(args, pattern) -- Este es el patrón para los nombres de archivo
-- 			end
--
-- 			-- Comando final para rg
-- 			---@diagnostic disable-next-line: deprecated
-- 			return vim.tbl_flatten({
-- 				args,
-- 				{ "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
-- 			})
-- 		end,
-- 		entry_maker = maker_entry.gen_from_vimgrep(opts),
-- 		cwd = opts.cwd,
-- 	})
--
-- 	pickers
-- 		.new(opts, {
-- 			debounce = 100,
-- 			prompt_title = "Multi Grep",
-- 			finder = finder,
-- 			previewer = conf.grep_previewer(opts),
-- 			sorter = require("telescope.sorters").get_fuzzy_file(),
-- 		})
-- 		:find()
-- end
--
-- vim.keymap.set("n", "<leader>fg", function()
-- 	live_multigrep()
-- end)
--
-- local function mask_previewer(filepath, bufnr, opts)
-- 	if filepath:match("%.env$") then
-- 		local content = vim.fn.readfile(filepath)
-- 		local mask_content = {}
--
-- 		for _, line in ipairs(content) do
-- 			local key, value = line:match("^([^=]+)=(.*)$")
-- 			if key and value then
-- 				table.insert(mask_content, key .. "=" .. string.rep("*", #value))
-- 			else
-- 				table.insert(mask_content, line)
-- 			end
-- 		end
--
-- 		vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, mask_content)
-- 	else
-- 		require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, opts)
-- 	end
-- end
--
-- require("telescope").setup({
-- 	defaults = {
-- 		buffer_previewer_maker = mask_previewer,
-- 	},
-- })
