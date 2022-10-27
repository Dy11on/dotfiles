set number
set relativenumber
set mouse=a
set autoindent
set noexpandtab
set ignorecase
set smartcase
set nohlsearch
set incsearch
set showmatch
set hidden
" set scrolloff=999
set noswapfile
set nobackup
set shortmess+=c
set undodir=~/.config/nvim/undodir
set undofile
set signcolumn=yes
set cursorline
set completeopt=menuone,noselect
set termguicolors
set nocompatible
set autochdir
filetype plugin on
syntax on


filetype plugin indent on
filetype indent on

let mapleader = " "
set rtp+=/usr/local/opt/fzf

" Keeping the cursor middle positioned
" From this lovely post https://vi.stackexchange.com/questions/26039/how-to-keep-cursor-vertically-aligned-to-center-even-at-the-end-of-buffer
augroup KeepCentered
  autocmd!
  autocmd CursorMoved * normal! zz
augroup END
inoremap <CR> <C-\><C-O><C-E><CR>
inoremap <BS> <BS><C-O>zz
nnoremap o <C-E>o

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Autoapply text width to markdown files
au BufRead,BufNewFile *.md setlocal textwidth=80

" removes any highlighting
nnoremap <silent> <Leader>l :nohl<CR>

call plug#begin('~/.vim/plugged')

" colorschemes 
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'savq/melange'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'navarasu/onedark.nvim'


Plug 'dylanaraps/wal.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
" Nice line under f and t for quick finding
Plug 'unblevable/quick-scope'
Plug 'vimwiki/vimwiki'
Plug 'airblade/vim-gitgutter'
Plug 'psliwka/vim-smoothie'
Plug 'Yggdroot/indentLine'
" To toggle hartime run :HardTimeOn/Off
Plug 'takac/vim-hardtime'
Plug 'christoomey/vim-tmux-navigator' 
" gc to comment out multiple lines at once in visual mode
Plug 'tpope/vim-commentary'
" plugin for saving vim sessions (mainly for tmux ressurect saving)
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'ap/vim-css-color'
Plug 'AndrewRadev/splitjoin.vim'
" plugin for previewing commit messages under the line, <leader>gm
Plug 'rhysd/git-messenger.vim'
" plugin for opening current line in github <leader>gb <leader>gh, <leader>go for git
" blame, git blob, and repo view  respectively
Plug 'ruanyl/vim-gh-line'

"Plug 'fatih/vim-go'
Plug 'vim-test/vim-test'
Plug 'karb94/neoscroll.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" native lsp plugins
 Plug 'neovim/nvim-lspconfig'
 Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
 " treesitter-context plugin makes the scroll bar appear when scrolling
 " through code if the function is too long
 Plug 'nvim-treesitter/nvim-treesitter-context'
 Plug 'kyazdani42/nvim-web-devicons'
 Plug 'kyazdani42/nvim-tree.lua'
 Plug 'glepnir/dashboard-nvim'
 Plug 'nvim-lua/popup.nvim'
 Plug 'nvim-lua/plenary.nvim'
 Plug 'nvim-telescope/telescope.nvim'
 Plug 'nvim-lualine/lualine.nvim'
 Plug 'windwp/nvim-autopairs'
 " temporary plugin while tree-sitter indentation is being fixed
 Plug 'yioneko/nvim-yati'
 " Null lsp is used for ALE/linting experiences, attached mypy to it and eslint
 " so far
 Plug 'jose-elias-alvarez/null-ls.nvim'
 Plug 'simrat39/rust-tools.nvim'
 Plug 'williamboman/nvim-lsp-installer'
 Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

 " nvim cmp plugins
 Plug 'hrsh7th/nvim-cmp'
 Plug 'hrsh7th/cmp-vsnip'
 Plug 'hrsh7th/vim-vsnip'
 Plug 'hrsh7th/cmp-buffer'
 Plug 'hrsh7th/cmp-path'
 Plug 'hrsh7th/cmp-nvim-lsp'
 Plug 'onsails/lspkind-nvim'
