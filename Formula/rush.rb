class Rush < Formula
  desc "Manage and run packages from shell-script repositories"
  homepage "https://github.com/DannyBen/rush"
  url "https://github.com/DannyBen/rush/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "439d2a4b6d0aeb099ba7de84ba90ac973ef421d48fb4c3d34f782abb2383f4a5"
  license "MIT"

  depends_on "bash"
  depends_on "fzf"

  def install
    bin.install "rush"
    man1.install Dir["doc/*.1"]
    generate_completions_from_executable bin/"rush", "completions",
                                         shell_parameter_format: :none, shells: [:bash]
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
