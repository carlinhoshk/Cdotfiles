export ZDOTDIR="$HOME/.config/zsh"

# Carrega .zshenv, se existir
[ -f "$ZDOTDIR/.zshenv" ] && source "$ZDOTDIR/.zshenv"

# Carrega arquivos de configuração em conf.d
if [ -d "$ZDOTDIR/conf.d" ]; then
    for file in "$ZDOTDIR/conf.d"/*.zsh; do
        [ -r "$file" ] && source "$file"
    done
fi

# Carrega funções
if [ -d "$ZDOTDIR/functions" ]; then
    for file in "$ZDOTDIR/functions"/*.zsh; do
        [ -r "$file" ] && source "$file"
    done
fi

# Carrega completions
if [ -d "$ZDOTDIR/completions" ]; then
    for file in "$ZDOTDIR/completions"/*.zsh; do
        [ -r "$file" ] && source "$file"
    done
fi

# Carrega user.zsh
[ -f "$ZDOTDIR/user.zsh" ] && source "$ZDOTDIR/user.zsh"
