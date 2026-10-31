# Template: `cargo xtask dist recipes` fills in the version and the checksums of the release's
# executables (dist/packaging/homebrew/Formula/tuidesk.rb), laid out like a tap repository such
# as portvex/homebrew-tap. The formula installs the prebuilt executables: the universal one on
# macOS, the static musl ones on Linux. Nothing is compiled, so no Rust toolchain is needed.
class Tuidesk < Formula
  desc "KDE Plasma style desktop that runs inside a terminal"
  homepage "https://github.com/portvex/tuidesk"
  license "MIT"

  if OS.mac?
    url "https://github.com/portvex/tuidesk/releases/download/v0.2.0/tuidesk-0.2.0-macos-universal.tar.gz"
    sha256 "4b398afb9332b47421e8168d7b2fddc21de0fd11ecf584835040c3bd6cbf5c4f"
  elsif Hardware::CPU.arm?
    url "https://github.com/portvex/tuidesk/releases/download/v0.2.0/tuidesk-0.2.0-aarch64-unknown-linux-musl.tar.gz"
    sha256 "f54e2d4abb7e01f861ac2c6f4be969bb06b68cfb58c348d6d43f98c64fd5ca85"
  else
    url "https://github.com/portvex/tuidesk/releases/download/v0.2.0/tuidesk-0.2.0-x86_64-unknown-linux-musl.tar.gz"
    sha256 "ef339e194151351d1acfdf900aec57da4bb1d876aa5a1f83a6b2f2ca18d9c49a"
  end

  def install
    bin.install "tuidesk"
    man1.install "man/tuidesk.1"
    man5.install "man/tuidesk-config.5"
    man7.install "man/tuidesk-lua.7"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tuidesk --version")
    assert_match "[general]", shell_output("#{bin}/tuidesk --print-config")
  end
end
