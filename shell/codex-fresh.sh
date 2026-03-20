codex() {
  if [[ $# -gt 0 && "$1" == "fresh" ]]; then
    shift
    command codex-fresh "$@"
    return $?
  fi

  command codex "$@"
}
