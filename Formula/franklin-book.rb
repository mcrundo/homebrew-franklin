class FranklinBook < Formula
  desc "Turn technical books into Claude Code plugins (Opus advises, Sonnet executes)"
  homepage "https://github.com/mcrundo/franklin"
  url "https://files.pythonhosted.org/packages/b7/98/2cb4d9dc3ed22b11368be53027b6b2f852b1cb45d6d25b0675467f868f22/franklin_book-0.4.1.tar.gz"
  sha256 "1930320b72550407cbcaca80e269db72e36a2b1ebb32142fe454b8a74e283694"
  license "MIT"

  depends_on "python@3.12"

  skip_clean "libexec"

  def install
    venv = libexec/"venv"
    system "python3.12", "-m", "venv", venv.to_s
  end

  def post_install
    venv_pip = libexec/"venv/bin/pip"
    system venv_pip, "install", "franklin-book==#{version}"
    bin.install_symlink libexec/"venv/bin/franklin"
  end

  test do
    assert_match "Turn technical books", shell_output("#{bin}/franklin --help")
  end
end
