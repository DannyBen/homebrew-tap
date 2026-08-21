class Rush < Formula
  desc "Manage and run packages from shell-script repositories"
  homepage "https://github.com/DannyBen/rush"
  url "https://github.com/DannyBen/rush/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "e3032527c94753a550cbdd045410503e1b0a0d13f07b9a1f866a729e0293f1ec"
  license "MIT"

  depends_on "bash"
  depends_on "fzf"

  def install
    bin.install "rush"
    man1.install Dir["doc/*.1"]
    generate_completions_from_executable bin/"rush", "completions", shells: [:bash, :zsh]
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/rush --version").strip

    ENV["RUSH_CONFIG"] = testpath/"rush.ini"
    ENV["RUSH_ROOT"] = testpath/"rush-repos"

    repo = testpath/"repo"
    package = repo/"hello"
    package.mkpath
    (package/"info").write "Print a greeting\n"
    (package/"main").write <<~BASH
      #!/usr/bin/env bash
      echo "installed by rush"
    BASH

    system bin/"rush", "add", "default", repo
    assert_match "installed by rush", shell_output("#{bin}/rush get hello")
  end
end
