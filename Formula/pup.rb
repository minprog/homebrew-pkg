class Pup < Formula
  desc "Parse HTML at the command-line"
  homepage "https://github.com/ericchiang/pup"
  url "https://github.com/ericchiang/pup/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "0d546ab78588e07e1601007772d83795495aa329b19bd1c3cde589ddb1c538b0"
  license "MIT"
  head "https://github.com/ericchiang/pup.git", branch: "master"

  depends_on "go" => :build

  def install
    # The v0.4.0 tag has no go.mod, so build in GOPATH mode with its vendored dependencies.
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "off"
    dir = buildpath/"src/github.com/ericchiang/pup"
    dir.install buildpath.children

    cd dir do
      system "go", "build", "-ldflags", "-s -w", "-o", bin/"pup", "."
    end

    prefix.install_metafiles dir
  end

  test do
    output = pipe_output("#{bin}/pup p text{}", "<body><p>Hello</p></body>", 0)
    assert_equal "Hello", output.chomp
  end
end
