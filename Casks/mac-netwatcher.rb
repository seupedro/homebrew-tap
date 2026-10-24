cask "mac-netwatcher" do
  version "1.1.0"
  sha256 "6a6dabbf64e61cc8e728f5b6fa957c6479e0a2a8a02e1115784b16d222ef9fc2"

  url "https://github.com/seupedro/mac-netwatcher/releases/download/v#{version}/mac-netwatcher-#{version}.zip"
  name "Mac Netwatcher"
  desc "Menu bar app that shows if the internet is up and logs every outage"
  homepage "https://github.com/seupedro/mac-netwatcher"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Mac Netwatcher.app"

  # The app is ad-hoc signed, not notarized: without this, Gatekeeper blocks
  # the first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Mac Netwatcher.app"]
  end

  uninstall quit: "xyz.paralaxe.netwatch"

  zap trash: [
    "~/.netwatch",
    "~/Library/Logs/Netwatch.log",
  ]

  caveats <<~EOS
    To start Mac Netwatcher at login, add it in
      System Settings → General → Login Items
  EOS
end
