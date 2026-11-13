cask "ai-usage" do
  version "1.1.0"
  sha256 "fd18686871f88276ccd9e2fc03816ee04e2ef9ba13b238b3f0ae8841a2e34d12"

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
