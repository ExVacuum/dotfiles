call plug#begin(stdpath('data') . '/plugged')

    " Official nvim LSP integration
    Plug 'neovim/nvim-lspconfig'
    
    " COQ Completion
    Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
    Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
    Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
    
    " ARM Syntax
    Plug 'ARM9/arm-syntax-vim'
    
    " Limelight
    Plug 'junegunn/limelight.vim'
    
    " Markdown Live Preview
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
    
    " Lua Status Line
    Plug 'nvim-lualine/lualine.nvim'
    
    " Lua Tab Line
    Plug 'seblj/nvim-tabline'
    
    " Lua Tree Viewer
    Plug 'kyazdani42/nvim-tree.lua'
    
    " Icons for the UI
    Plug 'kyazdani42/nvim-web-devicons'

    " Autosave
    Plug 'Pocco81/AutoSave.nvim'

    " Discord Rich Presence
    Plug 'andweeb/presence.nvim'

    " GDB
    Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }

    " Alpha Greeter
    Plug 'goolord/alpha-nvim'

    " Suda (R/W with sudo)
    Plug 'lambdalisue/suda.vim'

    " Plenary (Searching)
    Plug 'nvim-lua/plenary.nvim'

    " Todo Comments
    Plug 'folke/todo-comments.nvim'

    " Prettier Warnings and Errors
    Plug 'folke/trouble.nvim'

    " fzf
    Plug 'nvim-telescope/telescope.nvim'

    " NightFox Theme
    Plug 'EdenEast/nightfox.nvim'

    " Remote Work
    Plug 'chipsenkbeil/distant.nvim'

    " Colorize Color Codes
    Plug 'norcalli/nvim-colorizer.lua'
    
    " Markdown Internal Links
    Plug 'jakewvincent/mkdnflow.nvim'

    " In-editor Markdown Preview
    Plug 'ellisonleao/glow.nvim'
call plug#end()                        

""""""""""""""""""""""""""""""""""""""""""""""""
"
" (N)VIM SETTINGS
"
""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = "," " Leader key

set number " Enable Line Numbers

set mouse=a " Enable Mouse Control

set clipboard+=unnamedplus " Enable Yanking to/Pasting from Clipboard

syntax enable " Enable Syntax highlight

filetype plugin indent on " Enable Filetype Detection

set tabstop=4 " When indenting with '>', use 4 spaces width

set shiftwidth=4 " On pressing tab, insert 4 spaces

set expandtab " Replace tabs with spaces 

set autowriteall " Autosave on buffer switch

" Keybinds for switching tabs
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

""""""""""""""""""""""""""""""""""""""""""""""""
"
" NORD COLOR SCHEME
"
""""""""""""""""""""""""""""""""""""""""""""""""

colorscheme nordfox

""""""""""""""""""""""""""""""""""""""""""""""""
"
" ARM SYNTAX
"
""""""""""""""""""""""""""""""""""""""""""""""""

au BufNewFile,BufRead *.s,*.S set filetype=arm  " Enable arm file detection

""""""""""""""""""""""""""""""""""""""""""""""""
"
" COQ (AUTOCOMPLETE CLIENT + SNIPPETS)
"
""""""""""""""""""""""""""""""""""""""""""""""""

let g:coq_settings = { 'auto_start': 'shut-up' }    " Auto-start COQ

lua << EOF
local coq = require "coq"
EOF

""""""""""""""""""""""""""""""""""""""""""""""""
"
" NVIM LSPCONFIG (AUTOCOMPLETE LANGUAGES)
"
""""""""""""""""""""""""""""""""""""""""""""""""

lua << EOF
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require'lspconfig'
lspconfig.ccls.setup(coq.lsp_ensure_capabilities())  -- CCLS: C/C++
lspconfig.tsserver.setup(coq.lsp_ensure_capabilities()) -- TSSERVER: TypeScript
lspconfig.cssls.setup(coq.lsp_ensure_capabilities()) -- CSSLS: CSS
lspconfig.remark_ls.setup(coq.lsp_ensure_capabilities()) -- remark_ls: Markdown
lspconfig.bashls.setup(coq.lsp_ensure_capabilities()) -- bashls: Bash
lspconfig.pylsp.setup(coq.lsp_ensure_capabilities()) -- pylsp: Python
lspconfig.sumneko_lua.setup(coq.lsp_ensure_capabilities()) -- sumneko_lua: lua
lspconfig.rust_analyzer.setup(coq.lsp_ensure_capabilities({ -- rust_analyzer: rust
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
})) -- rust_analyzer: rust
EOF

""""""""""""""""""""""""""""""""""""""""""""""""
"
" LIMELIGHT (FOCUS MODE)
"
""""""""""""""""""""""""""""""""""""""""""""""""

let g:limelight_conceal_ctermfg = 'gray'    " Unfocused code sections will be grayed out

""""""""""""""""""""""""""""""""""""""""""""""""
"
" MARKDOWN LIVE PREVIEW
"
""""""""""""""""""""""""""""""""""""""""""""""""

let g:mkdp_auto_start = 0
let g:mkdp_page_title = '「${name}」'
let g:mkdp_filetypes = ['markdown']

