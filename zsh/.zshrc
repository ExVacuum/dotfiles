# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Plugins

source $ZDOTDIR/antigen.zsh

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme romkatv/powerlevel10k

antigen apply

# Completion
autoload -U compinit
compinit

zstyle ':completion::complete:*' use-cache 1

# Autocorrect
setopt correctall

# Extended Globbing
setopt extendedglob

# History
export HISTSIZE=2000
export HISTFILE="$ZDOTDIR/.history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space

# PATH
export PATH="${PATH}:$HOME/.local/bin"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

### ALIASES

# ls -> lsd
alias ls="lsd -Al"

pfetch

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
