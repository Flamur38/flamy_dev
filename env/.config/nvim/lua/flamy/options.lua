local opt = vim.opt  -- vim.opt is the clean Lua API for setting Neovim options

-- ─── Line Numbers ─────────────────────────────────────────────────────────────
opt.relativenumber = true       -- Show relative line numbers (great for jump motions like 5j, 12k)
opt.number = true               -- Show absolute line number on the current line itself

-- ─── Tabs & Indentation ───────────────────────────────────────────────────────
opt.tabstop = 4                 -- A <Tab> character visually appears as 4 spaces
opt.shiftwidth = 4              -- >> and << indent/dedent by 4 spaces
opt.expandtab = true            -- Pressing <Tab> inserts spaces instead of a tab character
opt.smartindent = true          -- Auto-indent new lines based on the previous line's syntax
opt.softtabstop = 4             -- <Tab> in insert mode moves cursor by 4 spaces

-- ─── Line Wrapping ────────────────────────────────────────────────────────────
opt.wrap = false                -- Long lines don't wrap; scroll horizontally instead

-- ─── Search ───────────────────────────────────────────────────────────────────
opt.ignorecase = true           -- /foo matches Foo, FOO, foo
opt.smartcase = true            -- /Foo only matches Foo (capital overrides ignorecase)
opt.hlsearch = false            -- Don't keep matches highlighted after search is done
opt.incsearch = true            -- Show matches incrementally as you type

-- ─── Cursor Line ──────────────────────────────────────────────────────────────
opt.cursorline = false           -- Highlight the entire line the cursor is on

-- ─── Appearance ───────────────────────────────────────────────────────────────
opt.termguicolors = true        -- Enable 24-bit RGB colors (required for most colorschemes)
opt.background = "dark"         -- Tell colorschemes to use their dark variant
opt.signcolumn = "yes"          -- Always show the sign column (LSP errors, git signs, etc.)
opt.showmode = true             -- Show -- INSERT -- / -- VISUAL -- in the command line

-- ─── Backspace ────────────────────────────────────────────────────────────────
opt.backspace = "indent,eol,start" -- Backspace works over autoindent, line breaks, and insert start

-- ─── Clipboard ────────────────────────────────────────────────────────────────
opt.clipboard:append("unnamedplus") -- Yank/paste uses the system clipboard (works with xclip/wl-copy)

-- ─── Keywords ─────────────────────────────────────────────────────────────────
opt.iskeyword:append("-")       -- Treat foo-bar as one word for motions like w, b, ciw

-- ─── Mouse ────────────────────────────────────────────────────────────────────
opt.mouse = ""                  -- Disable mouse entirely inside Neovim

-- ─── Folding ──────────────────────────────────────────────────────────────────
opt.foldlevel = 20              -- Start with most folds open (high number = more open)
opt.foldmethod = "expr"         -- Use a custom expression to decide fold boundaries
opt.foldexpr = "nvim_treesitter#foldexpr()" -- Let Treesitter define the fold structure

-- ─── Scrolling ────────────────────────────────────────────────────────────────
opt.scrolloff = 8               -- Always keep 8 lines visible above and below the cursor

-- ─── Cursor Shape ─────────────────────────────────────────────────────────────
opt.guicursor = ""              -- Force block cursor in all modes (no beam in insert mode)
