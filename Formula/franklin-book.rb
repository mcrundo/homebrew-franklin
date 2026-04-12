class FranklinBook < Formula
  desc "Turn technical books into Claude Code plugins (Opus advises, Sonnet executes)"
  homepage "https://github.com/mcrundo/franklin"
  url "https://files.pythonhosted.org/packages/5a/f0/a97956845ddf6c74c96af796b1f90d2b30d937b28aa452095f7df29349d7/franklin_book-0.2.1.tar.gz"
  sha256 "9cb9f6d4091ac51125f2aec2bf100ccb1b2e51e8ab77c88807602603e354622f"
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
