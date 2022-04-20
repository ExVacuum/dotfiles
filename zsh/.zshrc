# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.config/zsh/antigen.zsh

antigen theme romkatv/powerlevel10k

antigen bundle zsh-users/zsh-autosuggestions

antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

alias ls='colorls -a'
alias ssh='kitty +kitten ssh'
alias ncmpcs='tmux new-session "tmux source-file ~/.config/ncmpcpp/tmux_session"' # Tmux session with ncmpcpp and cover art
alias russ='russ -d/home/si/russ_db.db'

eval "$(rbenv init - zsh)"
source $(dirname $(gem which colorls))/tab_complete.sh

test -r ~/.dir_colors && eval $(dircolors ~/.dir_colors)

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

