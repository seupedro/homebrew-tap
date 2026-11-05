#!/usr/bin/env bash
# Points Casks/dishylink.rb at the latest Dishylink release.
# The sha256 values are the digests GitHub computes for each release asset.
set -euo pipefail

repo=DaveyHert/Dishylink
cask=${1:-Casks/dishylink.rb}

tag=$(gh api "repos/$repo/releases/latest" --jq .tag_name)
new=${tag#v}
cur=$(sed -n 's/^  version "\(.*\)"$/\1/p' "$cask")

[[ $new =~ ^[0-9]+(\.[0-9]+)+$ ]] || { echo "unexpected tag: $tag" >&2; exit 1; }
[[ -n $cur ]] || { echo "no version line in $cask" >&2; exit 1; }
if [[ $new == "$cur" ]]; then echo "dishylink $cur is the latest"; exit 0; fi
if [[ $(printf '%s\n%s\n' "$cur" "$new" | sort -V | tail -1) != "$new" ]]; then
  echo "latest release $new is older than $cur, leaving the cask alone"; exit 0
fi

assets=$(gh api "repos/$repo/releases/tags/$tag" --jq '.assets[] | "\(.name) \(.digest)"')
digest() { awk -v n="Dishylink-$new-$1.dmg" '$1 == n { sub(/^sha256:/, "", $2); print $2 }' <<<"$assets"; }
arm=$(digest arm64)
intel=$(digest x64)
[[ $arm =~ ^[0-9a-f]{64}$ && $intel =~ ^[0-9a-f]{64}$ ]] || {
  echo "release $tag has no arm64/x64 .dmg digests yet" >&2; exit 1; }

sed -i.bak \
  -e "s/^  version \"$cur\"$/  version \"$new\"/" \
  -e "s/^  sha256 arm:   \"[0-9a-f]\{64\}\",$/  sha256 arm:   \"$arm\",/" \
  -e "s/^         intel: \"[0-9a-f]\{64\}\"$/         intel: \"$intel\"/" \
  "$cask"
rm "$cask.bak"

grep -q "version \"$new\"" "$cask" && grep -q "$arm" "$cask" && grep -q "$intel" "$cask" || {
  echo "could not rewrite $cask" >&2; exit 1; }
echo "dishylink $cur -> $new"
