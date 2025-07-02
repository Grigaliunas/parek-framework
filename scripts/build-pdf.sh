#!/usr/bin/env bash
#-------------------------------------------------------------------------------
# build-pdf.sh — compile PAREK Handbook to PDF or LaTeX
#
# Usage:
#   ./build-pdf.sh                → builds output/parek-handbook.pdf
#   ./build-pdf.sh tex            → builds .tex instead of PDF
#   ./build-pdf.sh draft tex      → builds output/parek-handbook-draft.tex
#-------------------------------------------------------------------------------

set -euo pipefail

# 0. Detect shell
if [[ -n "${ZSH_VERSION:-}" ]]; then echo "[info] Running under ZSH"
elif [[ -n "${BASH_VERSION:-}" ]]; then echo "[info] Running under BASH"
else echo "[warn] Unknown shell"; fi

# 1. Setup
GREEN="\033[0;32m"; BOLD="\033[1m"; NC="\033[0m"
msg() { echo -e "${GREEN}${BOLD}[pdf]${NC} $1"; }

OUT_DIR="output"
DEFAULT_NAME="parek-handbook"

# Handle args
SUFFIX=""
BUILD_TEX="false"
for arg in "$@"; do
  if [[ "$arg" == "tex" ]]; then BUILD_TEX="true"
  else SUFFIX="${arg}"; fi
done

EXT="$([[ "$BUILD_TEX" == "true" ]] && echo "tex" || echo "pdf")"
EXT_UPPER=$(echo "$EXT" | tr '[:lower:]' '[:upper:]')
OUT_FILE="${DEFAULT_NAME}${SUFFIX:+-${SUFFIX}}.${EXT}"
TARGET="${OUT_DIR}/${OUT_FILE}"
TMP_LIST="$(mktemp)"
trap 'rm -f "$TMP_LIST"' EXIT

# 2. Tool check
for cmd in pandoc pandoc-crossref; do
  command -v "$cmd" >/dev/null || { echo "[error] Missing: $cmd"; exit 1; }
done

[[ "$BUILD_TEX" == "true" ]] || command -v xelatex >/dev/null || {
  echo "[error] Missing: xelatex for PDF build"; exit 1; }

# 3. Gather sources
msg "Generating ordered chapter list…"
{
  find front-matter -type f -name "*.md"
  find part1        -type f -name "*.md"
  find part2        -type f -name "*.md"
  find part3        -type f -name "*.md"
} | sort -V > "$TMP_LIST"

[[ -s "$TMP_LIST" ]] || { echo "[error] No chapters found."; exit 1; }

# 4. Output dir
mkdir -p "$OUT_DIR"

# 5. Pandoc includes
HEADER="assets/pandoc/header.tex"
AFTER="assets/pandoc/after-body.tex"
INCLUDE_ARGS=()
[[ -f "$HEADER" ]] && INCLUDE_ARGS+=(--include-in-header="$HEADER")
[[ -f "$AFTER"  ]] && INCLUDE_ARGS+=(--include-after-body="$AFTER")

# 6. Run Pandoc
msg "Building $(echo "$EXT" | tr '[:lower:]' '[:upper:]') → ${TARGET}"

pandoc \
  --from markdown+yaml_metadata_block+smart \
  "${INCLUDE_ARGS[@]}" \
  --metadata lang=en \
  --metadata title="PAREK Framework – EU Post‑Quantum Cryptography Transition Handbook" \
  --metadata date="$(date +%Y-%m-%d)" \
  --toc --toc-depth=2 \
  -N \
  --filter pandoc-crossref \
  $( [[ "$BUILD_TEX" != "true" ]] && echo "--pdf-engine=xelatex" ) \
  -o "$TARGET" \
  $(<"$TMP_LIST")

msg "✅ $EXT_UPPER successfully generated: $TARGET"
    