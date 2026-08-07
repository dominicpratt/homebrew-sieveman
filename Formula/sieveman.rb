class Sieveman < Formula
  desc "Universal ManageSieve protocol client"
  homepage "https://github.com/dominicpratt/sieveman"
  url "https://github.com/dominicpratt/sieveman/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "f70424d3e3f9012d846671897557feaabc567d867336b393cb8ad47150e1e364"
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
