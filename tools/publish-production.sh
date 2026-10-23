#!/usr/bin/env bash
# Publishes the scanner to the production installation's site (ceibos-asproe/ceibos-portero, GitHub Pages)
# with the school generator's public key. The gmail site (cvanrell/ceibos-portero, remote "portero")
# keeps its own publish (git subtree split) and its own key in config.js.
# Usage, from the repo root: weekend-pass/scanner/tools/publish-production.sh
set -euo pipefail
SCHOOL_KEY='K4wOF_gqDk65lsSuyXNIdE6WFXFOLa4DSqk5ZhiOLhs'
SCHOOL_CANCEL_API='https://script.google.com/macros/s/AKfycbzl4RXFvqAbgVVWYZ74GvGxzakCUtzi82OAbYBpiBxqHRPTAa9H-GfvEn1z_j0mHCC-Wg/exec'
REMOTE='https://github.com/ceibos-asproe/ceibos-portero.git'
root=$(git rev-parse --show-toplevel)
tmp=$(mktemp -d)
git -C "$root" archive HEAD weekend-pass/scanner | tar -x -C "$tmp"
cd "$tmp/weekend-pass/scanner"
grep -q "^export const PUBLIC_KEY = '" config.js
sed -i.bak "s/^export const PUBLIC_KEY = '[^']*'/export const PUBLIC_KEY = '$SCHOOL_KEY'/" config.js && rm config.js.bak
grep -q "$SCHOOL_KEY" config.js
# The cancellation page (cancelar/) calls production's sheet project web app (calendar-export/cancel.gs).
grep -q "^export const CANCEL_API = '" config.js
sed -i.bak "s#^export const CANCEL_API = '[^']*'#export const CANCEL_API = '$SCHOOL_CANCEL_API'#" config.js && rm config.js.bak
grep -q "$SCHOOL_CANCEL_API" config.js
git init -q -b main && git add -A
git -c user.name="Carlos Vanrell" -c user.email="carlos.vanrell@gmail.com" commit -qm "Scanner (production installation) from ceibos $(git -C "$root" rev-parse --short HEAD)"
# Personal account only (never the machine's default GitHub login): same helper as the project's .git/config.
git -c credential.helper= \
  -c 'credential.https://github.com.helper=!f() { test "$1" = get || exit 0; echo username=cvanrell; echo "password=$(gh auth token --hostname github.com --user cvanrell)"; }; f' \
  push -qf "$REMOTE" main
echo "Published to $REMOTE"
