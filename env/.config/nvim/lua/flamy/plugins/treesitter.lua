-- nvim-treesitter (main branch): parsers installed via install(),
-- highlighting started manually per-filetype via autocmd.
-- The old configs.setup({ highlight = ... }) API is master-branch only.
return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",                             -- Pin explicitly so updates don't surprise you
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install({     -- Replaces ensure_installed
                "lua",
                "python",
                "bash",
                "go",
                "json",
                "yaml",
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = {                          -- Filetypes (not extensions) to highlight
                    "lua",
                    "python",
                    "sh",                            -- bash parser maps to sh/bash filetypes
                    "bash",
                    "go",
                    "json",
                    "yaml",
                },
                callback = function(args)
                    vim.treesitter.start(args.buf)               -- Highlighting (your manual fix, automated)
                    vim.bo[args.buf].indentexpr =
                        "v:lua.require'nvim-treesitter'.indentexpr()"  -- Replaces indent = { enable = true }
                end,
            })
        end,
    },
}
