-- change this line to switch themes:
--   "tokyonight", "tokyonight-storm", "tokyonight-night",
--   "tokyonight-moon", "tokyonight-day", "juliana", "rose-pine"
local DEFAULT = "juliana"

return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,                       -- load before other start plugins
        opts = {
            style = "night",                   -- storm | night | moon | day
            transparent = false,
            terminal_colors = true,
            styles = {
                comments = { italic = true },
                keywords = { italic = false }, -- jetbrains mono has no true cursive
                functions = {},
                variables = {},
                sidebars = "dark",             -- dark | transparent | normal
                floats = "dark",
            },
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme(DEFAULT)       -- runs after the plugin is loaded
        end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,                           -- kept as a fallback option
        opts = {
            variant = "main",                  -- main | moon | dawn
            styles = {
                bold = true,
                italic = false,
                transparency = false,
            },
        },
        config = function(_, opts)
            require("rose-pine").setup(opts)
        end,
    },
    {
        "kaiuri/nvim-juliana",
        lazy = true,
        opts = {
            colors = {
                bg2 = "#000000",   -- Normal background -> black
            },
        },
        config = true,
    },
}
