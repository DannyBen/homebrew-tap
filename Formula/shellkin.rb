class Shellkin < Formula
  desc "Gherkin-style BDD framework for command-line tools and shell scripts"
  homepage "https://github.com/DannyBen/shellkin"
  url "https://github.com/DannyBen/shellkin/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "360b3a325f363fdee54017e2f503687b642e0cfde20fd9faf800063302789178"
  license "MIT"

  depends_on "bash"

  def install
    bin.install "shellkin"
    man1.install "doc/shellkin.1"
    man5.install "doc/shellkin-feature.5", "doc/shellkin-stepdefs.5"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/shellkin --version")
    assert_match "initialized shellkin features directory: features",
                 shell_output("#{bin}/shellkin --init")
    assert_match "1 scenario, 0 failing", shell_output(bin/"shellkin")
  end
end
