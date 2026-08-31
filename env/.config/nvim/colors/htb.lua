-- htb.lua
-- Neovim colorscheme built on the HackTheBox palette
-- (github.com/audibleblink/hackthebox.vim)
--
-- Design notes:
--   - Background/foreground pulled straight from HTB (#1a2332 / #a4b1cd).
--     Everything else (line, float, selection, border) is interpolated
--     between those two so the UI reads as one coherent navy scale
--     rather than borrowing an unrelated grey.
--   - Semantic roles: purple for control-flow keywords, cyan for
--     functions, bold blue for builtins/types, yellow for strings,
--     green for numbers/constants (deliberately kept separate from
--     strings so literals don't blur together), red reserved almost
--     exclusively for errors/booleans so it stays alarming.
--   - Diagnostics and git-diff colors map directly onto HTB's own
--     semantics: green = good/add, red = bad/delete, yellow = warn/change.

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "htb"

local c = {
  -- core
  bg        = "#101927",
  bg_dim    = "#141b26", -- darker than bg, for floats/popups
  bg_light  = "#212d42", -- cursorline / current-line highlight
  selection = "#313f55", -- visual selection / pmenu sel
  border    = "#3f8193", -- window borders, subtle but visible
  fg        = "#a4b1cd",
  fg_bright = "#ffffff",
  comment   = "#5b6a86", -- muted step between bg_light and fg

  -- accents (HTB core + bright variants)
  red        = "#ff3e3e",
  red_bright = "#ff8484",
  green      = "#c5f467",
  green_dim  = "#c5f467",
  yellow     = "#ffcc5c",
  yellow_dim = "#ffcc5c",
  blue       = "#004cff",
  blue_bright= "#5cb2ff",
  purple     = "#9f00ff",
  purple_dim = "#c16cfa",
  cyan       = "#2ee7b6",
  cyan_dim   = "#5cecc6",
}

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

--------------------------------------------------
-- Editor UI
--------------------------------------------------
hi("Normal",       { fg = c.fg, bg = c.bg })
hi("NormalFloat",  { fg = c.fg, bg = c.bg_dim })
hi("FloatBorder",  { fg = c.border, bg = c.bg_dim })
hi("FloatTitle",   { fg = c.cyan, bg = c.bg_dim, bold = true })

hi("CursorLine",   { bg = c.bg_light })
hi("CursorColumn", { bg = c.bg_light })
hi("ColorColumn",  { bg = c.bg_light })
hi("Visual",       { bg = c.selection })
hi("VisualNOS",    { bg = c.selection })

hi("LineNr",       { fg = c.comment })
hi("CursorLineNr", { fg = c.purple, bold = true })
hi("SignColumn",   { bg = c.bg })
hi("FoldColumn",   { fg = c.comment, bg = c.bg })
hi("Folded",       { fg = c.comment, bg = c.bg_light, italic = true })

hi("StatusLine",   { fg = c.fg, bg = c.bg_dim })
hi("StatusLineNC", { fg = c.comment, bg = c.bg_dim })
hi("WinSeparator", { fg = c.border })
hi("VertSplit",    { fg = c.border })
hi("TabLine",      { fg = c.comment, bg = c.bg_dim })
hi("TabLineSel",   { fg = c.fg_bright, bg = c.bg_light, bold = true })
hi("TabLineFill",  { bg = c.bg_dim })

hi("Pmenu",        { fg = c.fg, bg = c.bg_dim })
hi("PmenuSel",     { fg = c.bg, bg = c.cyan, bold = true })
hi("PmenuSbar",    { bg = c.bg_light })
hi("PmenuThumb",   { bg = c.selection })

hi("Search",       { fg = c.bg, bg = c.yellow })
hi("IncSearch",    { fg = c.bg, bg = c.purple, bold = true })
hi("CurSearch",    { fg = c.bg, bg = c.cyan, bold = true })
hi("MatchParen",   { fg = c.purple, bold = true, underline = true })

hi("NonText",      { fg = c.comment })
hi("Whitespace",   { fg = c.bg_light })
hi("EndOfBuffer",  { fg = c.bg })
hi("Directory",    { fg = c.blue_bright })
hi("Title",        { fg = c.cyan, bold = true })
hi("ModeMsg",       { fg = c.green })
hi("MoreMsg",       { fg = c.cyan })
hi("Question",      { fg = c.yellow })
hi("WarningMsg",    { fg = c.yellow, bold = true })
hi("ErrorMsg",       { fg = c.red, bold = true })

--------------------------------------------------
-- Syntax (legacy / non-treesitter fallback)
--------------------------------------------------
hi("Comment",      { fg = c.comment, italic = true })

hi("Keyword",      { fg = c.purple })
hi("Statement",    { fg = c.purple })
hi("Conditional",  { fg = c.purple })
hi("Repeat",       { fg = c.purple })
hi("Exception",    { fg = c.purple })
hi("Label",        { fg = c.purple })

hi("Function",     { fg = c.cyan })
hi("Identifier",   { fg = c.fg })
hi("Type",         { fg = c.blue_bright, bold = true })
hi("StorageClass",  { fg = c.blue_bright })
hi("Structure",     { fg = c.blue_bright })

hi("Operator",     { fg = c.fg })
hi("Delimiter",    { fg = c.comment })
hi("PreProc",      { fg = c.purple_dim })
hi("Special",      { fg = c.yellow_dim })
hi("SpecialChar",  { fg = c.yellow_dim })

hi("String",       { fg = c.yellow })
hi("Character",    { fg = c.yellow })
hi("Number",       { fg = c.green })
hi("Float",        { fg = c.green })
hi("Boolean",      { fg = c.red_bright, bold = true })
hi("Constant",     { fg = c.green })

hi("Underlined",   { underline = true })
hi("Todo",          { fg = c.bg, bg = c.yellow, bold = true })
hi("Error",          { fg = c.red, bold = true })

--------------------------------------------------
-- Treesitter
--------------------------------------------------
hi("@keyword",           { fg = c.purple })
hi("@keyword.return",    { fg = c.purple, italic = true })
hi("@keyword.function",  { fg = c.purple })
hi("@keyword.operator",  { fg = c.purple })
hi("@conditional",       { fg = c.purple })
hi("@repeat",            { fg = c.purple })

hi("@function",           { fg = c.cyan })
hi("@function.call",     { fg = c.cyan })
hi("@function.builtin",  { fg = c.blue_bright, bold = true })
hi("@method",             { fg = c.cyan })
hi("@method.call",       { fg = c.cyan })
hi("@constructor",       { fg = c.blue_bright })

hi("@parameter",         { fg = c.yellow_dim, italic = true })
hi("@variable",          { fg = c.fg })
hi("@variable.builtin",  { fg = c.blue_bright, italic = true })
hi("@field",              { fg = c.fg_bright })
hi("@property",           { fg = c.fg_bright })

hi("@type",               { fg = c.blue_bright, bold = true })
hi("@type.builtin",      { fg = c.blue_bright, bold = true, italic = true })

hi("@string",             { fg = c.yellow })
hi("@string.escape",     { fg = c.cyan_dim, bold = true })
hi("@number",             { fg = c.green })
hi("@boolean",            { fg = c.red_bright, bold = true })
hi("@constant",           { fg = c.green })
hi("@constant.builtin",  { fg = c.green_dim, bold = true })

hi("@operator",           { fg = c.fg })
hi("@punctuation",       { fg = c.comment })
hi("@punctuation.bracket",{ fg = c.comment })
hi("@comment",             { fg = c.comment, italic = true })
hi("@tag",                 { fg = c.purple })
hi("@tag.attribute",     { fg = c.yellow_dim })

--------------------------------------------------
-- LSP / Diagnostics
--------------------------------------------------
hi("DiagnosticError",           { fg = c.red })
hi("DiagnosticWarn",             { fg = c.yellow })
hi("DiagnosticInfo",             { fg = c.cyan })
hi("DiagnosticHint",             { fg = c.comment })
hi("DiagnosticUnderlineError",  { undercurl = true, sp = c.red })
hi("DiagnosticUnderlineWarn",   { undercurl = true, sp = c.yellow })
hi("DiagnosticUnderlineInfo",   { undercurl = true, sp = c.cyan })
hi("DiagnosticUnderlineHint",   { undercurl = true, sp = c.comment })
hi("LspReferenceText",           { bg = c.selection })
hi("LspReferenceRead",           { bg = c.selection })
hi("LspReferenceWrite",          { bg = c.selection, underline = true })

--------------------------------------------------
-- Git / diff (mirrors HTB's own red=bad, green=good semantics)
--------------------------------------------------
hi("DiffAdd",      { fg = c.green, bg = c.bg_light })
hi("DiffChange",   { fg = c.yellow, bg = c.bg_light })
hi("DiffDelete",   { fg = c.red, bg = c.bg_light })
hi("DiffText",     { fg = c.bg, bg = c.yellow })

hi("GitSignsAdd",     { fg = c.green })
hi("GitSignsChange",  { fg = c.yellow })
hi("GitSignsDelete",  { fg = c.red })

--------------------------------------------------
-- Telescope
--------------------------------------------------
hi("TelescopeBorder",         { fg = c.border, bg = c.bg_dim })
hi("TelescopeNormal",         { fg = c.fg, bg = c.bg_dim })
hi("TelescopeSelection",     { fg = c.fg_bright, bg = c.selection, bold = true })
hi("TelescopeMatching",      { fg = c.cyan, bold = true })
hi("TelescopePromptPrefix",  { fg = c.purple })
hi("TelescopeTitle",          { fg = c.cyan, bold = true })

--------------------------------------------------
-- nvim-cmp
--------------------------------------------------
hi("CmpItemAbbrMatch",         { fg = c.cyan, bold = true })
hi("CmpItemAbbrMatchFuzzy",   { fg = c.cyan_dim, bold = true })
hi("CmpItemKindFunction",     { fg = c.cyan })
hi("CmpItemKindMethod",        { fg = c.cyan })
hi("CmpItemKindVariable",     { fg = c.fg })
hi("CmpItemKindKeyword",      { fg = c.purple })
hi("CmpItemKindClass",        { fg = c.blue_bright })
hi("CmpItemKindText",          { fg = c.yellow })
