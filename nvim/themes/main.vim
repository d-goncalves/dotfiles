source $HOME/.config/nvim/themes/airline.vim
source $HOME/.config/nvim/themes/onedark.vim

let base16colorspace=256

if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

colorscheme base16-ocean
" colorscheme base16-ocean
" colorscheme onedark
