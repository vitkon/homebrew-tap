class Lidsomnia < Formula
  desc "Keep your MacBook awake with the lid closed while Claude Code, Codex or any job runs"
  homepage "https://vitkon.github.io/lidsomnia/"
  url "https://github.com/vitkon/lidsomnia/archive/refs/tags/v2.3.0.tar.gz"
  sha256 "97b477c5280a30fa64f7db6cb4b5f451f873b2b0b41c9bc21fe4e0b61a47e15f"
  license "MIT"

  bottle do
    root_url "https://github.com/vitkon/lidsomnia/releases/download/v2.3.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c0a5cb3215e043eb28ac8f7eb5eb9c3c93aab0b58eab42261b8cbeb7281b3bf9"
    sha256 cellar: :any_skip_relocation, sequoia:       "411041914cfba76ddebe12efea9a3426d43a423d99ba24222f00f0152edc91d8"
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
