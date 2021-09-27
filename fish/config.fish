alias vim="lvim"


alias  ls="exa --all"
alias be="bundle exec"
alias top="btm -g --hide_time --hide_table_gap"
alias nnn="nnn -ex"
alias icat="kitty +kitten icat"

set -gx BAT_THEME "Dracula"
set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git"

# status --is-interactive; and source (rbenv init -|psub)

fnm env | source
# navi widget fish | source
zoxide init fish | source


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# eval /usr/local/Caskroom/miniforge/base/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

starship init fish | source

