" Set Host Prog
let g:python3_host_prog = '~/pythonenv/neovim/bin/python'

" Indent Guide
let g:indent_blankline_char = '┊'
let g:indent_blankline_show_first_indent_level = v:false
lua vim.g.indentLine_bufNameExclude = { "term:.*" }

" Vim Startify
let g:startify_change_to_dir=1
let g:startify_change_cmd = 'cd'

function! s:projectDirectories()
    let l:files = systemlist('cat ~/.projectdirs')
    return map(l:files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
          \ { 'type': function('s:projectDirectories'), 'header': ['   Project'] },
          \ { 'type': 'files',                          'header': ['   MRU']            },
          \ { 'type': 'dir',                            'header': ['   MRU '. getcwd()] },
          \ { 'type': 'sessions',                       'header': ['   Sessions']       },
          \ { 'type': 'bookmarks',                      'header': ['   Bookmarks']      },
          \ { 'type': 'commands',                       'header': ['   Commands']       },
          \]

" Theming
set termguicolors
set noshowmode
set encoding=UTF-8

function! NativeBackground()
    augroup Background
        autocmd!
        autocmd ColorScheme * hi Normal ctermbg=none guibg=none
    augroup END
endfunction

let g:airline_theme='base16'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

let g:colorscheme_dark='base16-darktooth'
let g:colorscheme_light='base16-github'
let g:colorscheme_current=g:colorscheme_dark

function! WhiteColor()
    augroup Background
        autocmd!
        autocmd ColorScheme * hi Normal guibg=#D0D0D0
    augroup END
    augroup ModifiedColor
        autocmd!
        autocmd VimEnter * hi airline_tabfill guibg=#F5F5F5
        autocmd ColorScheme * hi VertSplit guibg=#F5F5F5
        autocmd ColorScheme * hi LineNr guibg=#F5F5F5
        autocmd ColorScheme * hi CursorLineNr guibg=#F5F5F5 guifg=#333333
        autocmd ColorScheme * hi SignColumn guibg=#F5F5F5
        autocmd ColorScheme * hi CursorColumn guibg=#F5F5F5
        autocmd ColorScheme * hi CursorLine guibg=#F5F5F5
        autocmd ColorScheme * hi ColorColumn guibg=#F5F5F5
        autocmd ColorScheme * hi QuickFixLine guibg=#F5F5F5
        autocmd ColorScheme * hi LspDiagnosticsSignError guibg=#F5F5F5 guifg=#FF0000
        autocmd ColorScheme * hi LspDiagnosticsSignWarning guibg=#F5F5F5 guifg=#FFA500
        autocmd ColorScheme * hi LspDiagnosticsSignInformation guibg=#F5F5F5 guifg=#D3D3D3
        autocmd ColorScheme * hi LspDiagnosticsSignHint guibg=#F5F5F5 guifg=#D3D3D3
    augroup END
endfunction

function! BlackColor()
    call NativeBackground()
    augroup ModifiedColor
        autocmd!
        autocmd VimEnter * hi airline_tabfill guibg=#2D2D2D
        autocmd ColorScheme * hi VertSplit guibg=#2D2D2D
        autocmd ColorScheme * hi LineNr guibg=#2D2D2D
        autocmd ColorScheme * hi CursorLineNr guibg=#2D2D2D
        autocmd ColorScheme * hi SignColumn guibg=#2D2D2D
        autocmd ColorScheme * hi CursorColumn guibg=#2D2D2D
        autocmd ColorScheme * hi CursorLine guibg=#2D2D2D
        autocmd ColorScheme * hi ColorColumn guibg=#2D2D2D
        autocmd ColorScheme * hi QuickFixLine guibg=#2D2D2D
        autocmd ColorScheme * hi LspDiagnosticsSignError guibg=#2D2D2D guifg=#FF0000
        autocmd ColorScheme * hi LspDiagnosticsSignWarning guibg=#2D2D2D guifg=#FFA500
        autocmd ColorScheme * hi LspDiagnosticsSignInformation guibg=#2D2D2D guifg=#D3D3D3
        autocmd ColorScheme * hi LspDiagnosticsSignHint guibg=#2D2D2D guifg=#D3D3D3
    augroup END
endfunction

sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=
sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=

call BlackColor()
execute 'colorscheme '.g:colorscheme_current

