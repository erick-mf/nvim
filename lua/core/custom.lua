local groupErick = vim.api.nvim_create_augroup("GroupErick", { clear = true })

-- quitar autocomentado en la siguiente linea
vim.cmd([[au BufEnter * set fo-=c fo-=r fo-=o]])

-- undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Disable the concealing in some file formats
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = groupErick,
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		vim.wo.conceallevel = 0
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = groupErick,
	callback = function()
		if vim.bo.modifiable and not vim.bo.readonly then
			-- local view = vim.fn.winsaveview()
			vim.cmd([[silent! %s/\r//ge]])
			vim.cmd([[silent! %s/\s\+$//ge]])
			-- vim.fn.winrestview(view)
		end
	end,
})

vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#FFA500" })
vim.api.nvim_create_autocmd("TextYankPost", {
	group = groupErick,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "YankHighlight",
			timeout = 40,
		})
	end,
})

---@diagnostic disable-next-line: deprecated
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

-- Disable semantic highlight
local disable_semantic_highlight = function()
	local compl = vim.fn.getcompletion("@lsp", "highlight")
	for _, group in ipairs(compl) do
		vim.api.nvim_set_hl(0, group, {})
	end
end

vim.api.nvim_create_autocmd("ColorScheme", {
	desc = "Disable semantic highlights",
	callback = disable_semantic_highlight,
})
disable_semantic_highlight()

local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }

vim.diagnostic.config({
	update_in_insert = false,
	virtual_text = {
		spacing = 5,
		severity = {
			min = vim.diagnostic.severity.WARN,
		},
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = signs.Error,
			[vim.diagnostic.severity.WARN] = signs.Warn,
			[vim.diagnostic.severity.HINT] = signs.Hint,
			[vim.diagnostic.severity.INFO] = signs.Info,
		},
		texthl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
		},
	},
	float = {
		border = "rounded",
		focusable = false,
		source = true,
		style = "minimal",
		preview = "",
	},
})
