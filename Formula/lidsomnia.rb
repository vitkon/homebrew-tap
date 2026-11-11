class Lidsomnia < Formula
  desc "Keep your MacBook awake with the lid closed while Claude Code, Codex or any job runs"
  homepage "https://vitkon.github.io/lidsomnia/"
  url "https://github.com/vitkon/lidsomnia/archive/refs/tags/v2.4.0.tar.gz"
  sha256 "41df647c834ff31e2ef62cc1e755fdcded75968f849f9975c18c5c5046a70cb3"
  license "MIT"

  bottle do
    root_url "https://github.com/vitkon/lidsomnia/releases/download/v2.4.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d1dfc660dc520c3a927c3288b0b133806f0a473284541627a81f6c930df64c99"
    sha256 cellar: :any_skip_relocation, sequoia:       "4da6e143b72558c69fde759aae3eaea526b99b357c54691f98068b0144193b09"
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
