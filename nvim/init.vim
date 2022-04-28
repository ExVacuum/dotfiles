call plug#begin(stdpath('data') . '/plugged')

    " Official nvim LSP integration
    Plug 'neovim/nvim-lspconfig'
    
    " COQ Completion
    Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
    Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
    Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
    
    " ARM Syntax
    Plug 'ARM9/arm-syntax-vim'
   
    " Markdown Live Preview
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

    " Limelight
    Plug 'junegunn/limelight.vim'
       
    " Lua Status Line
    Plug 'nvim-lualine/lualine.nvim'
    
    " Lua Tab Line
    Plug 'seblj/nvim-tabline'
    
    " Tree Viewer
    Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
    
    " Icons for the UI
    Plug 'kyazdani42/nvim-web-devicons'

    " Discord Rich Presence
    Plug 'andweeb/presence.nvim'

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

    " gruvbox
    Plug 'ellisonleao/gruvbox.nvim'

    " Remote Work
    Plug 'chipsenkbeil/distant.nvim'

    " Colorize Color Codes
    Plug 'norcalli/nvim-colorizer.lua'

    " Pop-up Terminal
    Plug 's1n7ax/nvim-terminal'
  
    " NUI
    Plug 'MunifTanjim/nui.nvim' 

    " Window Picker
    Plug 'https://gitlab.com/yorickpeterse/nvim-window.git'

    " LaTeX Live Preview
    Plug 'donRaphaco/neotex', { 'for': 'tex' }

    " Git
    " Plug 'tanvirtin/vgit.nvim'
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

set autoread " Auto-load changed file content

set showtabline=2 " Show tabs

" Keybinds for switching tabs
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" Escape Terminal Mode
tnoremap <Esc> <C-\><C-n>

let g:tex_flavor = "latex"

""""""""""""""""""""""""""""""""""""""""""""""""
"
" NORD COLOR SCHEME
"
""""""""""""""""""""""""""""""""""""""""""""""""

colorscheme gruvbox
set termguicolors

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

-- Gutter diagnostic icons
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local sumneko_binary_path = vim.fn.exepath('lua-language-server')
local sumneko_root_path = vim.fn.fnamemodify(sumneko_binary_path, ':h:h:h')

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local lspconfig = require'lspconfig'
lspconfig.vimls.setup(coq.lsp_ensure_capabilities({on_attach=on_attach})) -- vimls: vim
lspconfig.ccls.setup(coq.lsp_ensure_capabilities({on_attach=on_attach}))  -- CCLS: C/C++
lspconfig.tsserver.setup(coq.lsp_ensure_capabilities({on_attach=on_attach})) -- TSSERVER: TypeScript
lspconfig.cssls.setup(coq.lsp_ensure_capabilities({on_attach=on_attach})) -- CSSLS: CSS
lspconfig.bashls.setup(coq.lsp_ensure_capabilities({on_attach=on_attach})) -- bashls: Bash
lspconfig.pylsp.setup(coq.lsp_ensure_capabilities({on_attach=on_attach})) -- pylsp: Python
lspconfig.sumneko_lua.setup(coq.lsp_ensure_capabilities({
    on_attach=on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {
                    'vim',
                    'workspace',
                    'configurations',
                    'project',
                    'kind',
                    'language',
                    'targetdir',
                    'files',
                    'filter',
                    'defines',
                    'symbols',
                    'optimize',
                    'links',
                    'libdirs',
                    'prebuildcommands',
                    'buildcommands',
                    'postbuildcommands',
                    'newaction',
                },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    }
})) -- sumneko_lua: lua
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
lspconfig.solargraph.setup(coq.lsp_ensure_capabilities({
    on_attach=on_attach,
    filetypes = { "ruby" }
})) -- solargraph: ruby
lspconfig.gradle_ls.setup(coq.lsp_ensure_capabilities({on_attach=on_attach})) -- gradle_ls
local pid = vim.fn.getpid()
local omnisharp_bin = "/opt/omnisharp/run"
lspconfig.omnisharp.setup(coq.lsp_ensure_capabilities({
    on_attach=on_attach,
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
    root_dir = lspconfig.util.root_pattern("*.csproj","*.sln"),
    ...
}))
lspconfig.texlab.setup(coq.lsp_ensure_capabilities({
    on_attach=on_attach,
    cmd = { "texlab" },
    filetypes = { "tex", "bib" },
    settings = {
        texlab = {
            auxDirectory = ".",
            bibtexFormatter = "texlab",
            build = {
              args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
              executable = "latexmk",
              forwardSearchAfter = false,
              onSave = false
            },
            chktex = {
              onEdit = false,
              onOpenAndSave = false
            },
            diagnosticsDelay = 300,
            formatterLineLength = 80,
            forwardSearch = {
              args = {}
            },
            latexFormatter = "latexindent",
            latexindent = {
              modifyLineBreaks = false
            }
        }
    },
    single_file_support = true
})) --texlab: LaTeX
lspconfig.jdtls.setup(coq.lsp_ensure_capabilities({on_attach=on_attach})) -- JDT LS (Java)
lspconfig.yamlls.setup(coq.lsp_ensure_capabilities({on_attach=on_attach})) -- YAML LS (YAML)
lspconfig.zeta_note.setup(coq.lsp_ensure_capabilities({
    on_attach=on_attach,
    cmd = {'/home/si/.cargo/bin/zeta-note'}
})) -- Zeta-Note (Markdown)
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
    theme = 'gruvbox',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {'CHADTree', 'vim-plug', 'Trouble', 'terminal'},
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

