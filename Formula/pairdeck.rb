# Template: scripts/homebrew-formula.sh fills in the version and the checksums of the
# release tarballs, and the release workflow pushes the result to portvex/homebrew-tap as
# Formula/pairdeck.rb. The formula installs the prebuilt executables: the universal one on
# macOS, the static musl ones on Linux. Nothing is compiled, so no Rust toolchain is needed.
class Pairdeck < Formula
  desc "Twin-panel terminal file manager inspired by Midnight Commander"
  homepage "https://github.com/portvex/pairdeck"
  license "MIT"

  if OS.mac?
    url "https://github.com/portvex/pairdeck/releases/download/v0.1.0/pairdeck-0.1.0-universal-apple-darwin.tar.gz"
    sha256 "e03d1491564ac2b9d5e1dde160c7edf410c1a792114801989bc63d23088ed360"
  elsif Hardware::CPU.arm?
    url "https://github.com/portvex/pairdeck/releases/download/v0.1.0/pairdeck-0.1.0-aarch64-unknown-linux-musl.tar.gz"
    sha256 "490dad977ab21a2aee0b83794e7331593fcbcf75cb31ef1c18b9e6d36bf41664"
  else
    url "https://github.com/portvex/pairdeck/releases/download/v0.1.0/pairdeck-0.1.0-x86_64-unknown-linux-musl.tar.gz"
    sha256 "607cc7549c7657abebdae245f50dc08cde257b87884291ebaffc40405188e515"
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
