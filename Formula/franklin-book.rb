class FranklinBook < Formula
  desc "Turn technical books into Claude Code plugins (Opus advises, Sonnet executes)"
  homepage "https://github.com/mcrundo/franklin"
  url "https://files.pythonhosted.org/packages/52/e5/f6a1963f5245ae8c5217587ae13c0badd6841fc7354ad9eafe423089b0d2/franklin_book-0.4.2.tar.gz"
  sha256 "07ccd3a7c6860940373e6c2067a4cb4af0227a26784488fbb4aa310bd3689708"
  license "MIT"

  depends_on "python@3.12"

  # Protect the venv from Homebrew's post-install cleanup and dylib
  # relocation — wheels like cryptography/lxml have Mach-O headers
  # too small for install_name_tool rewriting.
  skip_clean "libexec"

  def install
    venv = libexec/"venv"
    system "python3.12", "-m", "venv", venv.to_s
    system venv/"bin/pip", "install", "franklin-book==#{version}"
    bin.install_symlink venv/"bin/franklin"
  end

  test do
    assert_match "Turn technical books", shell_output("#{bin}/franklin --help")
  end
end
