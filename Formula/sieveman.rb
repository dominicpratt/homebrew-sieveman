class Sieveman < Formula
  desc "Universal ManageSieve protocol client"
  homepage "https://github.com/dominicpratt/sieveman"
  url "https://github.com/dominicpratt/sieveman/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "4cdd841d734e651936823b8ff62b5fc7bcb7cca393c35650468772b166114e21"
  license "ISC"
  head "https://github.com/dominicpratt/sieveman.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -X go.wzykubek.xyz/sieveman/cmd.version=#{version}
    ]
    system "go", "build", *std_go_args(ldflags: ldflags)

    man1.install "docs/man/sieveman.1"
    generate_completions_from_executable(bin/"sieveman", "completion")
  end

  test do
    assert_match "Sieveman #{version}", shell_output("#{bin}/sieveman version")
    assert_match "host is not specified", shell_output("#{bin}/sieveman ls 2>&1", 1)
  end
end
