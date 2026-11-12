# Homebrew cask for portvex/homebrew-tap (Casks/bxplore.rb). The release
# workflow fills in the version and the DMG's SHA-256 and attaches the result
# to the release as bxplore.rb.
cask "bxplore" do
  version "0.1.1"
  sha256 "a3deeb02b92a6d582747affb716cc994a8f959666d8de628581f127968b1dbf4"

  url "https://github.com/portvex/bxplore/releases/download/v#{version}/bxplore-#{version}-macos-universal.dmg"
  name "bxplore"
  desc "Viewer and editor for PE, ELF and Mach-O files"
  homepage "https://github.com/portvex/bxplore"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "bxplore.app"
  binary "#{appdir}/bxplore.app/Contents/MacOS/bxplore"

  zap trash: [
    "~/Library/Application Support/bxplore",
    "~/Library/Services/Open with bxplore.workflow",
  ]

  caveats <<~EOS
    bxplore is signed ad hoc but not notarized by Apple, so macOS blocks both the
    app and the `bxplore` command until you allow it once: open bxplore.app with
    right click, Open (or allow it in System Settings, Privacy & Security), or run
      xattr -dr com.apple.quarantine "#{appdir}/bxplore.app"
  EOS
end
