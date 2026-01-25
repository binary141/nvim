-- used in the auto complete
local luasnip = require("luasnip")

-----------------------------------------------------------------------
-- Diagnostics UI
-----------------------------------------------------------------------

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
})

-----------------------------------------------------------------------
-- Completion (nvim-cmp)
-----------------------------------------------------------------------

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
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

-- C / C++
vim.lsp.config("clangd", {})

-- Go
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      staticcheck = true,
      completeUnimported = true,
    },
  },
})

vim.lsp.config("golangci_lint_ls", {})

local vue_language_server_path = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

-- Filetypes for TS / JS / Vue
local ts_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" }

local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vue_language_server_path,
  languages = { "vue" },
  configNamespace = "typescript",
}

-- TypeScript
vim.lsp.config("vtsls", {
  filetypes = ts_filetypes,
  init_options = {
    plugins = { vue_plugin },
  },
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = { vue_plugin },
      },
    },
  },
  root_markers = {'tsconfig.json', 'tsconfig.app.json', 'package.json', 'jsconfig.json', '.git'},
})

-- Vue
-- vim.lsp.config("vue_ls", {
--   filetypes = { "vue" },
--   settings = {
--         vue = {
--             hybridMode = false,
--             inlayHints = {
--                 -- Enable specific inlay hints as needed
--                 enabled = true,
--                 -- ... other inlay hint settings
--             },
--         },
--     },
--   init_options = {
--     takeOverMode = true, -- enables template -> script go-to-definition
--   },
-- })

-- Zig
vim.lsp.config("zls", {})

-----------------------------------------------------------------------
-- Enable servers
-----------------------------------------------------------------------

vim.lsp.enable({
  "lua_ls",
  "clangd",
  "csharp_language_server",
  "vtsls",
  -- "vue_ls",
  "gopls",
  "golangci_lint_ls",
  "goimports",
  "zls",
})

----------------------------------

