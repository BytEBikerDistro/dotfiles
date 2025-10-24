# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#!/data/data/com.termux/files/usr/bin/env zsh
# =============================================================================
# ZSH Configuration File (.zshrc)
# Based on:- https://github.com/zdharma-continuum/zinit-configs/tree/master/vladdoster
# =============================================================================
# -----------------------------------------------------------------------------
# ENVIRONMENT VARIABLES & PATH
# -----------------------------------------------------------------------------
# Essential PATH exports
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/zinit/polaris/bin:$PATH"

# Editor preferences
export EDITOR="nvim"
export VISUAL="nvim"

# Enable auto-cd
setopt AUTO_CD
# Turn off "no match" errors
setopt nonomatch

# -----------------------------------------------------------------------------
# ZINIT PLUGIN MANAGER INSTALLATION
# -----------------------------------------------------------------------------
# Auto-install Zinit if not present
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    # Only show output if not using instant prompt
    if [[ -z "$P9K_INSTANT_PROMPT" ]]; then
        print -P "%F{33}Installing %F{220}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager...%f"

        # Create directory structure
        if command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"; then
            # Try to clone the repository
            if command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git"; then
                print -P "%F{33}Installation successful.%f"
            else
                print -P "%F{160}Git clone failed. Please check your internet connection and try again.%f"
                return 1
            fi
        else
            print -P "%F{160}Failed to create zinit directory.%f"
            return 1
        fi
    else
        # Silent installation during instant prompt
        command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
        command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" >/dev/null 2>&1
    fi
fi

# Load Zinit
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# -----------------------------------------------------------------------------
# ZINIT CONFIGURATION
# -----------------------------------------------------------------------------
# Zinit directory structure - UPDATED TO MATCH DEFAULT PATH
typeset -gAH ZINIT
ZINIT[HOME_DIR]="$HOME/.local/share/zinit"
ZINIT[BIN_DIR]="$ZINIT[HOME_DIR]/zinit.git"
ZINIT[COMPLETIONS_DIR]="$ZINIT[HOME_DIR]/completions"
ZINIT[SNIPPETS_DIR]="$ZINIT[HOME_DIR]/snippets"
ZINIT[ZCOMPDUMP_PATH]="$ZINIT[HOME_DIR]/zcompdump"
ZINIT[PLUGINS_DIR]="$ZINIT[HOME_DIR]/plugins"
ZINIT[OPTIMIZE_OUT_DISK_ACCESSES]=1

# Zinit variables
ZI_REPO='zdharma-continuum'

# -----------------------------------------------------------------------------
# OH-MY-ZSH & PREZTO PLUGINS
# -----------------------------------------------------------------------------
# Load useful Oh My Zsh library functions and plugins
zi for is-snippet \
    OMZL::{compfix,completion,git,key-bindings}.zsh \
    PZT::modules/{history}

# Load completions for specific tools
zi as'completion' for \
    OMZP::pip/_pip

# -----------------------------------------------------------------------------
# ZINIT ANNEXES
# -----------------------------------------------------------------------------
# Load useful Zinit extensions
zi light-mode for \
    "$ZI_REPO"/zinit-annex-{binary-symlink,patch-dl,submods}

# -----------------------------------------------------------------------------
# PYTHON CONFIGURATION
# -----------------------------------------------------------------------------
# Custom pip completion function
function _pip_completion() {
    local words cword
    read -Ac words
    read -cn cword
    reply=(
        $(
            COMP_WORDS="$words[*]"
            COMP_CWORD=$(( cword-1 ))
            PIP_AUTO_COMPLETE=1 $words 2>/dev/null
        )
    )
}
compctl -K _pip_completion pip3

# -----------------------------------------------------------------------------
# ZSH ENHANCEMENT PLUGINS
# -----------------------------------------------------------------------------

# Enhanced completions - Additional completion definitions
zi ice zsh-users/zsh-completions

# Auto-suggestions - Suggests commands as you type based on history
zi ice atload'_zsh_autosuggest_start' \
       atinit'
           ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
           bindkey "^_" autosuggest-execute
           bindkey "^ " autosuggest-accept'
zi light zsh-users/zsh-autosuggestions

# Fast syntax highlighting - Real-time command syntax validation
zi light-mode for \
      $ZI_REPO/fast-syntax-highlighting


# FZF history search - Fuzzy search through command history
zi ice joshskidmore/zsh-fzf-history-search

# Zsh autocomplete - Real-time type-ahead autocompletion
zi ice atload'
        bindkey              "^I" menu-select
        bindkey -M menuselect "$terminfo[kcbt]" reverse-menu-complete'
zi light marlonrichert/zsh-autocomplete

# -----------------------------------------------------------------------------
# FINALIZATION
# -----------------------------------------------------------------------------
# Initialize completions and replay cached completions
# at the end of a Zinit configuration to ensure that after all plugins are loaded,
# the completion system is properly initialized and
# syntax highlighting/autosuggestion widgets are correctly bound
#
# Uncomment it if you have issue with highlighting/autosuggestion
#
# zi for atload'
#       zicompinit; zicdreplay
#       _zsh_highlight_bind_widgets
#       _zsh_autosuggest_bind_widgets' \
#     as'null' id-as'zinit/cleanup' lucid nocd wait \
#   $ZI_REPO/null
#

unset ZI_REPO ZI_REPO
# Powerlevel10k Theme.
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Source custom shell configurations and aliases
[[ -f /data/data/com.termux/files/home/.shell_rc ]] && source /data/data/com.termux/files/home/.shell_rc
[[ -f /data/data/com.termux/files/home/.aliases ]] && source /data/data/com.termux/files/home/.aliases

# Enable vi mode
bindkey -v
export KEYTIMEOUT=6000  # 60 seconds

# Powerlevel10k vi mode cursor
typeset -g POWERLEVEL9K_VI_MODE_NORMAL_CURSOR='\e[2 q'
typeset -g POWERLEVEL9K_VI_MODE_INSERT_CURSOR='\e[6 q'
typeset -g POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND=green
typeset -g POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND=red
typeset -g POWERLEVEL9K_VI_MODE_NORMAL_PROMPT_PREFIX='NORMAL '
typeset -g POWERLEVEL9K_VI_MODE_INSERT_PROMPT_PREFIX='INSERT '

# Enable searching through history
bindkey '^R' history-incremental-pattern-search-backward

# Edit line in nvim buffer ctrl-v
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line
# Enter vim buffer from normal mode
autoload -U edit-command-line && zle -N edit-command-line && bindkey -M vicmd "^v" edit-command-line

# Use nvim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-down-line-or-history
bindkey -M menuselect 'up' vi-up-line-or-history
bindkey -M menuselect 'right' vi-forward-char
# Fix backspace bug when switching modes
bindkey "^?" backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
