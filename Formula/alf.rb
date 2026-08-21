class Alf < Formula
  desc "Manage Bash aliases with a simple configuration file"
  homepage "https://github.com/DannyBen/alf"
  url "https://github.com/DannyBen/alf/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "2a1329e121ff2e98b871d5429ea02f74620e8c3788b4e146d99a83e3afaeb0c1"
  license "MIT"

  depends_on "bash"

  def install
    bin.install "alf"
    man1.install Dir["doc/*.1"]
    man5.install "doc/alf.conf.5"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/alf --version").strip

    (testpath/"alf.conf").write <<~YAML
      g: git
        s: status
    YAML

    output = shell_output("#{bin}/alf generate")
    assert_match "g()", output
    assert_match "git status", output
  end
end
