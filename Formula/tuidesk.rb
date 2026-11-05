# Template: `cargo xtask dist recipes` fills in the version and the checksums of the release's
# executables (dist/packaging/homebrew/Formula/tuidesk.rb), laid out like a tap repository such
# as portvex/homebrew-tap. The formula installs the prebuilt executables: the universal one on
# macOS, the static musl ones on Linux. Nothing is compiled, so no Rust toolchain is needed.
class Tuidesk < Formula
  desc "KDE Plasma style desktop that runs inside a terminal"
  homepage "https://github.com/portvex/tuidesk"
  license "MIT"

  if OS.mac?
    url "https://github.com/portvex/tuidesk/releases/download/v0.2.2/tuidesk-0.2.2-macos-universal.tar.gz"
    sha256 "272b3cb52cf1d27697d563b304e4d0275c84566fd64333a02b1d2840e531eae8"
  elsif Hardware::CPU.arm?
    url "https://github.com/portvex/tuidesk/releases/download/v0.2.2/tuidesk-0.2.2-aarch64-unknown-linux-musl.tar.gz"
    sha256 "c12a55dc568244cd8c3439c1750d6da3263564e81dcaf6dc1dc4ab3e4bc44942"
  else
    url "https://github.com/portvex/tuidesk/releases/download/v0.2.2/tuidesk-0.2.2-x86_64-unknown-linux-musl.tar.gz"
    sha256 "972db4649ec9e68f0c8b8af86bda1630c7cf99f5ae9b0ea784e8d54d296610f3"
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
