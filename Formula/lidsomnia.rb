class Lidsomnia < Formula
  desc "Keep your MacBook awake with the lid closed while Claude Code, Codex or any job runs"
  homepage "https://vitkon.github.io/lidsomnia/"
  url "https://github.com/vitkon/lidsomnia/archive/refs/tags/v2.1.0.tar.gz"
  sha256 "a37e1f0ecd00b99b94fa74beb79eb3262804ed5a1068a175066858596f0d4478"
  license "MIT"

  bottle do
    root_url "https://github.com/vitkon/lidsomnia/releases/download/v2.1.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "63e275511841d935b2e2f200069d88b45aa9d52c837f2e39e9f8387e05c681d8"
    sha256 cellar: :any_skip_relocation, sequoia:       "9cde15e291ca8653bbbb053ef5c2de62ffe015752ca6ce71e40930659ba03042"
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
