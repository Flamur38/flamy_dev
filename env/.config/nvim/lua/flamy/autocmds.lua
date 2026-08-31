-- Autocmds are commands that run automatically in response to events
-- TextYankPost fires every time you yank (copy) text

-- Briefly highlight the yanked region so you can see exactly what was copied
-- Try it with yap (yank a paragraph) or yiw (yank inner word)
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight yanked text",
    group = vim.api.nvim_create_augroup("flamy-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Neovim settings just for .md
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt_local.wrap = true            -- wrap long prose lines
        vim.opt_local.linebreak = true       -- ...but only at word boundaries
        vim.opt_local.conceallevel = 2       -- hide ** and ` markers, show styled text
        vim.opt_local.spell = false          -- flip to true if you want spellcheck
    end,
})
