#!/bin/sh
# Notify IndexNow (Bing, Yandex, etc.) about changed URLs.
# Usage: _tools/indexnow.sh https://noncow.com/page1 https://noncow.com/page2 ...
#        _tools/indexnow.sh --all     (every URL in sitemap.xml)
set -e
cd "$(dirname "$0")/.."
KEY=$(basename "$(ls [0-9a-f]*.txt | head -1)" .txt)
if [ "$1" = "--all" ]; then
  set -- $(grep -o '<loc>[^<]*' sitemap.xml | sed 's/<loc>//')
fi
[ $# -gt 0 ] || { echo "No URLs given" >&2; exit 1; }
URLS=$(printf '"%s",' "$@" | sed 's/,$//')
curl -s -o /dev/null -w "IndexNow: HTTP %{http_code} for $# URL(s)\n" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d "{\"host\":\"noncow.com\",\"key\":\"$KEY\",\"keyLocation\":\"https://noncow.com/$KEY.txt\",\"urlList\":[$URLS]}" \
  https://api.indexnow.org/indexnow