function! ToggleLightDarkTheme()
    if g:colorscheme_current ==# g:colorscheme_dark
        call WhiteColor()
        let g:colorscheme_current  = g:colorscheme_light
    else
        call BlackColor()
        let g:colorscheme_current  = g:colorscheme_dark
    endif

    execute 'colorscheme '.g:colorscheme_current
endfunction

" Basic Settings
set tabstop=4 shiftwidth=4 expandtab 
set clipboard+=unnamedplus
set number
set relativenumber
set nowrap
let mapleader = ' '
syntax on
set hidden
set scrolloff=10
set mouse+=a

" NERDTree Settings
let NERDTreeChDirMode=2
let NERDTreeShowHidden=1

function! NewFile()
  let curline = getline('.')
  call inputsave()
  let l:name = input('[New File] Name : ')
  call inputrestore()
  execute 'e '.l:name
  w
  NERDTreeRefreshRoot
endfunction

" Window Navigation Keybindings
function! HorizontalSplit()
    split
    wincmd j
endfunction

function! VerticalSplit()
    vsplit
    wincmd l
endfunction

" Buffer Settings
function! GoToBuffer()
  let curline = getline('.')
  call inputsave()
  let buffer_number = input('[GO TO BUFFER] Buffer number: ')
  call inputrestore()
  let vim_command = 'b'.buffer_number
  execute vim_command
endfunction

function! DeleteBuffer()
  let curline = getline('.')
  call inputsave()
  let buffer_number = input('[DELETE BUFFER] Buffer number: ')
  call inputrestore()
  let vim_command = buffer_number.'bd'
  execute vim_command
endfunction

function! DeleteAllBuffers()
    execute '%bd | e#'
endfunction

function! FindWordUnderCursorInBuffers()
    let wordUnderCursor = expand("<cword>")
    execute 'Ack! '.wordUnderCursor
endfunction

function! FindInBuffer()
  let curline = getline('.')
  call inputsave()
  let pattern = input('[FIND IN BUFFERS] Pattern : ')
  call inputrestore()
  let vim_command = 'Ack! '.pattern
  execute vim_command
endfunction

let g:previous_buffer = -1
let g:next_buffer = bufnr('%')
function s:UpdateBuffers()
    let s:name = bufname('%')
    let s:num = bufnr('%')

    if s:name !=# '' &&
                \s:name !=# 'vmenu' &&
                \s:name[0:4] !=# 'term:' &&
                \s:num !=# g:next_buffer &&
                \s:name[:3] !=# 'NERD'
        let g:previous_buffer = g:next_buffer
        let g:next_buffer = s:num
    endif
endfunction

function! PreviousBuffer()
    execute 'b'.g:previous_buffer
endfunction

augroup PreBuf
    autocmd BufEnter * call s:UpdateBuffers()
augroup END

" VMenu Settings
nnoremap <silent> <Space> :call vmenu#show()<CR>

" VMenu Categories
let g:keybindings_refactor_run = vmenu#category('r', 'Refactor/Run')
let g:keybindings_git = vmenu#category('g', 'Git')
let g:keybindings_error = vmenu#category('e', 'Error')
let g:keybindings_interactive = vmenu#category('i', 'Interactive')
let g:keybindings_spelling = vmenu#category('s', 'Spelling')
let g:keybindings_help = vmenu#category('h', 'Help')
let g:keybindings_documentation = vmenu#category('d', 'Documentation')
let g:keybindings_tab = vmenu#category('t', 'Tab')
let g:keybindings_jumps_jobs = vmenu#category('j', 'Jumps/Jobs')
let g:keybindings_buffer = vmenu#category('b', 'Buffer')
let g:keybindings_window = vmenu#category('w', 'Window')
let g:keybindings_ui = vmenu#category('u', 'Ui/Toggle')
let g:keybindings_file = vmenu#category('f', 'File/Find')

" File Keybindings
call vmenu#commands([
            \['f', 'Find Files',  'Files'],
            \['d', 'Delete Files',  'call fzf#run({"sink": "silent !rm"})'],
            \['l', 'Find Lines',  'BLines'],
            \['x', 'Find Xdg Open',  'call fzf#run(fzf#wrap({"sink": "silent !xdg-open"}))'],
            \['t', 'Focus Tree',  'NERDTreeFind'],
            \['c', 'Close Tree',  'NERDTreeClose'],
            \['r', 'Refresh Tree',  'NERDTreeRefreshRoot'],
            \['n', 'New File',  'call NewFile()'],
        \], {
            \'parent': g:keybindings_file
        \})

