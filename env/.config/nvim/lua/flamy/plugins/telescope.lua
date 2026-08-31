-- Telescope is a fuzzy finder that lets you search through files,
-- grep across your project, browse buffers, and much more
-- It has a floating window UI with a preview pane on the right

return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",

        -- plenary.nvim is a Lua utility library that Telescope depends on
        -- it provides async, file path helpers, and more
        dependencies = {
            "nvim-lua/plenary.nvim",

            -- Native FZF sorter compiled in C — much faster fuzzy matching
            -- especially noticeable in large codebases or repos
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",   -- Compiles the C extension on install
            },
        },

        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")
            local actions = require("telescope.actions")

            telescope.setup({
                defaults = {
                    -- How results are sorted — fzf gives the best fuzzy matching
                    sorting_strategy = "ascending",

                    -- Where the results list appears relative to the prompt
                    layout_config = {
                        prompt_position = "top",
                    },

                    -- Disable treesitter-based syntax highlighting in the preview pane
                    -- The new nvim-treesitter removed ft_to_lang which Telescope still calls
                    preview = {
                        treesitter = false,
                    },

                    -- Keymaps inside the Telescope window
                    mappings = {
                        i = {
                            -- Close telescope with Escape in insert mode
                            -- instead of switching to normal mode first
                            ["<ESC>"] = actions.close,

                            -- Move through results with Ctrl-j/k
                            -- so you don't have to leave insert mode
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                        },
                    },
                },
            })

            -- Load the fzf native extension after setup
            telescope.load_extension("fzf")

            -- ─── Keymaps ──────────────────────────────────────────────────────

            -- Find files by name in the current project
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })

            -- Live grep: search for a string across all files in the project
            -- requires ripgrep (rg) to be installed on your system
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })

            -- Browse currently open buffers
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })

            -- Search Neovim help tags
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })

            -- Search through old/recently opened files
            vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })

            -- Grep for the word currently under the cursor
            vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Grep word under cursor" })


            -- ─── Keymaps ──────────────────────────────────────────────────────
            -- vim.keymap.set("n", "<leader>fn", function()
            --     require("telescope.builtin").find_files({ cwd = "~/.dev-personal/notes" })   -- find note by name
            -- end)
            --
            -- vim.keymap.set("n", "<leader>gn", function()
            --     require("telescope.builtin").live_grep({ cwd = "~/.dev-personal/notes" })    -- grep inside all notes
            -- end)
            --
            -- vim.keymap.set("n", "<leader>nn", function()
            --     local name = vim.fn.input("Note name: ")
            --     if name ~= "" then
            --         vim.cmd("edit ~/.dev-personal/notes/" .. name .. ".md")                  -- .md added automatically
            --     end
            -- end)

        end,
    },
}
