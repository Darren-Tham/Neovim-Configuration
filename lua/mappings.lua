require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
map("i", "jk", "<ESC>")
map("n", "<leader>tt", ":lua require(\"jdtls\").extract_variable()<CR>", { desc = "Gay boi " })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    local buf = vim.lsp.buf
    map("n", "<leader>lr", buf.references, { desc = "lists all references" })
    map("n", "<leader>li", buf.implementation, { desc = "lists all implementations" })
    map("n", "<leader>lc", buf.code_action, { desc = "list code actions" })
    map("n", "<leader>ls", buf.document_symbol, { desc = "list all symbols" })
    map("n", "<leader>ln", buf.rename, { desc = "rename" })
    map("n", "<leader>lh", buf.signature_help, { desc = "display method signature information" })
  end
})
