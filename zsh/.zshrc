


# ==================================================
# 1. Variables de entorno
# ==================================================

# PostgreSQL (descomenta y configura si lo necesitas)
# export PGPASSWORD='your_password_here'
# export PGSSLMODE=require

# AI API Keys (descomenta y configura si las necesitas)
# export GEMINI_API_KEY="your_api_key_here"
# export GITHUB_TOKEN="your_token_here"

export TERM=xterm-kitty

# ==================================================
# 2. PATH (AQUÍ está la clave para opencode)
# ==================================================
export PATH="$HOME/.local/bin:$HOME/bin:$HOME/.dotnet/tools:$HOME/.spicetify:$HOME/.npm-global/bin:$HOME/.opencode/bin:/usr/local/bin:$PATH"

# ==================================================
# 3. Oh My Zsh
# ==================================================

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="af-magic"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# ==================================================
# 4. Configuración global del sistema
# ==================================================
if [ -f /etc/zshrc ]; then
    source /etc/zshrc
fi

# ==================================================
# 5. Configuración modular adicional
# ==================================================
if [ -d ~/.zshrc.d ]; then
    for rc in ~/.zshrc.d/*; do
        [ -f "$rc" ] && source "$rc"
    done
fi
unset rc

# ==================================================
# 6. Historial
# ==================================================
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt append_history
setopt share_history

# ==================================================
# 7. Autocompletado y corrección
# ==================================================
autoload -Uz compinit
compinit
setopt correct

# ==================================================
# 8. Aliases
# ==================================================
alias reloadzsh="source ~/.zshrc && echo '✅ .zshrc recargado'"
alias zthemes="ls $ZSH/themes | sed 's/\.zsh-theme//g'"
alias pam="$HOME/go/bin/pam"

