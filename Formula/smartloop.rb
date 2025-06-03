class Smartloop < Formula
  include Language::Python::Virtualenv

  desc "SmartLoop CLI - Command-line interface for the SmartLoop AI platform"
  homepage "https://github.com/smartloop-ai/smartloop"
  url "https://github.com/smartloop-ai/smartloop/archive/refs/tags/v1.2.8.tar.gz"
  version "1.2.8"
  sha256 "6b4fce5ba3462f9a8e7504448f05ed38724405d045f23b335374c7dc6da4e501" # Calculate the SHA256 for v1.2.8 tarball
  license "MIT"

  head "https://github.com/smartloop-ai/smartloop.git", branch: "main"

  depends_on "python@3.11"
  depends_on "openssl@3" # Add OpenSSL dependency if required for secure connections
  depends_on "libyaml"   # Add libyaml dependency if required for YAML parsing

  def install
    # Create the virtualenv
    venv = virtualenv_create(libexec, "python3.11")
    
    # Install main dependencies
    venv.pip_install "art==6.2"
    venv.pip_install "blessed==1.21.0"
    venv.pip_install "certifi==2025.4.26"
    venv.pip_install "charset-normalizer==3.4.2"
    venv.pip_install "click==8.1.7"
    venv.pip_install "editor==1.6.6"
    venv.pip_install "idna==3.10"
    venv.pip_install "inquirer==3.3.0"
    venv.pip_install "markdown-it-py==3.0.0"
    venv.pip_install "mdurl==0.1.2"
    venv.pip_install "Pygments==2.19.1"
    venv.pip_install "PyYAML==6.0.1"
    venv.pip_install "readchar==4.2.1"
    venv.pip_install "requests==2.32.3"
    venv.pip_install "rich==14.0.0"
    venv.pip_install "runs==1.2.2"
    venv.pip_install "shellingham==1.5.4"
    venv.pip_install "tabulate==0.9.0"
    venv.pip_install "typer==0.9.0"
    venv.pip_install "typing_extensions==4.13.2"
    venv.pip_install "urllib3==2.4.0"
    venv.pip_install "wcwidth==0.2.13"
    venv.pip_install "xmod==1.8.1"
    venv.pip_install "markupsafe==2.1.5"
    venv.pip_install "werkzeug==3.0.1"
    venv.pip_install "blinker==1.7.0"
    venv.pip_install "jinja2==3.1.4"
    venv.pip_install "itsdangerous==2.1.2"
    venv.pip_install "flask==3.0.0"
    
    # Install the package itself
    venv.pip_install_and_link buildpath
  end

  test do
    # Verify the CLI is installed and responds to --help
    assert_match "Usage: smartloop [OPTIONS] COMMAND [ARGS]...", shell_output("#{bin}/smartloop --help")
  end
end
