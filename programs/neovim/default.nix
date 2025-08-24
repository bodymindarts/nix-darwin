{pkgs}: {
  enable = true;
  viAlias = true;
  vimAlias = true;
  plugins = with pkgs.vimPlugins; [
    {
      plugin = ale;
      config = "
        let g:ale_completion_enabled = 0
        let g:ale_completion_autoimport = 0
        let g:ale_linters = {'javascript': [], 'typescript': ['tsserver', 'eslint'], 'typescriptreact': ['tsserver', 'eslint'], 'rust': ['analyzer'] }
        let g:ale_fixers = {'javascript': [], 'typescript': ['eslint'], 'typescript.tsx': ['eslint'], 'rust': ['rustfmt'] }
        let g:ale_lint_on_text_changed = 'normal'
        let g:ale_lint_on_insert_leave = 1
        let g:ale_lint_delay = 0
        let g:ale_set_quickfix = 0
        let g:ale_set_loclist = 0
        let g:ale_set_highlights = 0
        let g:ale_set_signs = 1
        let g:ale_virtualtext_cursor = 0
        let g:ale_javascript_eslint_options = '--cache'
        let g:ale_javascript_eslint_executable = 'eslint_d'
        let g:ale_fix_on_save = 1

        nnoremap <silent> gd :ALEGoToDefinition<enter>
        nnoremap <silent> gr :ALEFindReferences -quickfix<enter>
        nnoremap <leader>r :ALERename<cr>
      ";
    }
    {
      plugin = ctrlp-vim;
      config = "
        let g:ctrlp_user_command = 'ag %s -l -f --nocolor -g \"\"'
        let g:ctrlp_show_hidden = 0
        let g:ctrlp_use_caching = 0
        let g:ctrlp_switch_buffer = 'e'
        let g:ctrlp_root_markers = ['tags', '.tags']
      ";
    }
    {
      plugin = ack-vim;
      config = "
        let g:ackprg = 'ag --nogroup --nocolor --column'
      ";
    }
    bats-vim
    vim-commentary
    vim-surround
    vim-repeat
    vim-fugitive
    vim-unimpaired
    vim-terraform
    vim-nix
    vim-go
    vim-graphql
    typescript-vim
    vim-cool
    vim-jsx-pretty
    vimproc-vim
    {
      plugin = tsuquyomi;
      config = "
        let g:tsuquyomi_disable_quickfix = 1
      ";
    }
    nvim-bacon
    {
      plugin = rust-vim;
      config = "
        let g:rustfmt_autosave = 1
      ";
    }
    {
      plugin = pgsql-vim;
      config = "
        let g:sql_type_default = 'pgsql'
      ";
    }
    {
      plugin = jellybeans-vim;
      config = "
        let g:jellybeans_overrides = { 'Special': { 'guifg': 'de5577' }, }
      ";
    }
  ];
  extraConfig = builtins.readFile ./extra.vim;
}
