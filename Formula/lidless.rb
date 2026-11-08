class Lidless < Formula
  desc "Keep your MacBook awake with the lid closed while Claude Code, Codex or any job runs"
  homepage "https://vitkon.github.io/lidless/"
  url "https://github.com/vitkon/lidless/archive/refs/tags/v2.0.4.tar.gz"
  sha256 "e20dcf25a7b7a139acf06820d33e1cfcedb9b47fcd760f569e9e40220c8e3406"
  license "MIT"

  bottle do
    root_url "https://github.com/vitkon/lidless/releases/download/v2.0.4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "50d427e5eec7f5fdfbc7cf1529ff2313dc8e6f045518b1348ced5781716b396f"
    sha256 cellar: :any_skip_relocation, sequoia:       "9fc68323e956df7a41eaac9420b338a7fdccc4de3acc1875c1026d8b2c986a78"
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
