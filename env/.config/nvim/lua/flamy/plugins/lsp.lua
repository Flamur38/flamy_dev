-- Neovim 0.11+ has a built-in LSP config system via vim.lsp.config
-- mason still handles installing the servers
-- mason-lspconfig bridges the two

return {

    -- ─── Mason ────────────────────────────────────────────────────────────────
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    -- ─── Mason LSPConfig ──────────────────────────────────────────────────────
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "pyright",
                    "lua_ls",
                    "bashls",
                    "gopls",
                },
                automatic_installation = true,
            })
        end,
    },

    -- ─── LSP ──────────────────────────────────────────────────────────────────
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",        -- needed here so capabilities is available
        },
        config = function()

            -- Tell LSP servers that cmp supports enhanced completion
            -- This unlocks richer suggestions (snippets, documentation, etc.)
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- on_attach runs every time an LSP attaches to a buffer
            local on_attach = function(client, bufnr)

                -- Keep Treesitter in control of highlighting
                client.server_capabilities.semanticTokensProvider = nil

                local map = function(lhs, rhs, desc)
                    vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
                end

                map("gd",          vim.lsp.buf.definition,     "Go to definition")
                map("gD",          vim.lsp.buf.declaration,    "Go to declaration")
                map("gi",          vim.lsp.buf.implementation, "Go to implementation")
                map("gr",          vim.lsp.buf.references,     "List references")
                map("K",           vim.lsp.buf.hover,          "Hover docs")
                map("<leader>rn",  vim.lsp.buf.rename,         "Rename symbol")
                map("<leader>ca",  vim.lsp.buf.code_action,    "Code action")
                map("[d",          vim.diagnostic.goto_prev,   "Previous diagnostic")
                map("]d",          vim.diagnostic.goto_next,   "Next diagnostic")
                map("<leader>d",   vim.diagnostic.open_float,  "Show diagnostic float")
            end

            -- Diagnostic display
            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = false,
            })

            -- ─── Server Configs ───────────────────────────────────────────────

            vim.lsp.config("pyright", {
                on_attach = on_attach,
                capabilities = capabilities,
            })

            vim.lsp.config("bashls", {
                on_attach = on_attach,
                capabilities = capabilities,
            })

            vim.lsp.config("gopls", {
                on_attach = on_attach,
                capabilities = capabilities,
            })

            vim.lsp.config("lua_ls", {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                    },
                },
            })

            -- Enable all servers
            vim.lsp.enable({ "pyright", "bashls", "gopls", "lua_ls" })
        end,
    },
}
