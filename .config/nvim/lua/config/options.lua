local undodir = vim.fn.expand("~/.vim/undodir")
if
	vim.fn.isdirectory(undodir) == 0 -- create undodir if nonexistent
then
	vim.fn.mkdir(undodir, "p")
end

local options = {
    -- General 
    termguicolors = true,
    cursorline = true, --highlight line
    wrap = true, --toggle bound to leader W
    showmatch = true,
    cmdheight = 1,
    showmode = false,

    -- Line number
	number = true,
	relativenumber = true, --toggle bound to leader nn
	numberwidth = 4,

    --Indentation 
	tabstop = 2, --visual width of tab
    shiftwidth = 2, -- indent width
    softtabstop = 2, -- soft tab stop not tabs on tab/backspace
    expandtab = true, -- use spaces instead of tabs
	autoindent = true, -- copy indent from current line

    -- Search
    ignorecase = true, --ignore case while searching
	smartcase = true, --but do not ignore if caps are used
    hlsearch = true, -- highlight search matches
    incsearch = true, -- show matches as you type

    -- Scroll
    ttyfast = true, --faster scrolling
	smoothscroll = false,
    scrolloff = 10, -- keep 10 lines above/below cursor
    sidescrolloff = 10, -- keep 10 lines to left/right of cursor

    -- Column
    signcolumn = "yes", -- always show a sign column
    colorcolumn = "100", -- show a column at 100 position chars

    -- Undo and backup
	laststatus = 3,
	ruler = false, --disable extra numbering
	mouse = "a", --enable mouse
	clipboard = "unnamedplus", --system clipboard integration
	history = 100, --command line history
    backup = false, -- do not create a backup file
    writebackup = false, -- do not write to a backup file
    swapfile = false, -- do not create a swapfile
    undofile = true, -- do create an undo file
    undodir = undodir, -- set the undo directory
    updatetime = 300, -- faster completion
    timeoutlen = 500, -- timeout duration
    ttimeoutlen = 50, -- key code timeout
    autoread = true, -- auto-reload changes if outside of neovim
    autowrite = false, -- do not auto-save
	title = true, --automatic window titlebar

	conceallevel = 2, --markdown conceal
	concealcursor = "nc",

    errorbells = false, -- no error sounds
    backspace = "indent,eol,start", -- better backspace behaviour
    selection = "inclusive",
    modifiable = true, -- allow buffer modifications

    -- Split
    splitbelow = true, -- horizontal splits go below
    splitright = true, -- vertical splits go right

    -- Fold
    foldmethod = "expr", -- use expression for folding
    foldexpr = "v:lua.vim.treesitter.foldexpr()", -- use treesitter for folding
    foldlevel = 99, -- start with all folds open

    -- Optimization
    wildmenu = true, -- tab completion
    wildmode = "longest:full,full", -- complete longest common match, full completion list, cycle through with Tab,
    redrawtime = 10000, -- increase neovim redraw tolerance
    maxmempattern = 20000, -- increase max memory
}

vim.opt.iskeyword:append("-") -- include - in words
vim.opt.path:append("**") -- include subdirs
vim.opt.diffopt:append("linematch:60") -- improve diff display

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.diagnostic.config({
	signs = false,
})