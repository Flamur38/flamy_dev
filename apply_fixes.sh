#!/usr/bin/env bash
# Run this from the root of your local flamy_dev clone, with
# text_changes.patch, .gitignore, LICENSE, and README.md
# (downloaded alongside this script) all in the same directory.
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ ! -f "run" || ! -f "resources/setup" ]]; then
    echo "Run this from the root of your flamy_dev clone." >&2
    exit 1
fi

# Only patch run/resources/setup if they haven't been patched already
# (safe to re-run the script if something failed partway through).
if git apply --check "$SCRIPT_DIR/text_changes.patch" 2>/dev/null; then
    echo "[1/5] Applying text fixes to run + resources/setup..."
    git apply "$SCRIPT_DIR/text_changes.patch"
else
    echo "[1/5] Text fixes already applied, skipping."
fi

echo "[2/5] Removing stray .zshrc.bak..."
git rm -q --cached env/.zshrc.bak 2>/dev/null || true
rm -f env/.zshrc.bak

echo "[3/5] Removing redundant vendored Chainsaw binaries..."
CHAINSAW_BINS=(
  env/tools/chainsaw/chainsaw
  env/tools/chainsaw/chainsaw_aarch64-apple-darwin
  env/tools/chainsaw/chainsaw_aarch64-unknown-linux-gnu
  env/tools/chainsaw/chainsaw_x86_64-apple-darwin
  env/tools/chainsaw/chainsaw_x86_64-pc-windows-msvc.exe
  env/tools/chainsaw/chainsaw_x86_64-unknown-linux-gnu
)
git rm -q --cached "${CHAINSAW_BINS[@]}" 2>/dev/null || true
rm -f "${CHAINSAW_BINS[@]}"

echo "[4/5] Adding .gitignore, LICENSE, and refreshed README.md..."
for f in .gitignore LICENSE README.md; do
    src="$SCRIPT_DIR/$f"
    dst="$(pwd)/$f"
    if [[ "$src" -ef "$dst" ]] 2>/dev/null; then
        echo "  $f already in place, skipping copy."
    else
        cp "$src" "$f"
    fi
done

echo "[5/5] Staging everything..."
git add -A
git status --short

echo
echo "Review the staged changes above, then:"
echo "  git commit -m 'Fix bootstrap URL, drop dead debug line, exact-match run filter, strip redundant/stray files'"
echo "  git push"
echo
echo "Note: env/Pictures wallpapers (~82MB) are still tracked in git history."
echo "That wasn't touched here since it needs a decision on where wallpapers"
echo "should live instead (git-lfs, separate repo, release asset, etc)."
