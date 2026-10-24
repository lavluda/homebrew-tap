cask "cd-switcher" do
  version "0.2.0"
  sha256 "ef684936cafaa6fda17c00e0db5b4b9e9004f834b6c3a8b9fdcb6f45e16b3bd3"

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
