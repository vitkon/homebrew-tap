class Lidsomnia < Formula
  desc "Keep your MacBook awake with the lid closed while Claude Code, Codex or any job runs"
  homepage "https://vitkon.github.io/lidsomnia/"
  url "https://github.com/vitkon/lidsomnia/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "f661ecd7e89a23bc2b6002a33ba576d888c945811d0d3d34dec0384e7a0657f3"
  license "MIT"

  bottle do
    root_url "https://github.com/vitkon/lidsomnia/releases/download/v2.2.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5c763a56dac83c5c6c1ab225c1d950bb6b8f7ef67310d9cc6ac8b5c7aef4f5ea"
    sha256 cellar: :any_skip_relocation, sequoia:       "9714f3b6d88a9705aaa1f40ade3ffe84dfb43fcc9081deadd2b9d4f6cdc84526"
  end

  depends_on xcode: ["16.0", :build]
  depends_on :macos

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/lidsomnia"
    bin.install_symlink "lidsomnia" => "lidless" # the old name keeps working
  end

  def caveats
    <<~EOS
      Run setup once to allow lidsomnia to toggle sleep (asks for your password):
        lidsomnia setup

      Then wrap any job, e.g.:
        lidsomnia claude --remote-control
    EOS
  end

  test do
    assert_match "lidsomnia #{version}", shell_output("#{bin}/lidsomnia --version")
  end
end