let g:mkdp_refresh_slow = 0         " Refresh preview on cursor move

let g:mkdp_browser = 'qutebrowser'  " Open preview in qutebrowser

let g:mkdp_port = '8090'            " Run preview on local port 8090

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 1
    \ }

""""""""""""""""""""""""""""""""""""""""""""""""
"
" STATUSLINE
"
""""""""""""""""""""""""""""""""""""""""""""""""

lua << EOF
local function getWords()
  if vim.bo.filetype == "md" or vim.bo.filetype == "txt" or vim.bo.filetype == "markdown" then
    if vim.fn.wordcount().visual_words == 1 then
      return tostring(vim.fn.wordcount().visual_words) .. " word"
    elseif not (vim.fn.wordcount().visual_words == nil) then
      return tostring(vim.fn.wordcount().visual_words) .. " words"
    else
      return tostring(vim.fn.wordcount().words) .. " words"
    end
  else
    return ""
  end
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'nightfox',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {'NvimTree', 'vim-plug'},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {getWords, 'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
EOF

""""""""""""""""""""""""""""""""""""""""""""""""
"
" TABLINE
"
""""""""""""""""""""""""""""""""""""""""""""""""

lua << EOF
require('tabline').setup{
    no_name = '[No Name]',    -- Name for buffers with no name
    modified_icon = '',      -- Icon for showing modified buffer
    close_icon = '',         -- Icon for closing tab with mouse
    separator = "▌",          -- Separator icon on the left side
    padding = 3,              -- Prefix and suffix space
    color_all_icons = false,  -- Color devicons in active and inactive tabs
    always_show_tabs = true,  -- Always show tabline
    right_separator = false,  -- Show right separator on the last tab
    show_index = false,       -- Shows the index of tab before filename
    show_icon = true,         -- Shows the devicon
}
EOF


""""""""""""""""""""""""""""""""""""""""""""""""
"
" FILE TREE
"
""""""""""""""""""""""""""""""""""""""""""""""""

let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).

let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.

let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options

let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.

let g:nvim_tree_symlink_arrow = ' >> ' " defaults to ' ➛ '. used as a separator between symlinks' source and target.

let g:nvim_tree_window_picker_exclude = {
    \   'filetype': [
    \     'notify',
    \     'packer',
    \     'qf'
    \   ],
    \   'buftype': [
    \     'terminal'
    \   ]
    \ }

" Dictionary of buffer option names mapped to a list of option values that
" indicates to the window picker that the buffer's window should not be
" selectable.
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_show_icons = {
    \ 'git': 0,
    \ 'folders': 1,
    \ 'files': 1,
    \ 'folder_arrows': 0,
    \ }

"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath.
"if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
"but this will not work when you set indent_markers (because of UI conflict)

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   }
    \ }

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

set termguicolors

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue

lua << EOF
-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  auto_close          = false,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {}
    },
    number = false,
    relativenumber = false,
    signcolumn = "yes"
  },
  trash = {
    cmd = "trash",
    require_confirm = true
  }
}
EOF

""""""""""""""""""""""""""""""""""""""""""""""""
"
" AUTO SAVE
"
""""""""""""""""""""""""""""""""""""""""""""""""

lua << EOF
local autosave = require("autosave")

