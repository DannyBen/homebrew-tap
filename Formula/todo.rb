class Todo < Formula
  desc "Lightweight project todo list shared by humans and coding agents"
  homepage "https://github.com/DannyBen/todo"
  url "https://github.com/DannyBen/todo/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "51b7f3150d27e9916a8979ba002e608c7d5a07fc9af5dd6f15f9d710b55d85cd"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.Version=#{version}")
  end

  test do
    ENV["TODO_FILE"] = (testpath/"tasks.sqlite").to_s
    ENV["TODO_BACKUP"] = ""
    ENV["NO_COLOR"] = "1"

    assert_equal version.to_s, shell_output("#{bin}/todo --version").strip
    assert_equal "1 Prepare deployment +now\n", shell_output("#{bin}/todo add Prepare deployment +now")
    assert_equal "1 Prepare deployment +now\n", shell_output("#{bin}/todo list +now")
    assert_equal "1 Prepare deployment +done\n", shell_output("#{bin}/todo edit 1 -now +done")
    assert_empty shell_output("#{bin}/todo list +now")
    assert_equal "1 Prepare deployment +done\n", shell_output("#{bin}/todo del +done")
    assert_empty shell_output("#{bin}/todo list")
  end
end