" cmp section ends

 "etc plugins
 Plug 'glepnir/lspsaga.nvim', {'branch': 'main'}
 Plug 'norcalli/nvim-colorizer.lua'
 Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
 Plug 'phaazon/hop.nvim'
 Plug 'folke/trouble.nvim'
 Plug 'kevinhwang91/nvim-bqf'
 Plug 'ThePrimeagen/harpoon'
 " plugin to link git issues <leader>gy default mapping
 Plug 'ruifm/gitlinker.nvim'

 
 " colorscheme 
Plug 'EdenEast/nightfox.nvim' 
Plug 'sainnhe/everforest'
call plug#end()

lua << EOF
require('neoscroll').setup({
easing_function = "cubic" -- Default easing function
-- Set any other options as needed
})
-- Syntax: t[keys] = {function, {function arguments}}
-- Use the "sine" easing function
local t = {}
t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '170', [['sine']]}}
t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '170', [['sine']]}}

require('neoscroll.config').set_mappings(t)


-- https://github.com/daliusd/cfg/blob/master/.vimrc#L278 for picking one server for react gd
local function filter(arr, fn)
  if type(arr) ~= "table" then
    return arr
  end

  local filtered = {}
  for k, v in pairs(arr) do
    if fn(v, k, arr) then
      table.insert(filtered, v)
    end
  end

  return filtered
end

local function filterReactDTS(value)
  return string.match(value.filename, '.yarn/cache') == nil
end

local function on_list(options)
  -- https://github.com/typescript-language-server/typescript-language-server/issues/216
  local items = options.items
  if #items > 1 then
    items = filter(items, filterReactDTS)
  end

  vim.fn.setqflist({}, ' ', { title = options.title, items = items, context = options.context })
  vim.api.nvim_command('cfirst')
end

local nvim_lsp = require('lspconfig')

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys

-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  --vim.keymap.set('n', '<space>wl', function()
    --print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  --end, bufopts)
  -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  -- vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

 -- Use a loop to conveniently call 'setup' on multiple servers and
 -- map buffer local keybindings when the language server attaches

-- To use LSPInstall run :LSPInstall {name of server}
-- local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
-- lsp_installer.on_server_ready(function(server)
--     local opts = {
-- 	flags = {
-- 		debounce_text_changes = 500,
-- 	}
--     }
-- 
--     -- (optional) Customize the options passed to the server
--     -- if server.name == "tsserver" then
--     --     opts.root_dir = function() ... end
--     -- end
-- 
--     -- This setup() function is exactly the same as lspconfig's setup function.
--     -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--     server:setup(opts)
-- end)


-- Makes null ls default formatter for typescript filetypes
nvim_lsp.tsserver.setup({
  on_attach = function(client, bufnr)
    client.server_capabilities.document_formatting = false
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
  end,
})

nvim_lsp.pylsp.setup({
  on_attach = function(client, bufnr)
    client.server_capabilities.document_formatting = false
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
  end,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
		enabled = false,
		ignore = {'E501', 'W503'},
		},
	mccabe = {
		enabled = false,
		},
	      }
      }
    },
})

