alias nvw="nvim ~/vimwiki/index.md"

alias ll="exa -l -g --icons"
starship init fish | source
alias game="tmux -u attach-session -t game"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/jimmy/google-cloud-sdk/path.fish.inc' ]; . '/home/jimmy/google-cloud-sdk/path.fish.inc'; end
