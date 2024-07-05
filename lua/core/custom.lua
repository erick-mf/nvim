local groupErick = vim.api.nvim_create_augroup("GroupErick", { clear = true })

-- quitar autocomentado en la siguiente linea
vim.cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- undercurl
vim.cmd [[let &t_Cs = "\e[4:3m"]]
vim.cmd [[let &t_Ce = "\e[4:0m"]]

-- Disable the concealing in some file formats
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = groupErick,
    pattern = { "json", "jsonc", "markdown" },
    callback = function()
        vim.wo.conceallevel = 0
    end,
})

--turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
    group = groupErick,
    pattern = "*",
    command = "set nopaste",
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = groupErick,
    callback = function()
        vim.cmd [[%s/\s\+$//e]]
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = groupErick,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end
})

vim.diagnostic.config {
    update_in_insert = false,
    virtual_text = {
        spacing = 5,
        severity = {
            min = vim.diagnostic.severity.WARN
        }
    },
    float = {
        border = "rounded",
        focusable = false,
        source = true,
        style = "minimal",
        preview = ""
    },
}

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'rounded' }
)

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

-- Change the Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
