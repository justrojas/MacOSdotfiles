# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme setting
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  git
  sudo
  zsh-autosuggestions
  zsh-syntax-highlighting
  fzf
)

source $ZSH/oh-my-zsh.sh

# Docker Completion Functions
function _docker_all() {
    reply=($(docker ps -a --format '{{.Names}}'))
}

function _docker_on() {
    reply=($(docker ps --format '{{.Names}}'))
}

compctl -K _docker_all drm
compctl -K _docker_on dkill
compctl -K _docker_all drunning 
compctl -K _docker_all dzsh

# Confirmation function
function confirm() {
    echo -n "$1 [y/N]: "
    read response
    case $response in
        [yY][eE][sS]|[yY])
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Tmux and FZF functions
function newTmuxSessionFromFzf() {
  local file=$(fzf --query="$1" +m -e)
  if [ -n "$file" ]; then
    local dir=$(dirname "$file")
    tmux new-session -c "$dir"
  fi
}

function fuzzycd() {
  local file=$(fzf --query="$1" +m)
  if [ -n "$file" ]; then
    cd "$(dirname "$file")" || return
  fi
}

function open_nvim() {
  nvim
}
zle -N open_nvim

function clear_screen() {
  clear
  zle reset-prompt
}
zle -N clear_screen

# Aliases
alias l='eza -lh  --icons=auto'
alias ls='eza -1   --icons=auto'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
alias ld='eza -lhD --icons=auto'
alias tls='tmux ls'
alias tcd='newTmuxSessionFromFzf'
alias fcd=fuzzycd
alias dc='docker compose'

# Keybindings
bindkey '^n' open_nvim
bindkey "^p" clear_screen

# Load powerlevel10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Initialize zoxide
eval "$(zoxide init --cmd cd zsh)"