local cmp = require('cmp')
local lspkind = require('lspkind')
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  formatting = {
    format = function(entry, vim_item)
    -- fancy icons and a name of kind
    vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

    -- set a name for each source
    vim_item.menu = ({
      buffer = "[Buffer]",
      nvim_lsp = "[LSP]",
      luasnip = "[LuaSnip]",
      nvim_lua = "[Lua]",
      latex_symbols = "[Latex]",
    })[entry.source.name]
    return vim_item
    end
  },
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    -- ['<S-Tab>'] = cmp.mapping.select_prev_item(),
	--['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})


local servers = { 'terraformls', 'rust_analyzer' }
local capabilities = require('cmp_nvim_lsp').default_capabilities()
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end
-- null ls setup
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md#using-local-executables

local async_formatting = function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    vim.lsp.buf_request(
        bufnr,
        "textDocument/formatting",
        vim.lsp.util.make_formatting_params({}),
        function(err, res, ctx)
            if err then
                local err_msg = type(err) == "string" and err or err.message
                -- you can modify the log message / level (or ignore it completely)
                vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
                return
            end

            -- don't apply results if buffer is unloaded or has been modified
            if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
                return
            end

            if res then
                local client = vim.lsp.get_client_by_id(ctx.client_id)
                vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
                vim.api.nvim_buf_call(bufnr, function()
                    vim.cmd("silent noautocmd update")
                end)
            end
        end
    )
end

local null_ls = require("null-ls")

local sources = {
	null_ls.builtins.formatting.black,
	null_ls.builtins.formatting.prettier.with({
		prefer_local = "node_modules/.bin",
		extra_args = { "--config", vim.fn.expand("~/wave/src/next-wave/.prettierrc") },
	}),
        null_ls.builtins.diagnostics.eslint_d.with({
		prefer_local = "node_modules/.bin",
	}),
	null_ls.builtins.diagnostics.mypy.with({
		only_local = ".venv/bin",
	}),
	null_ls.builtins.diagnostics.flake8.with({
		only_local = ".venv/bin",
	}),
	-- eslint_d for linting on save file in case?
        -- require("null-ls").builtins.diagnostics.eslint_d,

}
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
    -- add your sources / config options here
    sources = sources, 
    debug = false,
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePost", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    async_formatting(bufnr)
                end,
            })
        end
    end,
})
local callback = function()
    vim.lsp.buf.format({
        bufnr = bufnr,
        filter = function(client)
            return client.name == "null-ls"
        end
    })
end,


-- Treesitter support
require'nvim-treesitter.configs'.setup {
  auto_install = true,
  -- change this to indent enable = true when its fixed, yati is a bandaid solution 
  yati = {
    enable = true
  },
  highlight = {
    ensure_installed = { "js", "python", "typescript", "tsx", "tf", "vim", "lua", "bash", "rust" },
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

" Hop nvim setup

lua << EOF
require'hop'.setup()
vim.api.nvim_set_keymap('n', 'f', "<cmd>HopWord<cr>", {})
EOF

"nvim autopairs
lua << EOF
require("nvim-autopairs").setup {}
EOF

" Telescope keys
lua << EOF
require('telescope').setup{
 defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}

local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
	wrap_results = true,
	-- taken from here https://github.com/razak17/nvim/blob/107bfbdb4abaca728838511169932bf86b9b803b/lua/user/modules/tools/config/telescope/init.lua
        mappings = {
            i = {
		["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            },
    	    n = {
		["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist, 
	    }
        },
    },
})

require('telescope').load_extension('fzf')
require('telescope').load_extension('harpoon')

require('bqf').setup()
EOF


" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>rr <cmd>Telescope live_grep<cr>
nnoremap <leader>rs <cmd>Telescope grep_string<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
" nnoremap <leader>fh <cmd>Telescope oldfiles<cr>
nnoremap <leader>fq <cmd>Telescope quickfix<cr>


" LSP Kind, emojis for autocompletion
lua <<EOF
require('lspkind').init({
    -- DEPRECATED (use mode instead): enables text annotations
    --
    -- default: true
    -- with_text = true,

    -- defines how annotations are shown
    -- default: symbol
    -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
    mode = 'symbol_text',

    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    preset = 'codicons',

    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",
      Field = "ﰠ",
      Variable = "",
      Class = "ﴯ",
      Interface = "",
      Module = "",
      Property = "ﰠ",
      Unit = "塞",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "פּ",
      Event = "",
      Operator = "",
      TypeParameter = ""
    },
})
EOF


let g:tokyonight_style = "night"
set background=dark
let g:onedark_config = {
    \ 'style': 'deep',
\}
" colorscheme onedark / terafox
let g:everforest_background = 'hard'
colorscheme onedark 
" require('rust-tools').setup(opts)
"colorscheme wal
"set bg=dark
highlight Normal ctermbg=NONE guibg=none

"nnoremap <silent> <Leader>r :Rg<CR>
"nnoremap <silent> <Leader>ff :GFiles<CR>


"zt zb zz is cursor at top bottom and center respectively


" quickscope highlight only when pressing f and t 
let g:qs_highlight_on_keys = ['f','F','t','T']
" quickscope change colors
highlight QuickScopePrimary guifg='#17ebd6' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#ec80ff' gui=underline ctermfg=81 cterm=underline


"lightline changes colors
let g:lightline = {'colorscheme': 'onedark'}

"vimwiki markdown change 
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

"vim rooter set rooter

let g:smoothie_enabled = 0
let g:smoothie_update_interval = 10
let g:smoothie_speed_constant_factor = 20
let g:smoothie_speed_linear_factor = 20

" nvim-cmp settings
lua << EOF
EOF

" VSCode highlight colors for nvim-cmp
" gray
highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
" blue
highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
" light blue
highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
" pink
highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
" front
highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4

" Code navigation shortcuts lsp shortcuts
" nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
" nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
" nnoremap <silent> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>q <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
" Show diagnostic popup on cursor hold
"autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> <leader>e <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <leader>n <cmd>lua vim.lsp.diagnostic.goto_next()<CR>





"cmp source stuff
" lua << EOF
" local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

" require'lspconfig'.rust_analyzer.setup {
"   capabilities = capabilities,
" }
" EOF


lua << EOF
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = { 'dashboard' },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
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

lua << EOF
require'nvim-tree'.setup { -- BEGIN_DEFAULT_OPTS
  auto_reload_on_write = true,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  open_on_setup = false,
  open_on_setup_file = false,
  open_on_tab = false,
  sort_by = "name",
  update_cwd = false,
  view = {
    adaptive_size = true,
    hide_root_folder = false,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {
        -- user mappings go here
      },
    },
  },
  renderer = {
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
    }
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  ignore_ft_on_setup = {},
  system_open = {
    cmd = "",
    args = {},
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      diagnostics = false,
      git = false,
      profile = false,
    },
  },
} -- END_DEFAULT_OPTS
EOF


