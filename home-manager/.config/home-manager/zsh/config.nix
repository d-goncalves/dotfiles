{ pkgs, ... }:
let
  pluginImporter = plugin: {
    name = plugin;
    file = "plugins/${plugin}/${plugin}.plugin.zsh";
    src = builtins.fetchGit {
      url = "https://github.com/ohmyzsh/ohmyzsh/";
      rev = "9730915910c6cc7640f8af6063ffb93becf0414a";
    };
  };
in
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    dotDir = ".config/zsh";

    initExtra = builtins.readFile ./config.zsh;

    plugins = [
      {
        name = "zsh-git-prompt";
        file = "zshrc.sh";
        src = pkgs.fetchFromGitHub {
          owner = "olivierverdier";
          repo = "zsh-git-prompt";
          rev = "0a6c8b610e799040b612db8888945f502a2ddd9d";
          sha256 = "sha256-HBYg4Itohf3FtARJ1CUiJlvaFvtPQ7hPNPlQk4N7oac=";
        };
      }
      {
        name = "zsh-vi-mode";
        src = pkgs.fetchFromGitHub {
          owner = "jeffreytse";
          repo = "zsh-vi-mode";
          rev = "4680766357ddbaa5332648e470a6717e4a46791a";
          sha256 = "sha256-3suYNn2992vEJT64nnvTcu8/e2kqCzr4w32eOUrbSag=";
        };
      }
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "5a81e13792a1eed4a03d2083771ee6e5b616b9ab";
          sha256 = "sha256-dPe5CLCAuuuLGRdRCt/nNruxMrP9f/oddRxERkgm1FE=";
        };
      }
      {
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
      (pluginImporter "aliases")
      (pluginImporter "colored-man-pages")
      (pluginImporter "colorize")
      (pluginImporter "command-not-found")
      (pluginImporter "common-aliases")
      (pluginImporter "copybuffer")
      (pluginImporter "copyfile")
      (pluginImporter "copypath")
      (pluginImporter "fd")
      (pluginImporter "fzf")
      (pluginImporter "gcloud")
      (pluginImporter "git")
      (pluginImporter "git-prompt")
      (pluginImporter "gitfast")
      (pluginImporter "history")
      (pluginImporter "man")
      (pluginImporter "nomad")
      (pluginImporter "sudo")
      (pluginImporter "terraform")
      (pluginImporter "tmux")
    ];
  };
}
