cask "ai-usage" do
  version "1.0.0"
  sha256 "3c25a1e3b8c6882861b04325aa53dcd64851375c16055710d6333879ae7acfd4"

  url "https://github.com/marcusviniciusf/ai-usage-bar/releases/download/v#{version}/AIUsage-#{version}-macos-universal.zip",
      verified: "github.com/marcusviniciusf/ai-usage-bar/"
  name "AI Usage"
  desc "Menu bar app for AI coding spend and subscription quota"
  homepage "https://github.com/marcusviniciusf/ai-usage-bar"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

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
