#!/usr/bin/env bash
# Scan the repository for personal data before pushing.
# Usage: scripts/check-privacy.sh [extra-term ...]
#   extra-term: words that must not appear (your name, school, lab, username, ...)
set -u
cd "$(dirname "$0")/.."

fail=0
check() {
  local label="$1" pattern="$2"
  local hits
  hits=$(grep -rnIE --exclude-dir=.git --exclude=check-privacy.sh -e "$pattern" . || true)
  if [ -n "$hits" ]; then
    echo "[FAIL] $label"
    echo "$hits" | sed 's/^/    /'
    fail=1
  else
    echo "[ok]   $label"
  fi
}

check "email addresses"            '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}'
check "Notion URLs"                '(notion\.so|notion\.site|app\.notion\.com)/'
check "Notion / UUID-like IDs"     '[0-9a-f]{32}|[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}'
check "collection:// IDs"          'collection://[0-9a-f-]{8,}'
check "local paths"                '(/Users/|/home/[a-z]|C:\\Users\\|/mnt/user-data|/root/)'
check "tokens / secrets"           '(secret_[A-Za-z0-9]{20,}|ntn_[A-Za-z0-9]{20,}|ghp_[A-Za-z0-9]{20,}|sk-[A-Za-z0-9]{20,})'

for term in "$@"; do
  check "custom term: $term" "$term"
done

# Placeholders that must be replaced before publishing (warning only)
ph=$(grep -rnI --exclude-dir=.git --exclude=check-privacy.sh -e 'YOUR_NAME' -e 'YOUR_GITHUB_USERNAME' . || true)
if [ -n "$ph" ]; then
  echo "[warn] placeholders still present (replace YOUR_GITHUB_USERNAME; YOUR_NAME may stay or become a handle):"
  echo "$ph" | sed 's/^/    /'
fi

if [ $fail -ne 0 ]; then
  echo; echo "Personal data found. Fix the lines above before pushing."; exit 1
fi
echo; echo "No personal data found."