nnoremap <leader>n <cmd>CHADopen<cr>

let g:chadtree_settings = { 'theme.text_colour_set': 'env' }

""""""""""""""""""""""""""""""""""""""""""""""""
"
" GREETER
"
""""""""""""""""""""""""""""""""""""""""""""""""

lua << EOF
local env = getfenv(1)
-- see if the file exists
function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
function lines_from(file)
  if not file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end

local handle = io.popen('printf "$XDG_CONFIG_HOME"')
local configdir = handle:read("*a")
local alpha = require("alpha")
local dashboard = require'alpha.themes.dashboard' 
dashboard.section.header.val = lines_from(configdir .. '/nvim/headerfile')
dashboard.section.buttons.val = {
    dashboard.button( "e", "  New file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "q", "  Quit NVIM" , ":qa<CR>"),
}
handle = io.popen('fortune')
local fortune = handle:read("*a")
handle:close()
dashboard.section.footer.val = fortune
dashboard.config.opts.noautocmd = true
vim.cmd[[autocmd User AlphaReady echo 'ready']]
alpha.setup(dashboard.config)
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
    position = "right", -- position of the list can be: bottom, top, left, right
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
	            rgb_fn   = true,        -- CSS rgb() and rgba() functions
	            hsl_fn   = true,        -- CSS hsl() and hsla() functions
	            css      = true,        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
	            css_fn   = true,        -- Enable all CSS *functions*: rgb_fn, hsl_fn
	            -- Available modes: foreground, background
	            mode     = 'foreground' -- Set the display mode.
        }
    )
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""
"
" TERMINAL TOGGLE
"
"""""""""""""""""""""""""""""""""""""""""""""""""

lua <<EOF
    vim.o.hidden = true
    require('nvim-terminal').setup()
EOF


""""""""""""""""""""""""""""""""""""""""""""""""
"
" WINDOW PICKER
"
""""""""""""""""""""""""""""""""""""""""""""""""

map <silent> <leader>w :lua require('nvim-window').pick()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""
"
" TELESCOPE
"
""""""""""""""""""""""""""""""""""""""""""""""""

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""
"
" GIT INTEGRATION
"
""""""""""""""""""""""""""""""""""""""""""""""""

" lua << EOF
" require('vgit').setup()
" EOF

