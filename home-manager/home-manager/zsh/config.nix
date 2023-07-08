{config, pkgs, ...}:
{
    programs.zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        enableSyntaxHighlighting = true;
        autocd = true;

        plugins = [
          {
# will source zsh-autosuggestions.plugin.zsh
              name = "zsh-autosuggestions";
              file = "zsh-autosuggestions.plugin.zsh";
              src = pkgs.fetchFromGitHub {
                  owner = "zsh-users";
                  repo = "zsh-autosuggestions";
                  rev = "v0.4.0";
                  sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
              };
          }
        {
            name = "fzf-tab";
            file = "fzf-tab.plugin.zsh";
            src = pkgs.fetchFromGitHub {
                owner = "Aloxaf";
                repo = "fzf-tab";
                rev = "5a81e13792a1eed4a03d2083771ee6e5b616b9ab";
                sha256 = "sha256-dPe5CLCAuuuLGRdRCt/nNruxMrP9f/oddRxERkgm1FE=";
            };
        }
        {
            name = "zsh-syntax-highlighting";
            file = "zsh-syntax-highlighting.zsh";
            src = builtins.fetchGit {
                url = "https://github.com/zsh-users/zsh-syntax-highlighting/";
                rev = "932e29a0c75411cb618f02995b66c0a4a25699bc";
            };
        }
        {
            name = "zsh-colored-man-pages";
            file = "colored-man-pages.plugin.zsh";
            src = builtins.fetchGit {
                url = "https://github.com/ael-code/zsh-colored-man-pages";
                rev = "57bdda68e52a09075352b18fa3ca21abd31df4cb";
            };
        }
        ];


        oh-my-zsh = {
            enable = true;
            plugins = [
                "sudo"
                    "colored-man-pages"
                    "colorize"
                    "command-not-found"
                    "copypath"
                    "copyfile"
                    "copybuffer"
                    "fd"
                    "fzf"
                    "gcloud"
                    "git"
                    "gitfast"
                    "git-prompt"
                    "history"
                    "man"
                    "common-aliases"
                    /* "fzf-tab" */
                    /* "tmux" */
            ];
            custom = "$HOME/.config/home-manager/zsh/my_customizations";
            theme="dg";
        };
    };
}
/* "ssh-agent" */
/* "gpg-agent" */
