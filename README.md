# seupedro/tap

Homebrew tap for [Mac Netwatcher](https://github.com/seupedro/mac-netwatcher),
a tiny macOS menu bar app that shows if your internet is up and logs every
outage.

```sh
brew install --cask seupedro/tap/mac-netwatcher
```

Mac Netwatcher is ad-hoc signed but not notarized by Apple, so the cask
removes the quarantine flag after installing; otherwise macOS would block the
first launch.

`brew uninstall --cask mac-netwatcher` removes the app. Add `--zap` to also
delete its data (`~/.netwatch`) and log.

The cask used to be called `netwatch`; `cask_renames.json` points the old
name to the new one.
