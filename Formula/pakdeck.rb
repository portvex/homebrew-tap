# Homebrew formula for portvex/homebrew-tap (Formula/pakdeck.rb), generated
# from packaging/homebrew/pakdeck.rb.in in the pakdeck repository: its
# scripts/homebrew.sh fills in the version and the archives' SHA-256s, and the
# release workflow attaches the result to each stable release from v0.1.2 on
# as pakdeck.rb. Installs the prebuilt macOS binary, so no Rust toolchain is
# needed.
class Pakdeck < Formula
  desc "Terminal UI for your package managers"
  homepage "https://github.com/portvex/pakdeck"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/portvex/pakdeck/releases/download/v0.1.1/pakdeck-v0.1.1-aarch64-apple-darwin.tar.gz"
    sha256 "6c33bf5d9119ca7213d9f8560ed618bed81d613fbceabf40cde0b5ca66bf0e76"
  else
    url "https://github.com/portvex/pakdeck/releases/download/v0.1.1/pakdeck-v0.1.1-x86_64-apple-darwin.tar.gz"
    sha256 "e8d2664d8c8947dae5fd598e6657942ab30a501175619990c12f1f1f4a25d076"
  end

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on :macos

  def install
    bin.install "pakdeck"
  end

  test do
    assert_match "pakdeck #{version}", shell_output("#{bin}/pakdeck --version")
  end
end
