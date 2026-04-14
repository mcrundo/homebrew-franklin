class FranklinBook < Formula
  desc "Turn technical books into Claude Code plugins (Opus advises, Sonnet executes)"
  homepage "https://github.com/mcrundo/franklin"
  url "https://files.pythonhosted.org/packages/23/4a/3229edb7d7bce572ae9468d973d572ea5199813ef7094ee9d20cae25eae4/franklin_book-0.4.3.tar.gz"
  sha256 "527e2a444fc2f10aa24e6b58c030db1c5066db26142c7193f124cf1a078ad3ce"
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
