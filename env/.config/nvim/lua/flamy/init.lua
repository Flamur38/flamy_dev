-- This is the main entry point for the flamy module
-- It loads each piece of the config in the correct order
-- Order matters: options and keymaps must load before plugins
-- so that leader key and settings are in place when plugins initialize

require("flamy.options")   -- vim options (line numbers, tabs, clipboard, etc.)
require("flamy.keymaps")   -- base keymaps and leader key
require("flamy.plugins")   -- lazy.nvim bootstrap + all plugin specs
require('flamy.autocmds')  -- autocommands
