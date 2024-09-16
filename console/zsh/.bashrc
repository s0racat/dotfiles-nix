if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi                         # added by Nix installer
if [ -e ~/.nix-profile/etc/profile.d/hm-session-vars.sh ]; then . ~/.nix-profile/etc/profile.d/hm-session-vars.sh; fi # added by Nix installer
if [ "$TERM_PROGRAM" = "vscode" ] || [ "$TERM_PROGRAM" = "WezTerm" ] && [ -z "$IN_NIX_SHELL" ]; then
    exec zsh
elif [ -z ${IN_NIX_SHELL} ] && [ -x "$(command -v tmux)" ]; then
    exec tmux new-session -A -s ${USER} >/dev/null 2>&1 || exec tmux attach
fi
