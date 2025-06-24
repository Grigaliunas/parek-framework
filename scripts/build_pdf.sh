#!/usr/bin/env bash
#-------------------------------------------------------------------------------
# scripts/build-pdf.sh — compile the entire PAREK Handbook into a single PDF
#
# Prerequisites:
#   • Pandoc ≥ 3.0   • pandoc-crossref   • LaTeX engine (xelatex / lualatex)
#   • Directory structure exactly as per README.md (front‑matter/, part1/, …)
#
# Usage:
#   $ chmod +x ./scripts/build-pdf.sh
#   $ ./scripts/build-pdf.sh          # writes output/parek-handbook.pdf
#   $ ./scripts/build-pdf.sh draft    # writes output/parek-handbook-draft.pdf
#-------------------------------------------------------------------------------
set -euo pipefail

GREEN="\033[0;32m"; BOLD="\033[1m"; NC="\033[0m"
msg() { echo -e "${GREEN}${BOLD}[pdf]${NC} $1"; }

#------------------------------------------------
# 1. Variables
#------------------------------------------------
OUT_DIR="output"
DEFAULT_NAME="parek-handbook"
SUFFIX="${1:-}"                # optional arg appended to filename
OUT_FILE="${DEFAULT_NAME}${SUFFIX:+-${SUFFIX}}.pdf"
TARGET="${OUT_DIR}/${OUT_FILE}"
TMP_LIST="$(mktemp)"

#------------------------------------------------
# 2. Build ordered chapter list according to numeric prefixes
#------------------------------------------------
msg "Generating ordered chapter list…"
{
  find front-matter -type f -name "*.md"
  find part1        -type f -name "*.md"
  find part2        -type f -name "*.md"
  find part3        -type f -name "*.md"
} | sort -V > "$TMP_LIST"

if [[ ! -s "$TMP_LIST" ]]; then
  echo "No source files found. Check directory structure." >&2; exit 1
fi

#------------------------------------------------
# 3. Ensure output directory exists
#------------------------------------------------
mkdir -p "$OUT_DIR"

#------------------------------------------------
# 4. Run Pandoc
#------------------------------------------------
msg "Building PDF → ${TARGET}"
pandoc \
  --from markdown+yaml_metadata_block+smart \
  --pdf-engine=xelatex \
  --toc --toc-depth=2 \
  -N                             # number sections
  --filter pandoc-crossref \
  --metadata lang=en \
  --metadata title="PAREK Framework – EU Post‑Quantum Cryptography Transition Handbook" \
  --metadata date="$(date +%Y-%m-%d)" \
  --include-in-header=assets/pandoc/header.tex \
  --include-after-body=assets/pandoc/after-body.tex \
  -o "$TARGET" \
  $(cat "$TMP_LIST")

msg "✅ PDF generated at $TARGET"
rm "$TMP_LIST"
