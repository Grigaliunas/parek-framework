#!/usr/bin/env bash
#-------------------------------------------------------------------------------
# scripts/setup.sh — bootstrap Pandoc tool‑chain and filters for PAREK
#
# Usage:
#   chmod +x ./scripts/setup.sh && ./scripts/setup.sh
#-------------------------------------------------------------------------------
set -euo pipefail

GREEN="\033[0;32m"
NC="\033[0m"
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
  echo "Unsupported package manager. Please install tools manually." >&2
  exit 1
fi

msg "Using package manager: $PM"

#------------------------------------------------
# 2. Install Pandoc & LaTeX tools
#------------------------------------------------
case "$PM" in
  apt)
    sudo apt-get update
    sudo apt-get install -y pandoc texlive texlive-latex-extra wget unzip
    ;;
  dnf)
    sudo dnf install -y pandoc texlive-scheme-medium wget unzip
    ;;
  brew)
    brew update
    brew install pandoc
    brew install --cask mactex-no-gui  # use mactex-no-gui to avoid full 4GB install
    ;;
  pacman)
    sudo pacman -Sy --needed pandoc texlive-most wget unzip
    ;;
esac

#------------------------------------------------
# 3. Install pandoc-crossref (platform-specific)
#------------------------------------------------
msg "Installing pandoc-crossref"

if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS via Homebrew
  if brew list pandoc-crossref &>/dev/null; then
    msg "pandoc-crossref already installed via Homebrew"
  else
    brew install pandoc-crossref
  fi

elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux – fallback to GitHub binary
  RELEASE_DATA=$(curl -s https://api.github.com/repos/lierdakil/pandoc-crossref/releases/latest)
  VERSION=$(echo "$RELEASE_DATA" | grep '"tag_name":' | cut -d '"' -f 4)
  URL=$(echo "$RELEASE_DATA" | grep "browser_download_url" | grep "linux" | cut -d '"' -f 4)

  if [[ -z "$URL" ]]; then
    echo "[error] Could not find Linux binary for pandoc-crossref"
    exit 1
  fi

  FILENAME=$(basename "$URL")
  msg "Downloading $FILENAME from $URL"

  TMP_DIR=$(mktemp -d)
  cd "$TMP_DIR"

  curl -LO "$URL"

  # Check file size
  if [[ ! -f "$FILENAME" ]] || [[ $(stat --format=%s "$FILENAME") -lt 100000 ]]; then
    echo "[error] File too small or invalid."
    cat "$FILENAME"
    exit 1
  fi

  chmod +x "$FILENAME"
  sudo mv "$FILENAME" /usr/local/bin/pandoc-crossref

  cd - >/dev/null
  rm -rf "$TMP_DIR"

else
  echo "[error] Unsupported OS for pandoc-crossref install"
  exit 1
fi

#------------------------------------------------
# 4. Install Python tools
#------------------------------------------------
msg "Installing Python packages (mkdocs, mkdocs-material)"
python3 -m pip install --upgrade pip
python3 -m pip install mkdocs mkdocs-material

#------------------------------------------------
# 5. Verify
#------------------------------------------------
msg "Verifying installations"
pandoc --version | head -n 1
pandoc-crossref --version | head -n 1
mkdocs --version

msg "✅ All dependencies installed successfully!"