let NERDTreeShowHidden=1
nnoremap <leader>nt :NvimTreeToggle<CR>


" setting update time to see if coc autocompletion is faster
set updatetime=100


" Setting tabs to lines for easier reading
set listchars=tab:\|\ 
set list 
" indentLine config, dont know if i need to delete above
let g:indentLine_char = '|'
" indentLine turned off for dashboard nvim
let g:indentLine_fileTypeExclude = ['dashboard']


" Remapping local and global marks
nnoremap mn mN
nnoremap 'n 'N
nnoremap me mE
nnoremap 'e 'E
nnoremap mi mI
nnoremap 'i 'I
nnoremap mo mO
nnoremap 'o 'O
nnoremap ml mL
nnoremap 'l 'L
nnoremap mu mU
nnoremap 'u 'U
nnoremap my mY
nnoremap 'y 'Y

" Paste for last yank that wasn't delete
nnoremap <leader>p "0p

nnoremap <silent> <leader><leader> :source ~/dotfiles/nvim/init.vim<CR>
nnoremap <silent> <leader>nv :e ~/dotfiles/nvim/init.vim<CR>

nnoremap n nzzzv
nnoremap N Nzzzv

vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==


" Markdown toggle stuff
nnoremap <leader>mp :MarkdownPreview
nnoremap <leader>ms :MarkdownPreviewStop
nnoremap <leader>mt :MarkdownPreviewToggle

" Split Vertical buffer
nnoremap <leader>sv :vs<CR>
" Create new tab
nnoremap <leader>tn :tabn<CR>
" close buffer
nnoremap <leader>bd :bd<CR>
" Cycle buffers


" Command to set the current directory to the dir where the current file is
command! SetCDToFileDir cd %:p:h
nn <leader>W :SetCDToFileDir<cr>

let g:dashboard_default_executive='telescope'

