class Smartloop < Formula
  desc "Smartloop framework for building LLM agents and tools"
  homepage "https://smartloop.ai"
  version "1.0.1"
  license "Apache-2.0"

  # Prevent Homebrew from rewriting @rpath in the PyInstaller bundle's dylibs.
  skip_clean :all

  on_macos do
    url "https://storage.googleapis.com/smartloop-gcp-us-east-releases/1.0.1/darwin/arm64/slp.tar.gz"
    sha256 "102814ebf85208cdc43a06f14755067807809d7b893f251d53abb34942861157"
  end

  on_linux do
    url "https://storage.googleapis.com/smartloop-gcp-us-east-releases/1.0.1/linux/amd64/slp.tar.gz"
    sha256 "d0fc398c2ec3bc688b1eeb118ed72649797305722548d2160abacccb57ac8094"
  end

  def install
    # The tarball extracts to a slp/ directory containing the PyInstaller binary
    # and its _internal/ dependencies. Install the whole directory to libexec.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"slp"
  end

  def post_install
    (var/"log").mkpath
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
      To start the Smartloop service:
        brew services start smartloop

      To manage the service:
        brew services stop smartloop
        brew services restart smartloop
    EOS
  end

  test do
    assert_predicate bin/"slp", :exist?
    assert_predicate bin/"slp", :executable?
  end
end
