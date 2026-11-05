cask "dishylink" do
  arch arm: "arm64", intel: "x64"

  version "1.3.1"
  sha256 arm:   "cbc1a2d102ade511e92ca3d1abc75ac77cc2dc443dbf0b4a4dbfb77d3a3817cf",
         intel: "4346d83f04e1625226624fd661ee11d3d2a8064340049ecaa98d0dd3bed0c0bf"

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
