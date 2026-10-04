class Config < Formula
  desc "Read and edit configuration files while preserving comments and formatting"
  homepage "https://github.com/DannyBen/config"
  url "https://github.com/DannyBen/config/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "a38799a1538501fd3a4869ce81ac7bb0ce57203ef81cdeb49d25325741696ef2"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.Version=#{version}")
    generate_completions_from_executable(bin/"config", "completion")
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/config --version").strip

    config_file = testpath/"app.toml"
    config_file.write <<~TOML
      # Server settings
      [server]
      port = 2000 # HTTP port
    TOML

    assert_equal "2000\n", shell_output("#{bin}/config get -f #{config_file} server.port")
    system bin/"config", "set", "-f", config_file, "server.port", "3000"
    assert_equal "3000\n", shell_output("#{bin}/config get -f #{config_file} server.port")
    assert_equal <<~TOML, config_file.read
      # Server settings
      [server]
      port = 3000 # HTTP port
    TOML
  end
end
