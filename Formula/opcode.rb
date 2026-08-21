class Opcode < Formula
  desc "Local command shortcuts"
  homepage "https://github.com/DannyBen/opcode"
  url "https://github.com/DannyBen/opcode/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "8c1445db33450aad4bd6c82c87e58ac711ba3adad42ae4786f983621fb2f6aef"
  license "MIT"

  depends_on "bash"

  def install
    bin.install "op"
    man1.install "doc/op.1"

    (bash_completion/"op").write <<~BASH
      complete -C 'op --completion' op
    BASH
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/op --version").strip

    (testpath/"op.conf").write <<~EOS
      hello: printf 'hello from opcode\\n'
    EOS

    assert_equal "hello from opcode\n", shell_output("#{bin}/op hello")
  end
end
