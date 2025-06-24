#!/usr/bin/env bash
#-------------------------------------------------------------------------------
# scripts/setup.sh — bootstrap Pandoc tool‑chain and filters for the PAREK
#                     Framework handbook build (PDF & HTML).
#
# Usage:
#   $ chmod +x ./scripts/setup.sh
#   $ ./scripts/setup.sh
#-------------------------------------------------------------------------------
set -euo pipefail

GREEN="\033[0;32m"
NC="\033[0m"  # No Color
BOLD="\033[1m"

msg() {
  echo -e "${GREEN}${BOLD}[setup]${NC} $1"
}

#------------------------------------------------
# 1. Detect package manager
#------------------------------------------------
if command -v apt-get >/dev/null 2>&1; then
  PM="apt"
elif command -v dnf >/dev/null 2>&1; then
  PM="dnf"
elif command -v brew >/dev/null 2>&1; then
  PM="brew"
elif command -v pacman >/dev/null 2>&1; then
  PM="pacman"
else
  echo "Unsupported package manager. Please install Pandoc manually." >&2
  exit 1
fi

msg "Using package manager: $PM"

#------------------------------------------------
# 2. Install system packages
#------------------------------------------------
case "$PM" in
  apt)
    sudo apt-get update
    sudo apt-get install -y pandoc texlive texlive-latex-extra python3-pip
    ;;
  dnf)
    sudo dnf install -y pandoc texlive-scheme-medium python3-pip
    ;;
  brew)
    brew update
    brew install pandoc texlive
    ;;
  pacman)
    sudo pacman -Sy --needed pandoc texlive-most python-pip
    ;;
esac

#------------------------------------------------
# 3. Install Python‑based filters & MkDocs
#------------------------------------------------
msg "Installing Python packages (pandoc‑filters, mkdocs, mkdocs‑material)"
python3 -m pip install --upgrade pip
python3 -m pip install pandocfilters pandoc-crossref mkdocs mkdocs-material

#------------------------------------------------
# 4. Verify installation
#------------------------------------------------
msg "Verifying installations"
pandoc --version | head -n 1
if command -v pandoc-crossref >/dev/null 2>&1; then
  pandoc-crossref --version | head -n 1
fi
mkdocs --version

#------------------------------------------------
msg "All dependencies installed successfully!"
