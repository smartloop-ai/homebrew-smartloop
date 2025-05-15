class Smartloop < Formula
  include Language::Python::Virtualenv

  desc "SmartLoop CLI - Command-line interface for the SmartLoop AI platform"
  homepage "https://github.com/smartloop-ai/smartloop"
  url "https://github.com/smartloop-ai/smartloop/archive/refs/tags/v1.2.6.tar.gz"
  version "1.2.6"
  sha256 "bf29ab6e5254443eeb118ed29d347962c1610c9c2eebb7d67404815fa973ba08"
  license "MIT"

  head "https://github.com/smartloop-ai/smartloop.git", branch: "main"

  depends_on "python@3.11"

  def install
    venv = virtualenv_create(libexec, "python3.11")
    
    # Install main dependencies
    venv.pip_install "PyYAML==6.0.1"
    venv.pip_install "requests==2.32.3"
    venv.pip_install "typer==0.12.3"
    venv.pip_install "art==6.2"
    venv.pip_install "inquirer==3.3.0"
    venv.pip_install "tabulate==0.9.0"
    
    # Install the package itself
    venv.pip_install_and_link buildpath
  end

  test do
    system bin/"smartloop", "--help"
  end
end
