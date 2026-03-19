class Smartloop < Formula
  desc "Smartloop framework for building LLM agents and tools"
  homepage "https://smartloop.ai"
  url "https://github.com/smartloop-ai/smartloop/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "03f49a46b8f0f45e699fdfac37153a2514366a684610837d229e6b59f1a377ef"
  license "GPL-3.0"

  depends_on "cmake" => :build
  depends_on "gcc" => :build
  depends_on "python@3.11"
  depends_on "spatialindex"

  def install
    virtualenv = libexec/"venv"
    python = Formula["python@3.11"].opt_bin/"python3.11"

    system python, "-m", "venv", virtualenv
    venv_pip = virtualenv/"bin/pip"

    extra_index = "https://us-central1-python.pkg.dev/smartloop-gcp-us-east/slp-pypi/simple/"

    # Set compilers explicitly so native extensions (llama-cpp-python) can build
    ENV["CC"] = Formula["gcc"].opt_bin/"gcc-15"
    ENV["CXX"] = Formula["gcc"].opt_bin/"g++-15"
    ENV["CMAKE_ARGS"] = "-DCMAKE_C_COMPILER=#{ENV["CC"]} -DCMAKE_CXX_COMPILER=#{ENV["CXX"]}"

    # Install the smartloop dependency first (needed at build time for dynamic version)
    system venv_pip, "install", "--extra-index-url", extra_index, "smartloop==1.0.2"

    # Install the main package (no build isolation so it can find smartloop for dynamic version)
    system venv_pip, "install", "--no-build-isolation", "--extra-index-url", extra_index, "."

    # Create a wrapper script that sets up the runtime environment
    (bin/"slp").write <<~EOS
      #!/bin/bash
      export SPATIALINDEX_C_LIBRARY="#{Formula["spatialindex"].opt_lib}/libspatialindex_c.so"
      exec "#{virtualenv}/bin/slp" "$@"
    EOS
  end

  def post_install
    (var/"log").mkpath
    (Pathname.new(Dir.home)/".smartloop").mkpath
  end

  service do
    run [opt_bin/"slp", "server", "start"]
    keep_alive true
    log_path var/"log/smartloop.log"
    error_log_path var/"log/smartloop.log"
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
