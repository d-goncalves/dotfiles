# Read by every zsh: keep all zsh config under ~/.config/zsh
export ZDOTDIR="$HOME/.config/zsh"

# Keep $HOME free of dotfiles: point tools at XDG locations
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export JUMP_HOME="$XDG_DATA_HOME/jump"
export npm_config_cache="$XDG_CACHE_HOME/npm"
export MPLCONFIGDIR="$XDG_CACHE_HOME/matplotlib"
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export KUBECONFIG="$XDG_CONFIG_HOME/kube/config"
export KUBECACHEDIR="$XDG_CACHE_HOME/kube"
export TALOSCONFIG="$XDG_CONFIG_HOME/talos/config"
export CHECKPOINT_DISABLE=1  # terraform update check; stops it creating ~/.terraform.d
