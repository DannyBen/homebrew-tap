class Fuzzycd < Formula
  desc "Patch cd with fuzzy directory history and interactive selection"
  homepage "https://github.com/DannyBen/fuzzycd"
  url "https://github.com/DannyBen/fuzzycd/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "f38e4c8481012c4790ed157ea6eedd6aa0f76bf50b00d974d97d01db8dd2b3b6"
  license "MIT"

  depends_on "fzf"

  def install
    bin.install "fuzzycd"
  end

  def caveats
    <<~EOS
      To activate FuzzyCD in Bash, add this to your shell configuration:

        source "#{opt_bin}/fuzzycd"
        eval "$(fuzzycd -c)"

      For Zsh, add only:

        source "#{opt_bin}/fuzzycd"
    EOS
  end

  test do
    assert_equal "fuzzycd #{version}", shell_output("#{bin}/fuzzycd -v").strip
    assert_match "_fuzzycd_completions", shell_output("#{bin}/fuzzycd -c")

    target = testpath/"projects/fuzzy-home"
    target.mkpath
    history = testpath/"history"

    ENV["FUZZYCD_TTY_FORCE"] = "1"
    ENV["FUZZYCD_HISTORY_FILE"] = history

    (testpath/"test.sh").write <<~BASH
      source "#{bin}/fuzzycd"
      cd "#{target}"
      cd "#{testpath}"
      cd fuzzy-home
    BASH

    assert_equal target.to_s, shell_output("bash #{testpath}/test.sh").strip
    assert_match target.to_s, history.read
  end
end
