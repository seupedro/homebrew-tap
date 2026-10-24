cask "netwatch" do
  version "1.0.0"
  sha256 "fdbf4fa818b5a3ff796314aa4e68c111c197c27e42e060a3391e89f73aae5eac"

  url "https://github.com/seupedro/netwatch/releases/download/v#{version}/Netwatch-#{version}.zip"
  name "Netwatch"
  desc "Menu bar app that shows if the internet is up and logs every outage"
  homepage "https://github.com/seupedro/netwatch"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Netwatch.app"

  # The app is ad-hoc signed, not notarized: without this, Gatekeeper blocks
  # the first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Netwatch.app"]
  end

  uninstall quit: "xyz.paralaxe.netwatch"

  zap trash: [
    "~/.netwatch",
    "~/Library/Logs/Netwatch.log",
  ]

  caveats <<~EOS
    To start Netwatch at login, add it in
      System Settings → General → Login Items
  EOS
end
