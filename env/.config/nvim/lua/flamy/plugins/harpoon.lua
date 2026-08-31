-- Harpoon v2 lets you bookmark files and jump between them instantly
-- Think of it as a persistent, per-project quick-access list
-- No more :b <tab> hunting or telescope just to switch between your 3 main files

return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",   -- Must explicitly use the harpoon2 branch

        -- plenary.nvim is required by harpoon for path and async utilities
        dependencies = { "nvim-lua/plenary.nvim" },

        config = function()
            local harpoon = require("harpoon")

            -- setup() must be called before any harpoon keymaps
            harpoon:setup({
                -- Global settings for all lists
                settings = {
                    -- When navigating to a harpooned file, move it to
                    -- the front of the list automatically
                    save_on_toggle = true,

                    -- Sync harpoon list to disk whenever it changes
                    sync_on_ui_close = true,
                },
            })

            -- ─── Keymaps ──────────────────────────────────────────────────────

            -- Add the current file to the harpoon list
            vim.keymap.set("n", "<leader>a", function()
                harpoon:list():add()
            end, { desc = "Harpoon: add file" })

            -- Toggle the harpoon quick menu (shows your bookmarked files)
            -- From the menu you can reorder, delete, or navigate entries
            vim.keymap.set("n", "<C-e>", function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end, { desc = "Harpoon: toggle menu" })

            -- Jump directly to harpooned file by index
            -- These are your 4 fast-access slots
            vim.keymap.set("n", "<C-j>", function()
                harpoon:list():select(1)
            end, { desc = "Harpoon: file 1" })

            vim.keymap.set("n", "<C-k>", function()
                harpoon:list():select(2)
            end, { desc = "Harpoon: file 2" })

            vim.keymap.set("n", "<C-l>", function()
                harpoon:list():select(3)
            end, { desc = "Harpoon: file 3" })

            vim.keymap.set("n", "<leader>4", function()
                harpoon:list():select(4)
            end, { desc = "Harpoon: file 4" })

            -- Navigate through the list sequentially
            -- Useful when you have more than 4 files harpooned
            vim.keymap.set("n", "<leader>hp", function()
                harpoon:list():prev()
            end, { desc = "Harpoon: prev file" })

            vim.keymap.set("n", "<leader>hn", function()
                harpoon:list():next()
            end, { desc = "Harpoon: next file" })
        end,
    },
}
