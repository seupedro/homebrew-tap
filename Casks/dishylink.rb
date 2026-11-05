cask "dishylink" do
  arch arm: "arm64", intel: "x64"

  version "1.3.0"
  sha256 arm:   "0d6bc8610b346fe269b88a0c46dd2c194857e6797c30f952a2318b7258c36531",
         intel: "706b8e302179ad11f57f04bcd32a721a6da4e9ac4485ce6de62007e254670326"

  url "https://github.com/DaveyHert/Dishylink/releases/download/v#{version}/Dishylink-#{version}-#{arch}.dmg"
  name "Dishylink"
  desc "Monitor the performance and health of a Starlink dish"
  homepage "https://github.com/DaveyHert/Dishylink"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "Dishylink.app"

  # The app is ad-hoc signed, not notarized: without this, Gatekeeper blocks
  # the first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Dishylink.app"]
  end

  uninstall quit: "com.dishylink.app"

  zap trash: [
    "~/Library/Application Support/Dishylink",
    "~/Library/Preferences/com.dishylink.app.plist",
    "~/Library/Saved Application State/com.dishylink.app.savedState",
  ]
end
