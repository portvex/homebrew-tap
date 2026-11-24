# Template: scripts/homebrew-formula.sh fills in the version and the checksums of the
# release tarballs, and the release workflow pushes the result to portvex/homebrew-tap as
# Formula/pairdeck.rb. The formula installs the prebuilt executables: the universal one on
# macOS, the static musl ones on Linux. Nothing is compiled, so no Rust toolchain is needed.
class Pairdeck < Formula
  desc "Twin-panel terminal file manager inspired by Midnight Commander"
  homepage "https://github.com/portvex/pairdeck"
  license "MIT"

  if OS.mac?
    url "https://github.com/portvex/pairdeck/releases/download/v0.1.1/pairdeck-0.1.1-universal-apple-darwin.tar.gz"
    sha256 "a1b2edcd81b8087e710ab9e88a6df27f0a65ce06a69d96841996980acccb68cc"
  elsif Hardware::CPU.arm?
    url "https://github.com/portvex/pairdeck/releases/download/v0.1.1/pairdeck-0.1.1-aarch64-unknown-linux-musl.tar.gz"
    sha256 "8f961ab91ec0232cf0a92793fd2adde7a1fa427a2cfdf631df5ae4173c7c5107"
  else
    url "https://github.com/portvex/pairdeck/releases/download/v0.1.1/pairdeck-0.1.1-x86_64-unknown-linux-musl.tar.gz"
    sha256 "377649761a8455d723ce429c03af488648cc01ef71e4577382486fb5693df624"
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
