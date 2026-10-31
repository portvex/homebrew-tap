# Template: `cargo xtask dist recipes` fills in the version and checksum
# (dist/packaging/homebrew/Formula/tuidesk.rb), laid out like a tap repository such as
# portvex/homebrew-tap.
class Tuidesk < Formula
  desc "KDE Plasma style desktop that runs inside a terminal"
  homepage "https://github.com/portvex/tuidesk"
  url "https://github.com/portvex/tuidesk/releases/download/v0.2.0/tuidesk-0.2.0.tar.gz"
  sha256 "2a64bd4526d4965d389177e4e94273bd37f7a935ac126c61c58c5a9b49d9d6c0"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    man1.install "man/tuidesk.1"
    man5.install "man/tuidesk-config.5"
    man7.install "man/tuidesk-lua.7"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tuidesk --version")
    assert_match "[general]", shell_output("#{bin}/tuidesk --print-config")
  end
end
