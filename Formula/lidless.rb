class Lidless < Formula
  desc "Keep your MacBook awake with the lid closed while Claude Code, Codex or any job runs"
  homepage "https://vitkon.github.io/lidless/"
  url "https://github.com/vitkon/lidless/archive/refs/tags/v2.0.4.tar.gz"
  sha256 "49e541d66a5fac55ddabfa187f41aee6d2eaf6d7c81f8299fffc4e32a85fbe71"
  license "MIT"

  bottle do
    root_url "https://github.com/vitkon/lidless/releases/download/v2.0.4"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "29f9b364339f8f1df0eee87408673aeecd80a2790ca704bf6f15fa57b505ce09"
    sha256 cellar: :any_skip_relocation, sequoia:       "58d5e2901500d33a1c43bd3b553808defea0f75ac58e114632ada09871def327"
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
