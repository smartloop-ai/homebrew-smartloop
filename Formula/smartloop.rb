class Smartloop < Formula
  desc "Smartloop framework for building LLM agents and tools"
  homepage "https://smartloop.ai"
  version "1.0.1"
  license "Apache-2.0"

  # Prevent Homebrew from rewriting @rpath in the PyInstaller bundle's dylibs.
  skip_clean :all

  on_macos do
    url "https://storage.googleapis.com/smartloop-gcp-us-east-releases/1.0.1/darwin/arm64/slp.tar.gz"
    sha256 "572a9d1519d2b9a9a79b5d5783b33b4749fea33ae435ede9f5987bcb33ed3f1c"
  end

  on_linux do
    url "https://storage.googleapis.com/smartloop-gcp-us-east-releases/1.0.1/linux/amd64/slp.tar.gz"
    sha256 "8e5c580d7a60b9ff0540c95a160c21a59e60c34c5058c60803e8370f2a9e1fe0"
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
