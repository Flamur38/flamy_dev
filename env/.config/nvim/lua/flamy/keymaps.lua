-- Set Space as the leader key
-- This must be set before lazy.nvim loads so plugins pick it up correctly
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Helper function to reduce repetition
-- mode: the vim mode ("n", "v", "i", etc.)
-- lhs: the key combination you press
-- rhs: what it executes
-- desc: description shown in which-key or :map output
local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end


map('n', '<leader>pv', vim.cmd.Ex)

-- ─── General ──────────────────────────────────────────────────────────────────

-- Leave insert mode with jk instead of reaching for Escape
map('i', '<C-c>', '<ESC>', 'Exit insert mode')

-- Clear search highlight without having to search for something else
map('n', '<ESC>', ':nohl<CR>', 'Clear search highlights')

-- Delete a character without yanking it into the register
map('n', 'x', '"_x', 'Delete char without yanking')

-- ─── Line Movement (Visual Mode) ──────────────────────────────────────────────

-- Move selected lines up or down and re-indent automatically
map('v', 'J', ":m '>+1<CR>gv=gv", 'Move selection down')
map('v', 'K', ":m '<-2<CR>gv=gv", 'Move selection up')

-- ─── Better Navigation ────────────────────────────────────────────────────────

-- Keep cursor centered when jumping half pages
map('n', '<C-d>', '<C-d>zz', 'Scroll down and center')
map('n', '<C-u>', '<C-u>zz', 'Scroll up and center')

-- Keep cursor centered when cycling through search results
map('n', 'n', 'nzzzv', 'Next result centered')
map('n', 'N', 'Nzzzv', 'Prev result centered')

-- ─── Paste Without Losing Register ────────────────────────────────────────────

-- When you paste over a visual selection, don't overwrite your clipboard
-- with what you just deleted
map('v', 'p', '"_dP', 'Paste without yanking selection')


-- CUSTOM KEYMAPS  ────────────────────────────────────────────
vim.keymap.set('n', '<leader>fn', function()
    require('telescope.builtin').find_files({ cwd = '~/.dev-personal/notes' })   -- find note by name
end)

vim.keymap.set('n', '<leader>gn', function()
    require('telescope.builtin').live_grep({ cwd = '~/.dev-personal/notes' })    -- grep inside all notes
end)

vim.keymap.set('n', '<leader>nn', function()
    local name = vim.fn.input('Note name: ')
    if name == '' then
        return                                                       -- cancelled, do nothing
    end
    if not name:match('%.%w+$') then                                 -- no extension given?
        name = name .. '.md'                                         -- default to markdown
    end
    local path = vim.fn.expand('~/.dev-personal/notes/' .. name)     -- full absolute path
    vim.fn.mkdir(vim.fn.fnamemodify(path, ':h'), 'p')                -- create parent dirs if needed
    vim.cmd('edit ' .. path)                                         -- open/create the note
end)
