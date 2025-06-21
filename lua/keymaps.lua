local opts = {
    noremap = true, -- non-recursive
    -- silent = true,       -- do not show message
}

vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Get info" })
vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "Get definition" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, { desc = "Get references" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Get code actions" })

vim.keymap.set("n", "<leader>f", function()
    require("conform").format({ lsp_fallback = true })
end, { desc = "Format file" })


-- misc
vim.keymap.set({ "n", "i" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "b-b-BAN hl" })
vim.keymap.set("n", "<leader>n", "<cmd>Neotree toggle<cr>", { desc = "File Explorer" })
vim.keymap.set("n", "<leader>Rf", "<cmd>RustFmt<cr>", { desc = "Fmt Rust code" })
vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<cr>", { desc = "Zen" })
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format file" })


-- nav
vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "left" })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "down" })
vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "up" })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "right" })

vim.keymap.set("n", "<leader>L", "<cmd>tabnext<cr>", { desc = "right" })
vim.keymap.set("n", "<leader>H", "<cmd>tabprevious<cr>", { desc = "right" })
