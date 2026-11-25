# Template: scripts/homebrew-formula.sh fills in the version and the checksums of the
# release tarballs, and the release workflow pushes the result to portvex/homebrew-tap as
# Formula/pairdeck.rb. The formula installs the prebuilt executables: the universal one on
# macOS, the static musl ones on Linux. Nothing is compiled, so no Rust toolchain is needed.
class Pairdeck < Formula
  desc "Twin-panel terminal file manager inspired by Midnight Commander"
  homepage "https://github.com/portvex/pairdeck"
  license "MIT"

  if OS.mac?
    url "https://github.com/portvex/pairdeck/releases/download/v0.1.2/pairdeck-0.1.2-universal-apple-darwin.tar.gz"
    sha256 "25deec7c6d9d07529738a928eb21fd67ddb926664aa03e0dc52ec5d97f94d3ff"
  elsif Hardware::CPU.arm?
    url "https://github.com/portvex/pairdeck/releases/download/v0.1.2/pairdeck-0.1.2-aarch64-unknown-linux-musl.tar.gz"
    sha256 "00a3a41c6e5e4e560bc7d41cd6ea5ddc9b3081bc33d0bf73875e7068171fc04a"
  else
    url "https://github.com/portvex/pairdeck/releases/download/v0.1.2/pairdeck-0.1.2-x86_64-unknown-linux-musl.tar.gz"
    sha256 "281d3de0e731e9db9193c82f0479934c31eecf7039a89bd9defec158311e887a"
  end

  def install
    bin.install "pdeck"
    man1.install "pdeck.1"
    bash_completion.install "completions/pdeck.bash" => "pdeck"
    zsh_completion.install "completions/_pdeck"
    fish_completion.install "completions/pdeck.fish"
  end

  def caveats
    <<~EOS
      The command is `pdeck`. To change to its last directory when it exits, add to your
      shell's rc file:
        pdcd() { local f=$(mktemp); pdeck -P "$f" "$@"; cd "$(cat "$f")"; rm -f "$f"; }
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pdeck --version")
    assert_match ".TH PDECK 1", shell_output("#{bin}/pdeck --man")
  end
end
