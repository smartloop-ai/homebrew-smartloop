class Smartloop < Formula
  desc "Smartloop framework for building LLM agents and tools"
  homepage "https://smartloop.ai"
  url "https://github.com/smartloop-ai/smartloop/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "739da19a65bc8a214acf0b4506786d04fa2d53292e9c23e13773b8e9865493d2"
  license "GPL-3.0"

  depends_on "cmake" => :build
  depends_on "python@3.11"
  depends_on "spatialindex"

  def install
    virtualenv = libexec/"venv"
    python = Formula["python@3.11"].opt_bin/"python3.11"

    system python, "-m", "venv", virtualenv
    venv_pip = virtualenv/"bin/pip"

    extra_index = "https://us-central1-python.pkg.dev/smartloop-gcp-us-east/slp-pypi/simple/"

    if OS.mac?
      ENV["CMAKE_ARGS"] = "-DLLAMA_METAL=on -DCMAKE_BUILD_TYPE=Release"
      ENV["LDFLAGS"] = "-Wl,-headerpad_max_install_names"
    elsif OS.linux?
      cuda_root = ENV["CUDA_HOME"] || Dir["/usr/local/cuda*"].max || "/usr/local/cuda"
      ENV["CMAKE_ARGS"] = "-DLLAMA_CUBLAS=on -DCUDA_TOOLKIT_ROOT_DIR=#{cuda_root} -DCMAKE_BUILD_TYPE=Release"
    end

    system venv_pip, "install", "scikit-build-core", "cmake", "ninja"
    system venv_pip, "install", "--no-build-isolation", "--extra-index-url", extra_index, "smartloop==1.0.1"
    system venv_pip, "install", "--no-build-isolation",
            "git+https://github.com/smartloop-ai/smartloop.git@v1.0.1#egg=slp"

    venv_site = virtualenv/"lib/python3.11/site-packages"
    system "curl", "-sSL", "-o", "#{venv_site}/main.py",
           "https://raw.githubusercontent.com/smartloop-ai/smartloop/v1.0.1/main.py"

    (bin/"slp").write <<~EOS
      #!/bin/bash
      export SPATIALINDEX_C_LIBRARY="#{Formula["spatialindex"].opt_lib}/libspatialindex_c.so"
      export API_PORT=0
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
