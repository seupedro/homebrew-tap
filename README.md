# seupedro/tap

Homebrew tap for [Netwatch](https://github.com/seupedro/netwatch), a tiny
macOS menu bar app that shows if your internet is up and logs every outage.

```sh
brew install --cask seupedro/tap/netwatch
```

Netwatch is ad-hoc signed but not notarized by Apple, so the cask removes the
quarantine flag after installing; otherwise macOS would block the first launch.

`brew uninstall --cask netwatch` removes the app. Add `--zap` to also delete
its data (`~/.netwatch`) and log.