function! basic#git_commit()
    let curline = getline('.')
    call inputsave()
    let message = input('[Git Commit Message]: ')
    call inputrestore()
    call terminal#run_command('git commit -m "'.message.'"')
endfunction

function! basic#git_branch()
    let curline = getline('.')
    call inputsave()
    let name = input('[Git Branch Name]: ')
    call inputrestore()
    call terminal#run_command('git checkout -b "'.name.'"')
    call terminal#run_command('git push -u origin "'.name.'"')
endfunction

function! basic#git_save()
    call terminal#run_command('git add --all')
    call basic#git_commit()
    call terminal#run_command('git push')
endfunction

" LATEX FIX
let g:tex_flavor = "latex"

" Git Keybindings
call vmenu#commands([
            \['s', 'Status',  'GFiles?'],
            \['d', 'Diff',  'Gdiffsplit'],
            \['m', 'Checkout master',  'call terminal#run_command("git checkout master")'],
            \['l', 'List Buffer Commits',  'BCommits'],
            \['o', 'Open Browser',  'Gbrowse'],
            \['p', 'Pull',  'call terminal#run_command("git pull")'],
            \['b', 'Show Branches',  'call terminal#run_command("git branch")'],
            \['S', 'Save All',  'call basic#git_save()'],
            \['A', 'Add All',  'call terminal#run_command("git add --all")'],
            \['C', 'Create Commits',  'call basic#git_commit()'],
            \['P', 'Push Branch',  'call terminal#run_command("git push")'],
            \['B', 'Create Branch',  'call basic#git_branch()'],
        \], {
            \'parent': g:keybindings_git
        \})

" Window Keybindings
call vmenu#commands([
            \['q', 'Quit Window', 'q'],
            \['L', 'Add Vertical Space', 'vertical resize +5'],
            \['H', 'Remove Vertical Space', 'vertical resize -5'],
            \['J', 'Add Horizontal Space', 'res +5'],
            \['K', 'Remove Horizontal Space', 'res -5'],
            \['p', 'Previous Window', 'call PreviousBuffer()'],
            \['h', 'Focus Left', 'wincmd h'],
            \['j', 'Focus Down',  'wincmd j'],
            \['k', 'Focus Top',  'wincmd k'],
            \['l', 'Focus Right',  'wincmd l'],
            \['v', 'Split Vertical',  'call VerticalSplit()'],
            \['b', 'Split Horizontal',  'call HorizontalSplit()']
        \], {
            \'parent': g:keybindings_window
        \})

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-d': 'bdelete',
  \ 'ctrl-v': 'vsplit' }

" Buffer Keybindings
call vmenu#commands([
            \['g', 'GoTo Buffer', 'call GoToBuffer()'],
            \['d', 'Delete Buffer', 'call DeleteBuffer()'],
            \['q', 'Delete Current Buffer', 'bd'],
            \['D', 'Delete All Buffers', 'call DeleteAllBuffers()'],
            \['f', 'Find In Buffer', 'call FindInBuffer()'],
            \['s', 'Find Word Under Cursor in Buffers', 'call FindWordUnderCursorInBuffers()'],
            \['b', 'List All Buffers', 'Buffers'],
            \['S', 'Save All Buffers', 'wa'],
            \['l', 'Next Buffer', 'bn'],
            \['k', 'Next Buffer', 'bn'],
            \['h', 'Previous Buffer', 'bp'],
            \['j', 'Previous Buffer', 'bp']
        \], { 
            \'parent': g:keybindings_buffer
        \})

" Tab Keybindings (Views)
call vmenu#commands([
            \['n', 'New Tab', 'tabnew'],
            \['l', 'Next View', 'tabnext'],
            \['k', 'Next View', 'tabnext'],
            \['h', 'Previous View', 'tabprevious'],
            \['j', 'Previous View', 'tabprevious'],
            \['d', 'Close View', 'tabclose']
        \], {
            \'parent': g:keybindings_tab
        \})

" Ui/Toggle Keybindings
call vmenu#commands([
            \['t', 'Tree', 'NERDTreeToggle'],
            \['c', 'Theme Light/Dark', 'call ToggleLightDarkTheme()'],
        \], {
            \'parent': keybindings_ui
        \})

" Simple Keybindings
call vmenu#commands([
            \['Q', 'Quit All', 'qa'],
            \['q', 'Quit', 'q'],
            \['S', 'Save All Files', 'wa'],
        \])

