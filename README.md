# seupedro/tap

Homebrew casks for a couple of macOS apps.

```sh
brew install --cask seupedro/tap/mac-netwatcher
brew install --cask seupedro/tap/dishylink
```

Update them like anything else from Homebrew:

```sh
brew update && brew upgrade
```

## Mac Netwatcher

[Mac Netwatcher](https://github.com/seupedro/mac-netwatcher) is a tiny macOS
menu bar app that shows if your internet is up and logs every outage.

`brew uninstall --cask mac-netwatcher` removes the app. Add `--zap` to also
delete its data (`~/.netwatch`) and log.

The cask used to be called `netwatch`; `cask_renames.json` points the old
name to the new one.

## Dishylink

[Dishylink](https://github.com/DaveyHert/Dishylink) is an open-source desktop
app to monitor a Starlink dish, by Davey Hert. This tap only packages the
official release `.dmg` files (Apple Silicon and Intel); it isn't affiliated
with the project.

A scheduled GitHub Action
([`bump-dishylink.yml`](.github/workflows/bump-dishylink.yml)) checks for a new
Dishylink release every 6 hours and updates the version and checksums in the
cask, so `brew upgrade` picks it up without waiting for anyone.

`brew uninstall --cask dishylink --zap` also deletes its settings and history
in `~/Library/Application Support/Dishylink`.

## Unsigned apps

Neither app is notarized by Apple (both are ad-hoc signed), so each cask
removes the quarantine flag after installing; otherwise macOS would block the
first launch.
