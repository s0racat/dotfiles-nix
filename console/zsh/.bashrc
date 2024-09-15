if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi                         # added by Nix installer
if [ -e ~/.nix-profile/etc/profile.d/hm-session-vars.sh ]; then . ~/.nix-profile/etc/profile.d/hm-session-vars.sh; fi # added by Nix installer
if [ "${TERM_PROGRAM}" == "vscode" ]; then
    exec zsh
elif [ -x "$(command -v tmux)" ] && [ -z "${TMUX}" ]; then
    exec tmux new-session -A -s ${USER} >/dev/null 2>&1
else
    exec tmux attach
fi
