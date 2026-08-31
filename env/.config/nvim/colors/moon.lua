-- moon_purple.lua

vim.cmd("hi clear")

if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end

vim.o.termguicolors = true
vim.g.colors_name = "moon_purple"

local c = {
    bg       = "#1B1B33",
    fg       = "#F2F1F7",

    line     = "#22223D",
    float    = "#20203A",
    visual   = "#3B3154",

    gutter   = "#5A5870",
    comment  = "#7E7B92",
    border   = "#45435E",

    magenta  = "#D16DFF",
    cyan     = "#5DE2E7",
    orange   = "#FFB86C",
    red      = "#FF5577",
}
local function hi(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

--------------------------------------------------
-- UI
--------------------------------------------------

hi("Normal",          { fg = c.fg, bg = c.bg })
hi("NormalFloat",     { fg = c.fg, bg = c.float })

hi("CursorLine",      { bg = c.line })
hi("CursorColumn",    { bg = c.line })

hi("ColorColumn",     { bg = c.line })

hi("Visual",          { bg = c.visual })

hi("LineNr",          { fg = c.gutter })
hi("CursorLineNr",    { fg = c.magenta })

hi("SignColumn",      { bg = c.bg })

-- hi("StatusLine",      { fg = c.fg, bg = c.float })
-- hi("StatusLineNC",    { fg = c.comment, bg = c.float })

hi("StatusLine",      { fg = c.bg, bold = true, bg = c.comment })
hi("StatusLineNC",    { fg = c.comment, bg = c.float })

hi("WinSeparator",    { fg = c.border })
hi("FloatBorder",     { fg = c.border })

hi("Pmenu",           { fg = c.fg, bg = c.float })
hi("PmenuSel",        { fg = c.bg, bg = c.magenta })

hi("Search",          { fg = c.bg, bg = c.orange })
hi("IncSearch",       { fg = c.bg, bg = c.magenta })

hi("MatchParen",      { fg = c.cyan, bold = true })

hi("EndOfBuffer",     { fg = c.bg })

--------------------------------------------------
-- Syntax
--------------------------------------------------

hi("Comment",         { fg = c.comment, italic = true })

-- Keywords
hi("Keyword",         { fg = c.magenta })
hi("Statement",       { fg = c.magenta })
hi("Conditional",     { fg = c.magenta })
hi("Repeat",          { fg = c.magenta })
hi("Exception",       { fg = c.magenta })

-- Functions
hi("Function",        { fg = c.cyan })

-- Everything else stays white
hi("Identifier",      { fg = c.fg })
hi("Type",            { fg = c.fg })
hi("Operator",        { fg = c.fg })
hi("Delimiter",       { fg = c.fg })
hi("PreProc",         { fg = c.fg })
hi("Special",         { fg = c.fg })

-- Literal values
hi("String",          { fg = c.orange })
hi("Character",       { fg = c.orange })
hi("Number",          { fg = c.orange })
hi("Float",           { fg = c.orange })
hi("Boolean",         { fg = c.orange })
hi("Constant",        { fg = c.orange })

--------------------------------------------------
-- Treesitter
--------------------------------------------------

hi("@keyword",         { fg = c.magenta })
hi("@keyword.return",  { fg = c.magenta })
hi("@keyword.function",{ fg = c.magenta })

hi("@function",        { fg = c.cyan })
hi("@function.call",   { fg = c.cyan })

hi("@string",          { fg = c.orange })
hi("@number",          { fg = c.orange })
hi("@boolean",         { fg = c.orange })
hi("@constant",        { fg = c.orange })

hi("@variable",        { fg = c.fg })
hi("@type",            { fg = c.fg })
hi("@operator",        { fg = c.fg })
hi("@punctuation",     { fg = c.fg })

hi("@comment",         { fg = c.comment, italic = true })

--------------------------------------------------
-- Diagnostics
--------------------------------------------------

hi("DiagnosticError", { fg = c.red })
hi("DiagnosticWarn",  { fg = c.orange })
hi("DiagnosticInfo",  { fg = c.cyan })
hi("DiagnosticHint",  { fg = c.comment })
