#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://git.overleaf.com/1234567890abcdef"  # use your project’s Git URL
LOCAL_DIR="$HOME/OverleafProject"
OUTPUT_PDF="main.pdf"  # adjust your main tex file’s output
COMPILE_CMD="xelatex -interaction=nonstopmode main.tex"

# Step 1: Clone or pull
if [ ! -d "$LOCAL_DIR/.git" ]; then
  git clone "$REPO_URL" "$LOCAL_DIR"
else
  cd "$LOCAL_DIR"
  git pull
fi

cd "$LOCAL_DIR"

# Step 2: Check if working tree changed
if git diff --quiet HEAD@{1} HEAD; then
  echo "No new changes; skipping compile."
  exit 0
fi

# Step 3: Compile
echo "New changes detected — compiling with XeLaTeX"
$COMPILE_CMD
$COMPILE_CMD  # often run twice for references

# Step 4: Copy output somewhere
cp "$OUTPUT_PDF" "$HOME/Documents/OverleafOutput/"

echo "Compiled and copied output."
