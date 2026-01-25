-- used in the auto complete
local luasnip = require("luasnip")

-- configure how the auto complete works
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
})

-----------------------------------------------------------------------
-- LSP CONFIGURATION (Neovim 0.11+)
-----------------------------------------------------------------------

-- Lua
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

-- C / C++
vim.lsp.config("clangd", {})

-- C#
vim.lsp.config("csharp_language_server", {})

-- Vue
vim.lsp.config("vue_ls", {
  filetypes = { "vue" },
})

-- TypeScript
vim.lsp.config("vtsls", {})

-- Go
vim.lsp.config("gopls", {
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  settings = {
    gopls = {
      staticcheck = true,
      completeUnimported = true,
    },
  },
})

vim.lsp.config("golangci_lint_ls", {})
vim.lsp.config("goimports", {})

-- Zig
vim.lsp.config("zls", {})

-----------------------------------------------------------------------
-- Enable servers
-----------------------------------------------------------------------

vim.lsp.enable({
  "lua_ls",
  "clangd",
  "csharp_language_server",
  "vue_ls",
  "vtsls",
  "gopls",
  "golangci_lint_ls",
  "goimports",
  "zls",
})

-----------------------------------------------------------------------
-- Go format + organize imports on save
-----------------------------------------------------------------------

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format({ async = false })
    vim.lsp.buf.code_action({
      context = { only = { "source.organizeImports" } },
      apply = true,
    })
  end,
})

