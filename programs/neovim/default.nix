{pkgs}: {
  enable = true;
  viAlias = true;
  vimAlias = true;
  plugins = with pkgs.vimPlugins; [
    {
      plugin = copilot-vim;
      config = "
        let g:copilot_node_command = \"${pkgs.nodejs_18}/bin/node\"
      ";
    }
    {
      plugin = ale;
      config = "
        let g:ale_completion_enabled = 1
        let g:ale_completion_autoimport = 1
        let g:ale_linters = {'javascript': [], 'typescript': ['tsserver', 'eslint'], 'typescript.tsx': ['tsserver', 'eslint'], 'rust': ['analyzer'] }
        let g:ale_fixers = {'javascript': [], 'typescript': ['eslint'], 'typescript.tsx': ['eslint'], 'rust': ['rustfmt'] }
        let g:ale_lint_on_text_changed = 'normal'
        let g:ale_lint_on_insert_leave = 1
        let g:ale_lint_delay = 0
        let g:ale_set_quickfix = 0
        let g:ale_set_loclist = 0
        let g:ale_javascript_eslint_executable = 'eslint --cache'

        nnoremap <silent> gd :ALEGoToDefinition<enter>
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
    {
      plugin = tsuquyomi;
      config = "
        let g:tsuquyomi_disable_quickfix = 1
      ";
    }
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
