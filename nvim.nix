{ config, inputs, lib, pkgs, ... }:


let
  pixel = pkgs.vimUtils.buildVimPlugin {
    name = "pixel.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "bjarneo";
      repo = "pixel.nvim";
      rev = "fd06541f7c790e22ad18f0ee5873b246de5b4a87";
      hash = "sha256-D4o5IkLsW4iq6ceeCHKHCNwxVpEV8fYPbpms+J7ZcJQ=";
    };
  };
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      #vim-plug
      lightline-vim
      pixel
      mason-nvim
    ];
    extraConfig = ''

      syntax on
      set number
      set relativenumber
      set cursorline
      "set cursorcolumn

      set list
      set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·


      " INDENTING "
      set smartindent
      set copyindent
      set smarttab
      set autoindent
      set tabstop=4
      set softtabstop=2
      set expandtab


      set nowrap
      "set visualbell
      set noerrorbells
      set colorcolumn=80
      set scrolloff=8
      set sidescrolloff=5
      set encoding=utf-8
      "set title
      "set spell


      " COLORSCHEME "
      colorscheme pixel
      set background=dark
      set termguicolors


      " SEARCHING "
      set incsearch
      set ignorecase
      set smartcase
      set hlsearch
      "search commands

      " make laggy connections faster
      set ttyfast

      set showcmd
      set showmode
      set showmatch
      set history=1000

      "Enable auto completion menu after pressing TAB.
      set wildmenu
      "Make wildmenu behave like similar to Bash completion.
      set wildmode=list:longest
      " There are certain files that we would never want to edit with Vim. " Wildmenu will ignore files with these extensions.
      set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

      if has('mouse')
          set mouse=a
      endif

      set clipboard+=unnamedplus

      " remember last cursor position
      autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif
    '';
  };
}
