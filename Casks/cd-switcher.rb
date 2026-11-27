cask "cd-switcher" do
  version "0.3.0"
  sha256 "92b9f1fe900d79a4e07d5e21e5e9b68bfada26257ddc2d983b98ac7edd220128"

  url "https://github.com/lavluda/cd-switcher/releases/download/v#{version}/cd-switcher-darwin-universal.dmg"
  name "CD-Switcher"
  desc "Menu-bar app to switch Claude Desktop accounts"
  homepage "https://github.com/lavluda/cd-switcher"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "CD-Switcher.app"

  # The release is ad-hoc signed (no Developer ID). Homebrew marks the download
  # quarantined, which makes Gatekeeper report the app as damaged. Clear that
  # flag so the menu-bar app opens after install.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{staged_path}}/CD-Switcher.app"],
        must_succeed:   false,
        writable_paths: ["{{staged_path}}/CD-Switcher.app"]
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/CD-Switcher.app"],
        must_succeed:   false,
        writable_paths: ["{{appdir}}/CD-Switcher.app"]
  end

  uninstall quit: "com.lavluda.cd-switcher"

  zap trash: "~/Library/Application Support/cd-switcher"
end
