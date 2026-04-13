class FranklinBook < Formula
  desc "Turn technical books into Claude Code plugins (Opus advises, Sonnet executes)"
  homepage "https://github.com/mcrundo/franklin"
  url "https://files.pythonhosted.org/packages/6e/74/20444ffe88c80191058c6f4ceb17e0cd545dfb705909ad5c575915e1ee42/franklin_book-0.4.0.tar.gz"
  sha256 "4a22f215c511c0f43439b5b2bcb0459f79ca5a654a42dde457bec0a789986431"
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
