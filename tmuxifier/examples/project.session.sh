# Example generic project config
#
# Usage: NAME=repo_name tmuxifier s project

project_name="$NAME"
project_root="$HOME/code/$project_name"
session_name="${project_name//./_}"
session_root "$project_root"

new_project_window() {
  window_root "$project_root"
  new_window "$1"
}

if initialize_session "$session_name"; then
  new_project_window "neovim"
  run_cmd "nvim"

  new_project_window "codex"
  run_cmd "codex"

  new_project_window "terminal"

  select_window 1
fi

finalize_and_go_to_session
