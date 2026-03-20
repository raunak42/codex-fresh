#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_BIN_DIR="${INSTALL_BIN_DIR:-$HOME/.local/bin}"
INSTALL_HOOK_DIR="${INSTALL_HOOK_DIR:-$HOME/.config/codex-fresh}"
HOOK_TARGET="${HOOK_TARGET:-$HOME/.bashrc}"
INSTALL_HOOK="${INSTALL_HOOK:-1}"

mkdir -p "$INSTALL_BIN_DIR" "$INSTALL_HOOK_DIR"
install -m 0755 "$REPO_DIR/bin/codex-fresh" "$INSTALL_BIN_DIR/codex-fresh"

echo "Installed codex-fresh to $INSTALL_BIN_DIR/codex-fresh"

if [[ "$INSTALL_HOOK" != "0" ]]; then
  cp "$REPO_DIR/shell/codex-fresh.sh" "$INSTALL_HOOK_DIR/init.sh"
  source_line="source \"$INSTALL_HOOK_DIR/init.sh\""
  touch "$HOOK_TARGET"
  if ! grep -qxF "$source_line" "$HOOK_TARGET"; then
    printf '\n%s\n' "$source_line" >> "$HOOK_TARGET"
    echo "Added codex fresh shell hook to $HOOK_TARGET"
  else
    echo "Shell hook already present in $HOOK_TARGET"
  fi
fi

cat <<EOF

Next steps:
  1. Ensure $INSTALL_BIN_DIR is on your PATH.
  2. Open a new shell, or run: source "$HOOK_TARGET"
  3. Use either:
       codex-fresh
       codex fresh
EOF
