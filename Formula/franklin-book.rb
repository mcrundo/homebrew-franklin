class FranklinBook < Formula
  desc "Turn technical books into Claude Code plugins (Opus advises, Sonnet executes)"
  homepage "https://github.com/mcrundo/franklin"
  url "https://files.pythonhosted.org/packages/6e/74/20444ffe88c80191058c6f4ceb17e0cd545dfb705909ad5c575915e1ee42/franklin_book-0.4.0.tar.gz"
  sha256 "4a22f215c511c0f43439b5b2bcb0459f79ca5a654a42dde457bec0a789986431"
  license "MIT"

  depends_on "python@3.12"

  # Create the venv and symlink during install, but defer pip install to
  # post_install so Homebrew's dylib relocation phase never touches the
  # pre-built wheels (cryptography, lxml, etc.) whose Mach-O headers are
  # too small for install_name_tool rewriting.
  skip_clean "libexec"

  def install
    venv = libexec/"venv"
    system "python3.12", "-m", "venv", venv.to_s
    bin.install_symlink venv/"bin/franklin"
  end

  def post_install
    venv_pip = libexec/"venv/bin/pip"
    system venv_pip, "install", "franklin-book==#{version}"
  end

  test do
    assert_match "Turn technical books", shell_output("#{bin}/franklin --help")
  end
end
