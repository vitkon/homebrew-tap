class Lidless < Formula
  desc "Keep your MacBook awake with the lid closed while Claude Code or any job runs"
  homepage "https://vitkon.github.io/lidless/"
  url "https://github.com/vitkon/lidless/archive/refs/tags/v2.0.2.tar.gz"
  sha256 "92aea77f262e9805eec278e25c69d9bd43e9c649d9f8eacf48e70fb85815fd25"
  license "MIT"

  bottle do
    root_url "https://github.com/vitkon/lidless/releases/download/v2.0.2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "11dca9b4be38735b3a8831e23571d5a00b9d3a8d56b43ffd046aec5d33efe14f"
    sha256 cellar: :any_skip_relocation, sequoia:       "1d516b8caaacbb7fe2ab13bea9128a5ca13673caedfa288afbd6a0127e4a37c4"
  end

  depends_on xcode: ["16.0", :build]
  depends_on :macos

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/lidless"
  end

  def caveats
    <<~EOS
      Run setup once to allow lidless to toggle sleep (asks for your password):
        lidless setup

      Then wrap any job, e.g.:
        lidless claude --remote-control
    EOS
  end

  test do
    assert_match "lidless #{version}", shell_output("#{bin}/lidless --version")
  end
end