let g:dashboard_custom_header_height =200 
let g:dashboard_custom_header = [
	\'      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⣀⡤⠤⠶⠶⠒⠒⠒⠒⠢⠤⢄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
	\'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠴⠊⢡⣠⣆⡵⠦⠤⠄⠐⠾⠴⣦⣰⣈⡑⠢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
	\'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠴⠓⠂⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠓⠺⢶⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
	\'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠴⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣤⡶⠋⠀⠀⠀⠀⠀⠀⠉⠳⢤⡀⠀⠀⠀⠀⠀⠀⠀⠀ ',
	\'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠎⡀⠀⠂⠀⠀⠀⠀⠀⢀⣤⣶⣿⣿⣿⣿⣿⣭⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠢⣄⠀⠀⠀⠀⠀⠀ ',
	\'⠀⠀⠀⠀⠀⠀⠀⠀⠔⢉⠅⡢⡨⡀⢠⡠⠀⢀⣴⣾⣿⠟⣿⠁⠸⣿⣿⣯⢻⣿⣿⣷⣦⣀⢐⠂⠀⢀⠀⠀⠀⠠⠘⢦⡀⠀⠀⠀⠀ ',
	\'⠀⠀⠀⠀⠀⠀⢠⠊⠀⠃⠪⡠⡪⣜⠆⣨⣾⣿⣿⡿⠁⠀⢻⠀⠀⠹⣿⣿⡄⠙⣿⣿⣿⣿⣷⣴⣈⢆⢄⢔⡹⡢⠑⠀⠳⡄⠀⠀⠀ ',
	\'⠀⠀⠀⠀⠀⢠⠃⠀⠀⠀⠀⡄⡐⠁⣼⣿⣿⢿⡟⠁⠀⠀⠘⠀⠀⠀⠈⢻⣇⠀⠈⢿⡟⣿⣿⣿⡿⡗⠋⠊⠀⠀⠀⠀⠀⠹⡄⠀⠀ ',
	\'⠀⠀⠀⠀⢀⠊⠄⠀⠀⠀⠀⠀⠈⣸⣿⣿⠏⡞⠒⠒⠂⠤⠀⠀⠀⠀⠀⠀⠙⠂⠉⠈⢻⠸⣿⣿⣧⡚⠌⠴⡠⣠⢀⠀⠀⠀⢹⡀⠀ ',
	\'⠀⠀⠀⠀⡎⢸⡘⡌⣦⡐⣦⠲⡰⣿⣿⡟⠀⠁⠀⣀⡀⠀⠀⠀⢀⠀⠀⠀⠀⢀⣠⣤⣀⠁⢻⣿⣿⣿⡷⡞⣱⢃⠞⠄⠠⠀⠈⡇⠀ ',
	\'⠀⠀⠀⢰⢣⢰⠘⡌⣦⢀⡦⠜⠀⠀⣿⠃⠀⣰⠟⠉⠛⠦⠀⠀⢸⡆⠀⠀⠀⠟⠉⠉⠙⠆⠈⣿⡷⠅⠀⠙⡇⣾⣶⠀⡆⢠⠀⡇⠀ ',
	\'⠀⠀⠀⢸⠸⡘⢠⡃⢋⢹⠀⠀⠀⠀⢻⠀⡀⡋⡀⠀⠀⠀⠀⠀⠘⠐⠀⠀⠀⠐⠒⠆⠰⠆⡦⢠⠇⠀⠀⠀⢸⡝⡋⠀⠷⡈⢀⠇⠀ ',
	\'⠀⠀⠀⠘⡆⡇⡜⣃⠜⢹⠀⠀⠀⠀⠚⡾⠛⢉⣄⡤⠀⠒⠒⠈⠉⠉⠉⠉⠉⠉⠁⠐⢖⢤⡀⢸⠄⠀⠀⠀⡰⠠⡙⣌⢧⡘⡜⠀⠀ ',
	\'⠀⠀⠀⠀⢣⠞⡄⡵⡀⠚⠀⠀⠀⠀⠀⢥⠀⣿⠀⠁⢀⣠⣴⣶⣾⣿⣿⣿⣷⣶⣶⣄⡀⢸⠁⡾⡑⠡⠄⠀⠥⡐⠞⡔⠕⡰⠁⠀⠀ ',
	\'⠀⠀⠀⠀⠸⣌⠈⡊⠄⠀⡀⠀⠀⠀⠄⢙⠆⠘⢶⣾⣿⠿⠛⠉⠉⠉⠉⠉⠉⠙⠿⣿⡿⠁⠰⠖⠚⠊⠀⠙⣆⠈⡞⢁⠔⠀⠀⠀⠀ ',
	\'⠀⠀⠀⠀⠀⠈⢦⡈⠀⠀⡱⡆⢀⠥⠠⠨⣚⡄⠀⠻⢤⡔⠒⠀⠀⠉⠉⠉⠉⠐⡢⠍⡔⠂⢭⡠⠀⠀⠀⢠⡙⡠⢭⢅⠀⠀⠀⠀⠀ ',
	\'⠀⠀⠀⠀⠀⠀⠀⠈⠓⢵⡊⡩⠮⡌⣄⢭⡛⣸⡦⣄⡀⠈⠓⠒⠒⠐⠒⠒⠂⠁⠠⢐⡀⠀⠀⠀⠀⠀⠀⢜⢪⡇⠚⡄⠧⡀⠀⠀⠀ ',
	\'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢉⠡⠶⠬⠭⢽⠿⢿⠝⣉⡟⠿⣶⢦⣤⣤⣤⣤⣶⣾⣿⣇⠣⠄⠤⠔⠉⠉⠑⠂⡁⠨⣀⠷⠀⢰⠀⠀⠀ ',
	\'⠀⠀⠀⠀⠀⠀⠀⢀⣔⡪⣥⠀⠀⠀⠀⠀⠀⠀⠉⠙⢇⠀⠈⠺⣿⣿⢿⣿⣿⠟⡸⠚⠉⠁⠁⠀⠀⠀⢀⠠⢑⠢⢥⠅⢒⡁⠀⠀⠀ ',
	\'⠀⠀⠀⠀⠀⠀⠜⠁⠀⠈⠀⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠉⠲⢄⠈⠉⢹⠻⠯⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠘⡆⠀⠀ ',
	\ ]
