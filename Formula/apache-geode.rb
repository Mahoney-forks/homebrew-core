class ApacheGeode < Formula
  desc "In-memory Data Grid for fast transactional data processing"
  homepage "https://geode.apache.org/"
  url "https://www.apache.org/dyn/closer.lua?path=geode/1.14.1/apache-geode-1.14.1.tgz"
  mirror "https://archive.apache.org/dist/geode/1.14.1/apache-geode-1.14.1.tgz"
  mirror "https://downloads.apache.org/geode/1.14.1/apache-geode-1.14.1.tgz"
  sha256 "1be5c03d82ef852eb8bb914af6927af545cbe69d62fd645eb122f077674a014f"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "09a60d3d762e9b1a88c96a35551335a24cabe4930e70e9df2776d6e8ac17b8ee"
  end

  depends_on "openjdk@11"

  def install
    rm_f "bin/gfsh.bat"
    bash_completion.install "bin/gfsh-completion.bash" => "gfsh"
    libexec.install Dir["*"]
    (bin/"gfsh").write_env_script libexec/"bin/gfsh", Language::Java.java_home_env("11")
  end

  test do
    flags = "--dir #{testpath} --name=geode_locator_brew_test"
    output = shell_output("#{bin}/gfsh start locator #{flags}")
    assert_match "Cluster configuration service is up and running", output
  ensure
    quiet_system "pkill", "-9", "-f", "geode_locator_brew_test"
  end
end
