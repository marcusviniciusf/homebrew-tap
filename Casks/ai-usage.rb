cask "ai-usage" do
  version "1.2.0"
  sha256 "ffc9d94b294c4b11fee619aa7dea545da874091084241316478f1adb2fee55b1"

  url "https://github.com/marcusviniciusf/ai-usage-bar/releases/download/v#{version}/AIUsage-#{version}-macos-universal.zip"
  name "AI Usage"
  desc "Menu bar app for AI coding spend and subscription quota"
  homepage "https://github.com/marcusviniciusf/ai-usage-bar"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "AI Usage.app"

  # The app is ad-hoc signed (no paid Apple Developer ID), so macOS quarantines
  # and blocks it on first launch. Drop the flag for this app only.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/AI Usage.app"]
  end

  zap trash: [
    "~/Library/Caches/ai-usage.json",
    "~/Library/Caches/ai-usage-cursor-events.json",
    "~/.config/ai-usage",
  ]
end