highlight dashboardHeader guifg='#732e3e' ctermfg=200

lua <<EOF
vim.g.dashboard_custom_section = {
    a = {description = {'  New file                  '}, command = 'DashboardNewFile'},
    b = {description = {'  Browse files              '}, command = 'Telescope find_files'},
    c = {description = {'  Recents                   '}, command = 'Telescope oldfiles'},
    d = {description = {'  Settings                  '}, command = 'edit ~/dotfiles/nvim/init.vim'},
    e = {description = {'  Exit                      '}, command = 'exit'},
}
EOF

" copy and paste clipboard stuff
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+y$

"toggle quickfix list fast
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction
nnoremap <leader>ss :call ToggleQuickFix()<CR>


"For the splitjoin plugin press gS to open stuff in {} and gJ to join stuff in {}
"

" ts/js files spacing
augroup SyntaxSettings
	autocmd!
	autocmd BufNewFile, BufRead *.tsx set filetype=typescriptreact
	" https://mukeshsharma.dev/2022/02/08/neovim-workflow-for-terraform.html
	autocmd BufNewFile, BufRead *.tf,*.tfvars set filetype=terraform
augroup END

autocmd Filetype javascript setlocal ts=2 sw=2 sts=0 noexpandtab
autocmd Filetype typescript setlocal ts=2 sw=2 sts=0 noexpandtab
autocmd Filetype typescriptreact setlocal ts=2 sw=2 sts=0 noexpandtab

" pretty references
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

nnoremap <leader>tf :TestFile<cr>
nnoremap <leader>tn :TestNearest<cr>
nnoremap <leader>tv :TestVisit<cr>


