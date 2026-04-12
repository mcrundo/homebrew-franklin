class FranklinBook < Formula
  desc "Turn technical books into Claude Code plugins (Opus advises, Sonnet executes)"
  homepage "https://github.com/mcrundo/franklin"
  url "https://files.pythonhosted.org/packages/41/0b/fc92a83a7a3c6521cf850973207c8be6d9947255c8f0b57a0d1b5d901590/franklin_book-0.2.0.tar.gz"
  sha256 "c58a2c5f3cfc2d082de8407effb357f429a897b138eb50c30f5cb4e2e6f1c23f"
  license "MIT"

  depends_on "python@3.12"

  def install
    # Use pip with pre-built wheels instead of virtualenv_install_with_resources
    # (which forces --no-binary :all: and hits brew's sandboxed build
    # environment limitations for packages with native extensions like
    # cryptography, pillow, and lxml). This matches what `uv tool install`
    # and `pipx install` do — binary wheels from PyPI.
    python3 = "python3.12"
    venv = libexec/"venv"
    system python3, "-m", "venv", venv.to_s
    venv_pip = venv/"bin/pip"
    system venv_pip, "install", "--upgrade", "pip"
    system venv_pip, "install", "franklin-book==#{version}"
    # Link the franklin binary into brew's bin
    bin.install_symlink venv/"bin/franklin"
  end

  test do
    assert_match "Turn technical books", shell_output("#{bin}/franklin --help")
  end
end
