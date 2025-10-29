# ~/.zprofile
# Auto-start tmux when opening Termux
if [ -z "$TMUX" ]; then
  if tmux has-session -t main 2>/dev/null; then
    exec tmux attach -t main
  else
    exec tmux new -s main
  fi
fi