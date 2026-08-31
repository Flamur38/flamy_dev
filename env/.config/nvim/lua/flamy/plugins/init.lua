-- This file does two things:
-- 1. Bootstraps lazy.nvim if it isn't installed yet
-- 2. Hands lazy.nvim the list of plugin specs to manage

-- ─── Bootstrap ────────────────────────────────────────────────────────────────

-- This is where lazy.nvim will be installed on disk
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if lazy.nvim is already installed
-- If not, clone it from GitHub right now before anything else runs
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",                        -- Partial clone, faster download
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",                           -- Always use the stable release
        lazypath,
    })
end

-- Prepend lazy.nvim to the runtime path so Neovim can find it
vim.opt.rtp:prepend(lazypath)

-- ─── Plugin Setup ─────────────────────────────────────────────────────────────

require("lazy").setup({
    { import = "flamy.plugins.colors" },
    { import = "flamy.plugins.treesitter" },
    { import = "flamy.plugins.telescope" },
    { import = "flamy.plugins.harpoon" },
    { import = "flamy.plugins.lsp" },
    { import = "flamy.plugins.cmp" },       -- autocompletion
    -- { import = 'flamy.plugins.render-markdown' }, -- Markdown
})
-- Each { import = "..." } tells lazy.nvim to load that file as a plugin spec
