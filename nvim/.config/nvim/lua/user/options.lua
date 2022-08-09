local options = {
    mouse=a                -- Enable your mouse
    splitbelow             -- Horizontal splits will automatically be below
    splitright             -- Vertical splits will automatically be to the right
    smartindent            -- Makes indenting smart
    autoindent             -- Good auto indent
    updatetime=300         -- Faster completion
    timeoutlen=500         -- By default timeoutlen is 1000 ms
    formatoptions-=cro     -- Stop newline continution of comments
    clipboard=unnamedplus  -- Copy paste between vim and everything else
    autochdir              -- Your working directory will always be the same as your working directory
    shortmess+=c           -- Remove default auto complete prompt
    cmap w!! w !sudo tee %
    nocompatible

    -- Configure backspace so it acts as it should act
    backspace=eol,start,indent
    whichwrap+=<,>,h,l

    --  silent (no beep)
    vb t_vb=--.
    backup = false,
}
