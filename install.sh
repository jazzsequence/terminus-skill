#!/usr/bin/env bash
# install.sh — Terminus Claude Code skill installer/updater
#
# Usage:
#   ./install.sh              Install or update the skill
#   ./install.sh --symlink    Symlink instead of copy (auto-updates with git pull)
#   ./install.sh --uninstall  Remove the installed skill
#   ./install.sh --force      Skip confirmation prompts
#
# One-liner (once repo is published):
#   bash <(curl -fsSL https://raw.githubusercontent.com/jazzsequence/terminus-skill/main/install.sh)

set -euo pipefail

SKILL_NAME="terminus"
SKILLS_DIR="${HOME}/.claude/skills"
INSTALL_DIR="${SKILLS_DIR}/${SKILL_NAME}"
REPO_URL="https://github.com/jazzsequence/terminus-skill"

# Colors (only when stdout is a terminal)
if [[ -t 1 ]]; then
  BOLD="\033[1m"
  GREEN="\033[0;32m"
  YELLOW="\033[0;33m"
  RED="\033[0;31m"
  RESET="\033[0m"
else
  BOLD="" GREEN="" YELLOW="" RED="" RESET=""
fi

log()    { echo -e "${BOLD}${1}${RESET}"; }
ok()     { echo -e "${GREEN}✓${RESET} ${1}"; }
warn()   { echo -e "${YELLOW}!${RESET} ${1}"; }
die()    { echo -e "${RED}✗${RESET} ${1}" >&2; exit 1; }

# Parse arguments
SYMLINK=false
UNINSTALL=false
FORCE=false

for arg in "$@"; do
  case "$arg" in
    --symlink)   SYMLINK=true ;;
    --uninstall) UNINSTALL=true ;;
    --force|-f)  FORCE=true ;;
    --help|-h)
      echo "Usage: $0 [--symlink] [--uninstall] [--force]"
      echo ""
      echo "  --symlink    Symlink the skill directory instead of copying (useful for local dev)"
      echo "  --uninstall  Remove the installed skill"
      echo "  --force      Skip confirmation prompts"
      exit 0
      ;;
    *) die "Unknown option: $arg. Run '$0 --help' for usage." ;;
  esac
done

# Determine source directory
# When run via curl | bash, __SOURCE_DIR is the temp clone location.
# When run locally, it's the directory containing this script.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="${__SOURCE_DIR:-$SCRIPT_DIR}"

# ── Uninstall ────────────────────────────────────────────────────────────────

if [[ "$UNINSTALL" == true ]]; then
  if [[ ! -e "$INSTALL_DIR" ]]; then
    warn "Skill not found at ${INSTALL_DIR} — nothing to remove."
    exit 0
  fi
  if [[ "$FORCE" != true ]]; then
    read -rp "Remove terminus skill from ${INSTALL_DIR}? [y/N] " confirm
    [[ "$confirm" =~ ^[Yy]$ ]] || { echo "Aborted."; exit 0; }
  fi
  rm -rf "$INSTALL_DIR"
  ok "Terminus skill removed from ${INSTALL_DIR}"
  exit 0
fi

# ── Remote install (curl | bash) ─────────────────────────────────────────────
# When sourced remotely, SOURCE_DIR equals SCRIPT_DIR which is a temp dir
# with no skill files — detect this and clone instead.

is_remote_install() {
  # If SKILL.md doesn't exist next to the script, we're running remotely
  [[ ! -f "${SOURCE_DIR}/SKILL.md" ]]
}

if is_remote_install; then
  if ! command -v git &>/dev/null; then
    die "git is required but not found. Install git and retry."
  fi

  CLONE_DIR="$(mktemp -d)"
  trap 'rm -rf "$CLONE_DIR"' EXIT

  log "Cloning terminus-skill from ${REPO_URL}…"
  git clone --depth=1 "$REPO_URL" "$CLONE_DIR" 2>&1 | sed 's/^/  /'
  SOURCE_DIR="$CLONE_DIR"
fi

# ── Pre-flight checks ─────────────────────────────────────────────────────────

[[ -f "${SOURCE_DIR}/SKILL.md" ]] || die "SKILL.md not found in ${SOURCE_DIR} — source directory looks wrong."

mkdir -p "$SKILLS_DIR"

# ── Update check (already installed as a git clone) ──────────────────────────

if [[ -d "${INSTALL_DIR}/.git" ]] && [[ "$SYMLINK" != true ]]; then
  log "Existing git-managed install found — updating…"
  git -C "$INSTALL_DIR" pull --rebase --autostash 2>&1 | sed 's/^/  /'
  ok "Terminus skill updated at ${INSTALL_DIR}"
  echo ""
  echo "  Skill location: ${INSTALL_DIR}"
  echo "  Invoke in Claude Code with: /terminus"
  exit 0
fi

# ── Install ───────────────────────────────────────────────────────────────────

if [[ -e "$INSTALL_DIR" ]]; then
  if [[ "$FORCE" != true ]]; then
    warn "Skill already exists at ${INSTALL_DIR}"
    read -rp "Overwrite? [y/N] " confirm
    [[ "$confirm" =~ ^[Yy]$ ]] || { echo "Aborted."; exit 0; }
  fi
  rm -rf "$INSTALL_DIR"
fi

if [[ "$SYMLINK" == true ]]; then
  ln -s "$SOURCE_DIR" "$INSTALL_DIR"
  ok "Symlinked: ${INSTALL_DIR} → ${SOURCE_DIR}"
  echo ""
  warn "Updates: run 'git pull' in ${SOURCE_DIR}"
else
  # If we cloned from git, clone directly into the install location for future updates
  if [[ -d "${SOURCE_DIR}/.git" ]]; then
    REMOTE_URL="$(git -C "$SOURCE_DIR" remote get-url origin 2>/dev/null || true)"
    if [[ -n "$REMOTE_URL" ]]; then
      log "Installing as git clone for easy future updates…"
      git clone --depth=1 "$REMOTE_URL" "$INSTALL_DIR" 2>&1 | sed 's/^/  /'
      ok "Installed at ${INSTALL_DIR} (git-managed)"
      echo ""
      warn "To update later, re-run this installer or: git -C ${INSTALL_DIR} pull"
    else
      # Local repo with no remote — just copy
      cp -r "$SOURCE_DIR" "$INSTALL_DIR"
      ok "Copied to ${INSTALL_DIR}"
      echo ""
      warn "No git remote configured — updates require manually re-running the installer."
    fi
  else
    cp -r "$SOURCE_DIR" "$INSTALL_DIR"
    ok "Copied to ${INSTALL_DIR}"
  fi
fi

echo ""
log "Terminus skill installed successfully."
echo ""
echo "  Skill location: ${INSTALL_DIR}"
echo "  Invoke in Claude Code with: /terminus"
echo ""
echo "  Requirements: Terminus 4.x (brew install terminus), PHP 8.2+, Pantheon machine token"
