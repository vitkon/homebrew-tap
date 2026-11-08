class Lidless < Formula
  desc "Keep your MacBook awake with the lid closed while Claude Code or any job runs"
  homepage "https://vitkon.github.io/lidless/"
  url "https://github.com/vitkon/lidless/archive/refs/tags/v2.0.3.tar.gz"
  sha256 "7cc02c5ca83845b07039bd17ba534384599b2b202deb6b2eddb2d9a1c1caf7e0"
  license "MIT"

  bottle do
    root_url "https://github.com/vitkon/lidless/releases/download/v2.0.3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a42f9afb5ead1c2fa868a2dd7ecbd20ce7848b74cef2f4e32a5a83863b7e2616"
    sha256 cellar: :any_skip_relocation, sequoia:       "21316d636eb9d62f94a09b7ef4c4c2fc119605d76708e86a8e87a714e4f6cd53"
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
