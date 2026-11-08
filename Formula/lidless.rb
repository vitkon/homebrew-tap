class Lidless < Formula
  desc "Keep your MacBook awake with the lid closed while Claude Code or any job runs"
  homepage "https://vitkon.github.io/lidless/"
  url "https://github.com/vitkon/lidless/archive/refs/tags/v2.0.1.tar.gz"
  sha256 "80754f9a41df507162073205ca446ec14a27b44967575e340c0b62ddf8e46c66"
  license "MIT"

  bottle do
    root_url "https://github.com/vitkon/lidless/releases/download/v2.0.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "da1485e9c0d7182d3e91bc9f9bb08d896ef8410a4fc38bf32cdb860877a59923"
    sha256 cellar: :any_skip_relocation, sequoia:       "95f225131a3e6b80930f5517c15d17ed3a2afd929f26ff3938139c0c70fcb301"
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
