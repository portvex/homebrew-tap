# Template: `cargo xtask dist recipes` fills in the version and the checksums of the release's
# executables (dist/packaging/homebrew/Formula/tuidesk.rb), laid out like a tap repository such
# as portvex/homebrew-tap. The formula installs the prebuilt executables: the universal one on
# macOS, the static musl ones on Linux. Nothing is compiled, so no Rust toolchain is needed.
class Tuidesk < Formula
  desc "KDE Plasma style desktop that runs inside a terminal"
  homepage "https://github.com/portvex/tuidesk"
  license "MIT"

  if OS.mac?
    url "https://github.com/portvex/tuidesk/releases/download/v0.2.1/tuidesk-0.2.1-macos-universal.tar.gz"
    sha256 "d6a2e3619e3305ff03bf904b25cdf3f7e1ae89c9b53bfb618244a1e19ad262ec"
  elsif Hardware::CPU.arm?
    url "https://github.com/portvex/tuidesk/releases/download/v0.2.1/tuidesk-0.2.1-aarch64-unknown-linux-musl.tar.gz"
    sha256 "080a3081441a3647526063f079eab2c615eafb5328c21a6f3ecf30b9e4d9b137"
  else
    url "https://github.com/portvex/tuidesk/releases/download/v0.2.1/tuidesk-0.2.1-x86_64-unknown-linux-musl.tar.gz"
    sha256 "8bbb437db778b25d37d5c7289fc642ea62a97022c0a60024d1ee103e9fab81de"
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
