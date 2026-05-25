-- vim.api.nvim_set_keymap('n', '<leader>cc', ':copy<CR>', { noremap = true })

vim.keymap.set("i", "jk", "<Esc>")

-- allow the mouse to move the cursor position
vim.keymap.set("n", "<ScrollWheelDown>", "j")
vim.keymap.set("n", "<ScrollWheelUp>", "k")

vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })

vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<cr>")
-- vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- telescope config
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})


-- barbar
vim.keymap.set('n', '<leader>x', '<Cmd>BufferClose<CR>', {})
-- force close a buffer
vim.keymap.set('n', '<leader>X!', '<Cmd>BufferClose!<CR>', {})

vim.keymap.set('n', '<Tab>', '<Cmd>BufferNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferPrevious<CR>', {})

local opts = { buffer = bufnr, noremap = true, silent = true }

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, opts)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

vim.keymap.set('n', '<leader>dl', function()
  vim.diagnostic.setqflist({ open = true })

  vim.wo.wrap = true    -- Enable line wrapping
end)

-- Keybinding to show the diagnostic message for the current line
vim.keymap.set('n', '<leader>de', function()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]  -- Get the current line number
  local diagnostics = vim.diagnostic.get(0, {lnum = current_line - 1})  -- Get diagnostics for the current line (0-indexed)

  if #diagnostics > 0 then
    -- If there are diagnostics, show them
    vim.lsp.diagnostic.show(diagnostics, 0)
  else
    -- No diagnostics for the line, notify the user
    print("No diagnostics for this line")
  end
end)