autosave.setup(
    {
        enabled = true,
        execution_message = "autosaved.",
        events = {"InsertLeave", "TextChanged"},
        conditions = {
            exists = true,
            filename_is_not = {'/etc/*'},
            filetype_is_not = {},
            modifiable = true
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 135
    }
)
EOF

""""""""""""""""""""""""""""""""""""""""""""""""
"
" GREETER
"
""""""""""""""""""""""""""""""""""""""""""""""""

lua << EOF
local alpha = require("alpha")

alpha.setup(require'alpha.themes.startify'.config)
EOF

""""""""""""""""""""""""""""""""""""""""""""""""
"
" TO DO COMMENTS
"
""""""""""""""""""""""""""""""""""""""""""""""""

lua << EOF
require("todo-comments").setup {
  signs = true, -- show icons in the signs column
  sign_priority = 8, -- sign priority
  -- keywords recognized as todo comments
  keywords = {
    FIX = {
      icon = " ", -- icon used for the sign, and in search results
      color = "error", -- can be a hex color, or a named color (see below)
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
      -- signs = false, -- configure signs for some keywords individually
    },
    TODO = { icon = " ", color = "info" },
    HACK = { icon = " ", color = "warning" },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
  },
  merge_keywords = true, -- when true, custom keywords will be merged with the defaults
  -- highlighting of the line containing the todo comment
  -- * before: highlights before the keyword (typically comment characters)
  -- * keyword: highlights of the keyword
  -- * after: highlights after the keyword (todo text)
  highlight = {
    before = "", -- "fg" or "bg" or empty
    keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
    after = "fg", -- "fg" or "bg" or empty
    pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
    comments_only = true, -- uses treesitter to match keywords in comments only
    max_line_len = 400, -- ignore lines longer than this
    exclude = {}, -- list of file types to exclude highlighting
  },
  -- list of named colors where we try to extract the guifg from the
  -- list of hilight groups or use the hex color if hl not found as a fallback
  colors = {
    error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
    warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
    info = { "DiagnosticInfo", "#2563EB" },
    hint = { "DiagnosticHint", "#10B981" },
    default = { "Identifier", "#7C3AED" },
  },
  search = {
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    -- regex that will be used to match keywords.
    -- don't replace the (KEYWORDS) placeholder
    pattern = [[\b(KEYWORDS):]], -- ripgrep regex
    -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
  },
}
EOF

""""""""""""""""""""""""""""""""""""""""""""""""
"
" TROUBLE
"
""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>xx <cmd>TroubleToggle<cr>

lua << EOF
  require("trouble").setup {
    position = "bottom", -- position of the list can be: bottom, top, left, right
    height = 10, -- height of the trouble list when position is top or bottom
    width = 50, -- width of the list when position is left or right
    icons = true, -- use devicons for filenames
    mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    fold_open = "", -- icon used for open folds
    fold_closed = "", -- icon used for closed folds
    group = true, -- group results by file
    padding = true, -- add an extra new line on top of the list
    action_keys = { -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
        open_split = { "<c-x>" }, -- open buffer in new split
        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        open_tab = { "<c-t>" }, -- open buffer in new tab
        jump_close = {"o"}, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = {"zM", "zm"}, -- close all folds
        open_folds = {"zR", "zr"}, -- open all folds
        toggle_fold = {"zA", "za"}, -- toggle fold of current file
        previous = "k", -- preview item
        next = "j" -- next item
    },
    indent_lines = true, -- add an indent guide below the fold icons
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    auto_jump = {"lsp_definitions"}, -- for the given modes, automatically jump if there is only a single result
    signs = {
        -- icons / text used for a diagnostic
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "﫠"
    },
    use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
  }
EOF

""""""""""""""""""""""""""""""""""""""""""""""""
"
" DISTANT
"
""""""""""""""""""""""""""""""""""""""""""""""""

lua << EOF
    require('distant').setup {
      -- Applies Chip's personal settings to every machine you connect to
      --
      -- 1. Ensures that distant servers terminate with no connections
      -- 2. Provides navigation bindings for remote directories
      -- 3. Provides keybinding to jump into a remote file's parent directory
      ['*'] = require('distant.settings').chip_default()
    }
EOF

""""""""""""""""""""""""""""""""""""""""""""""""
"
" COLORIZER
"
""""""""""""""""""""""""""""""""""""""""""""""""

lua <<EOF
    require('colorizer').setup (
        {'*'},
        { 
                RGB      = true,         -- #RGB hex codes
	            RRGGBB   = true,         -- #RRGGBB hex codes
	            names    = true,         -- "Name" codes like Blue
                RRGGBBAA = true,        -- #RRGGBBAA hex codes
	            rgb_fn   = false,        -- CSS rgb() and rgba() functions
	            hsl_fn   = false,        -- CSS hsl() and hsla() functions
	            css      = false,        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
	            css_fn   = false,        -- Enable all CSS *functions*: rgb_fn, hsl_fn
	            -- Available modes: foreground, background
	            mode     = 'background' -- Set the display mode.
        }
    )
EOF


""""""""""""""""""""""""""""""""""""""""""""""""
"
" MARKDOWN FLOW
"
""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
require('mkdnflow').setup({
    -- Type: boolean. Use default mappings (see '❕Commands and default
    --     mappings').
    -- 'false' disables mappings
    default_mappings = true,        

    -- Type: boolean. Create directories (recursively) if link contains a
    --     missing directory.
    -- 'false' prevents missing directories from being created
    create_dirs = true,             

    -- Type: string. Navigate to links relative to the directory of the first-
    --     opened file.
    -- 'current' navigates links relative to currently open file
    links_relative_to = 'first',    

    -- Type: key-value pair(s). The plugin's features are enabled only when one
    -- of these filetypes is opened; otherwise, the plugin does nothing. NOTE:
    -- extensions are converted to lowercase, so any filetypes that convention-
    -- ally use uppercase characters should be provided here in lowercase.
    filetypes = {md = true, rmd = true, markdown = true},

    -- Type: boolean. When true, the createLinks() function tries to evaluate
    --     the string provided as the value of new_file_prefix.
    -- 'false' results in the value of new_file_prefix being used as a string,
    --     i.e. it is not evaluated, and the prefix will be invariant.
    evaluate_prefix = true,

    -- Type: string. Defines the prefix that should be used to create new links.
    --     This is evaluated at the time createLink() is run, which is to say
    --     that it's run whenever <CR> is pressed (under the default mappings).
    --     This makes for many interesting possibilities.
    new_file_prefix = [[os.date('%Y-%m-%d_')]],

    -- Type: boolean. When true and Mkdnflow is searching for the next/previous
    --     link in the file, it will wrap to the beginning of the file (if it's
    --     reached the end) or wrap to the end of the file (if it's reached the
    --     beginning during a backwards search).
    wrap_to_beginning = false,
    wrap_to_end = false
})
EOF

