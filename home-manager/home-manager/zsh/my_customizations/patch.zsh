_fix_cursor() {
    echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor) # Add fix cursor to precmd

if [[ "$OSTYPE" == "darwin"* ]];then
    alias \
        ls="ls -G" \
        grep="grep" \
        diff="diff" \
        ccat="highlight --out-format=ansi"
# Linux specific configuraion ( TESTED ON UBUNTU )
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias \
        ls="ls -hN --color=auto --group-directories-first" \
        grep="grep --color=auto" \
        diff="diff --color=auto" \
        ccat="highlight --out-format=ansi"
fi

alias \
	f="$FILE" \
	e="$EDITOR" \
	v="$EDITOR"


# Common alias! abbreviate them
alias \
    sv="sudo nvim" \
    vi="vim" \
    vim="nvim" \

# List directory contents
alias \
    lsa="ls -lah" \
    l="ls -lah" \
    ll="ls -lh" \
    la="ls -lAh"

# change directory backwards
alias \
    ..="cd .." \
    ...="cd ../.." \
    ....="cd ../../.." \
    .....="cd ../../../.." \
    ......="cd ../../../../.." \
    .......="cd ../../../../../.."

alias cat=batcat

alias my_internal_ip='python3 -c "import socket; print([l for l in ([ip for ip in socket.gethostbyname_ex(socket.gethostname())[2] if not ip.startswith(\"127.\")][:1], [[(s.connect((\"8.8.8.8\", 53)), s.getsockname()[0], s.close()) for s in [socket.socket(socket.AF_INET, socket.SOCK_DGRAM)]][0][1]]) if l][0][0])"'

test_terminal_color ()
{
awk -v term_cols="${width:-$(tput cols || echo 80)}" 'BEGIN{
    s="/\\";
    for (colnum = 0; colnum<term_cols; colnum++) {
        r = 255-(colnum*255/term_cols);
        g = (colnum*510/term_cols);
        b = (colnum*255/term_cols);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum%2+1,1);
    }
    printf "\n";
}'
}

alias terminal_test_colors=test_terminal_color
alias with-cachix-key="vaultenv --secrets-file <(echo "cachix#signing-key") -- "
alias nrc="nix shell -f default.nix -c"

if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'  # SSH remote editor
else
   export EDITOR='nvim' # Local editor
fi

autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line
