class Smartloop < Formula
  desc "Smartloop framework for building LLM agents and tools"
  homepage "https://smartloop.ai"
  version "1.0.1"
  license "Apache-2.0"

  on_macos do
    url "https://storage.googleapis.com/smartloop-gcp-us-east-releases/1.0.1/darwin/slp.tar.gz"
    sha256 "ea907eaa6d2dca3547056666023d1a795690ba7c96b96ae7f3b8c37f4d3d4553"
  end

  on_linux do
    url "https://storage.googleapis.com/smartloop-gcp-us-east-releases/1.0.1/linux/slp.tar.gz"
    sha256 "73fd941e1dec5c2f6250a20900ee05759d3db172bbc3b6263f89c3964bcc11aa"
  end

  def install
    # The tarball extracts to a slp/ directory containing the PyInstaller binary
    # and its _internal/ dependencies. Install the whole directory to libexec.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"slp"
  end

  def post_install
    (var/"log").mkpath
    system "brew", "services", "start", "smartloop"
  end

  service do
    run [opt_bin/"slp", "server", "start"]
    keep_alive true
    log_path var/"log/smartloop.log"
    error_log_path var/"log/smartloop.log"
    working_dir opt_libexec
  end

  def caveats
    <<~EOS
      The Smartloop service has been started automatically.
      To manage the service:
        brew services stop smartloop
        brew services start smartloop
        brew services restart smartloop
    EOS
  end

  test do
    assert_predicate bin/"slp", :exist?
    assert_predicate bin/"slp", :executable?
  end
end
