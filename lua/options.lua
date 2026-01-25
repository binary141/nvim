-- vim.opt.clipboard = 'unnamedplus'   -- use system clipboard 
vim.opt.clipboard = ""  -- Disable system clipboard integration
vim.opt.completeopt = {'menu', 'menuone', 'noselect'} -- completion behaviour
vim.opt.mouse = 'v'                 -- allow the mouse to be used in visual mode

-- Tab defaults
vim.opt.tabstop = 4                 -- number of visual spaces per TAB
vim.opt.softtabstop = 4             -- number of spacesin tab when editing
vim.opt.shiftwidth = 4              -- insert 4 spaces on a tab
vim.opt.expandtab = true            -- tabs are spaces, mainly because of python

-- file type specific tab settings
local ft_space_settings = {
  -- 2 spaces
  javascript = 2,
  vue = 2,
  typescript = 2,
  lua        = 2,
  json       = 2,
  yaml       = 2,
  html       = 2,
  css        = 2,
  markdown   = 2,
  toml       = 2,
  arduino    = 2,
  c          = 2,
  cpp        = 2,

  -- 4 spaces
  python     = 4,
  java       = 4,
  rust       = 4,
  sh         = 4,
  cmake      = 4,
  vim        = 4,
  php        = 4,

  -- file types that use actual tabs
  go         = "tab",
  dockerfile = "tab",
  make       = "tab",
}

for ft, setting in pairs(ft_space_settings) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = ft,
    callback = function()
      if setting == "tab" then
        vim.bo.expandtab = false
        vim.bo.tabstop = 4
        vim.bo.shiftwidth = 4
        vim.bo.softtabstop = 0
      else
        vim.bo.expandtab = true
        vim.bo.tabstop = setting
        vim.bo.shiftwidth = setting
        vim.bo.softtabstop = setting
      end
    end,
  })
end

-- UI config
vim.opt.number = true               -- show absolute number
vim.opt.relativenumber = false       -- add numbers to each line on the left side
vim.opt.cursorline = true           -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true           -- open new vertical split bottom
vim.opt.splitright = true           -- open new horizontal splits right
vim.opt.termguicolors = true       -- Enable 24-bit RGB color in the TUI (better color support)
vim.opt.showmode = false            -- we are experienced, wo don't need the "-- INSERT --" mode hint
vim.opt.scrolloff = 8              -- Minimum number of screen lines to keep above and below the cursor
vim.opt.guicursor = ""             -- Use default block cursor in all modes
vim.opt.wrap = false               -- Don't wrap lines; long lines extend beyond the screen

-- Searching
vim.opt.incsearch = true            -- search as characters are entered
vim.opt.hlsearch = false            -- do not highlight matches
vim.opt.ignorecase = true           -- ignore case in searches by default
vim.opt.smartcase = true            -- but make it case sensitive if an uppercase is entered

vim.opt.smartindent = false        -- Disable smart auto-indenting (normally tries to indent based on syntax)

-- File Management
vim.opt.swapfile = false           -- Don't use a swap file (avoids .swp files)
vim.opt.backup = false             -- Don't create backup files
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"  -- Directory to store undo history files
vim.opt.undofile = true            -- Enable persistent undo (undo after restarting Neovim)

vim.opt.signcolumn = "no"          -- Don't show the sign column (used for diagnostics, git, etc.)
vim.opt.isfname:append("@-@")      -- Allow "@" in file names

vim.opt.updatetime = 50            -- Time (in ms) of no keypress before triggering CursorHold/autocommands

-- TODO Use a status bar plugin
-- Get the absolute path of the current file
local file_path = vim.fn.expand('%:p')

-- Get the home directory
local home_dir = vim.fn.expand('$HOME')

-- Compute the relative path by removing the home directory portion
local relative_path = file_path:sub(#home_dir + 1)

-- Set the statusline to show the relative path on the left and the absolute path on the right
vim.opt.statusline = "%{mode()} %f %= " .. file_path .. " %m %l,%c %p%%"

vim.cmd.colorscheme('tokyonight')
