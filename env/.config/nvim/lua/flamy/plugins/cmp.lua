-- nvim-cmp is the completion engine
-- event = 'InsertEnter' means it only loads when you enter insert mode
-- keeping startup time fast

return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",

        dependencies = {
            -- Snippet engine
            "L3MON4D3/LuaSnip",

            -- Connects LuaSnip to cmp
            "saadparwaiz1/cmp_luasnip",

            -- LSP completions
            "hrsh7th/cmp-nvim-lsp",

            -- A large collection of real-world snippets for Python, Go, Bash, etc.
            -- loaded lazily so it doesn't slow down startup
            "rafamadriz/friendly-snippets",

            -- Words from current buffer
            "hrsh7th/cmp-buffer",

            -- File system path completions
            "hrsh7th/cmp-path",

            -- Completions in the : command line
            "hrsh7th/cmp-cmdline",
        },

        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            -- Load friendly-snippets into LuaSnip
            -- lazy_load means it only loads snippets for the filetype you're in
            require("luasnip.loaders.from_vscode").lazy_load()
            luasnip.config.setup({})

            cmp.setup({

                -- Tell cmp to use LuaSnip as the snippet engine
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },

                -- Prevent cmp from auto-inserting the first item
                -- you stay in control of what gets confirmed
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },

                -- ─── Keymaps ──────────────────────────────────────────────────

                mapping = cmp.mapping.preset.insert({

                    -- Move down/up through completion items
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    ["<C-k>"] = cmp.mapping.select_prev_item(),

                    -- Manually trigger the completion menu
                    ["<C-Space>"] = cmp.mapping.complete(),

                    -- Scroll the documentation popup up/down
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),

                    -- Close the completion menu without confirming
                    ["<C-e>"] = cmp.mapping.abort(),

                    -- Confirm with Enter — select = false means you must
                    -- explicitly highlight an item before confirming
                    ["<C-y>"] = cmp.mapping.confirm({ select = false }),

                    -- Confirm with C-y using Replace behavior
                    -- replaces the entire word under cursor instead of appending
                    -- ["<C-y>"] = cmp.mapping.confirm({
                    --     behavior = cmp.ConfirmBehavior.Replace,
                    --     select = true,
                    -- }),
                }),

                -- ─── Sources ──────────────────────────────────────────────────
                -- Order determines priority in the menu
                -- second group is fallback if first group returns nothing

                sources = cmp.config.sources({
                    { name = "nvim_lsp" },   -- LSP completions (highest priority)
                    { name = "luasnip" },    -- Snippet completions
                    { name = "path" },       -- File path completions
                }, {
                    { name = "buffer" },     -- Words from current buffer (fallback)
                }),

                -- ─── Appearance ───────────────────────────────────────────────

                -- Bordered windows for both the completion list and docs popup
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },

                -- Show source label next to each item so you know where it came from
                formatting = {
                    format = function(entry, vim_item)
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip  = "[Snippet]",
                            buffer   = "[Buffer]",
                            path     = "[Path]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },

                -- Show a faded inline preview of the completion as you type
                experimental = {
                    ghost_text = true,
                },
            })

        end,
    },
}
