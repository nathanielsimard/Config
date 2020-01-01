let g:neomake_python_enabled_makers = ['flake8', 'mypy']
let g:LanguageClient_serverCommands['python'] = ['python', '-m', 'pyls']

call Keybinding_lsp('python')
call g:keybindings_refactor.add_filetype('python', vmenu#keybinding#command#new('f', 'Format Document', 'Black', g:menu))
call g:keybindings_documentation.add_filetype('python', vmenu#keybinding#command#new('g', 'Generate Doc', 'Pydocstring', g:menu))

