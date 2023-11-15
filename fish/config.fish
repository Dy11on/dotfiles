alias nvw="nvim ~/vimwiki/index.md"

alias ll="exa -l -g --icons"
alias cls="clear"
starship init fish | source
alias game="tmux -u attach-session -t game"
alias checketh="sudo dmesg | grep r8169"
alias scrivener="wine ~/.wine/drive_c/Program Files/Scrivener3/Scrivener.exe"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/jimmy/gcpStuff/google-cloud-sdk/path.fish.inc' ]; . '/home/jimmy/gcpStuff/google-cloud-sdk/path.fish.inc'; end
fish_add_path /home/jimmy/.spicetify