" harpoon remaps / config
lua << EOF
require("harpoon").setup({
	global_settings = {
		mark_branch = true,
	}
})
EOF
nnoremap ma :lua require("harpoon.mark").add_file()<cr>
nnoremap <leader>fh :lua require("harpoon.ui").toggle_quick_menu()<cr>
nnoremap 'n :lua require("harpoon.ui").nav_file(1)<cr>
nnoremap 'e :lua require("harpoon.ui").nav_file(2)<cr>
nnoremap 'i :lua require("harpoon.ui").nav_file(3)<cr>
nnoremap 'o :lua require("harpoon.ui").nav_file(4)<cr>
nnoremap 'l :lua require("harpoon.ui").nav_file(5)<cr>
nnoremap 'u :lua require("harpoon.ui").nav_file(6)<cr>
nnoremap 'y :lua require("harpoon.ui").nav_file(7)<cr>

"Remaps hl movements to beginning/end of the line
nnoremap L $
nnoremap H ^

" " folding with treesitter
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

" " automatically open all folds in new file
" " zM to close all folds, za to toggle, zc to close, zo to open
" autocmd BufReadPost,FileReadPost * normal zR
" 
" Using nvim as a mergetool
" git config --global mergetool.fugitive.cmd 'nvim -f -c "Gvdiffsplit!" "$MERGED"'
" git config --global merge.tool fugitive
" 
" run 'git mergetool' to get this split
" 




"lspsaga config
lua << EOF 
local keymap = vim.keymap.set
local saga = require 'lspsaga'
-- use default config
saga.init_lsp_saga({
	code_action_keys = {
		quit = "<ESC>"
	}
})
-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

-- Code action
keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })

-- Rename
keymap("n", "rn", "<cmd>Lspsaga rename<CR>", { silent = true })

-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
-- keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

-- Show line diagnostics
keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

-- Show cursor diagnostic
keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

-- Diagnsotic jump can use `<c-o>` to jump back
keymap("n", "<leader>e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap("n", "<leader>n", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

-- Only jump to error
keymap("n", "[E", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
keymap("n", "]E", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })

-- Outline
keymap("n","<leader>o", "<cmd>LSoutlineToggle<CR>",{ silent = true })

-- Hover Doc
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

-- Float terminal
keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
-- if you want pass somc cli command into terminal you can do like this
-- open lazygit in lspsaga float terminal
keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>", { silent = true })
-- close floaterm
keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
EOF 


nnoremap <leader>rno :set relativenumber!<cr>

nnoremap <leader>cd "=strftime("%b %d, %Y")<cr>P

" gitlinker setup
lua << EOF
require"gitlinker".setup()
EOF

lua << EOF
local fn = vim.fn

function _G.qftf(info)
    local items
    local ret = {}
    -- The name of item in list is based on the directory of quickfix window.
    -- Change the directory for quickfix window make the name of item shorter.
    -- It's a good opportunity to change current directory in quickfixtextfunc :)
    --
    -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
    -- local root = getRootByAlterBufnr(alterBufnr)
    -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
    --
    if info.quickfix == 1 then
        items = fn.getqflist({id = info.id, items = 0}).items
    else
        items = fn.getloclist(info.winid, {id = info.id, items = 0}).items
    end
    local limit = 31
    local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
    local validFmt = '%s │%5d:%-3d│%s %s'
    for i = info.start_idx, info.end_idx do
        local e = items[i]
        local fname = ''
        local str
        if e.valid == 1 then
            if e.bufnr > 0 then
                fname = fn.bufname(e.bufnr)
                if fname == '' then
                    fname = '[No Name]'
                else
                    fname = fname:gsub('^' .. vim.env.HOME, '~')
                end
                -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
                if #fname <= limit then
                    fname = fnameFmt1:format(fname)
                else
                    fname = fnameFmt2:format(fname:sub(1 - limit))
                end
            end
            local lnum = e.lnum > 99999 and -1 or e.lnum
            local col = e.col > 999 and -1 or e.col
            local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
            str = validFmt:format(fname, lnum, col, qtype, e.text)
        else
            str = e.text
        end
        table.insert(ret, str)
    end
    return ret
end

vim.o.qftf = '{info -> v:lua._G.qftf(info)}'

-- Adapt fzf's delimiter in nvim-bqf
require('bqf').setup({
    filter = {
        fzf = {
            extra_opts = {'--bind', 'ctrl-o:toggle-all', '--delimiter', '│'}
        }
    }
})
EOF
