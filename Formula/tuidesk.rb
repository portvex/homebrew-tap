# Template: `cargo xtask dist recipes` fills in the version and checksum
# (dist/packaging/homebrew/Formula/tuidesk.rb), laid out like a tap repository such as
# portvex/homebrew-tap.
class Tuidesk < Formula
  desc "KDE Plasma style desktop that runs inside a terminal"
  homepage "https://github.com/portvex/tuidesk"
  url "https://github.com/portvex/tuidesk/releases/download/v0.1.0/tuidesk-0.1.0.tar.gz"
  sha256 "a0131582358fb0e0d3a5beb058ca089fc563dae768cacce6cbeb0033073d36e3"
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
