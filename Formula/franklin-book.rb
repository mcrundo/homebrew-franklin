class FranklinBook < Formula
  desc "Turn technical books into Claude Code plugins (Opus advises, Sonnet executes)"
  homepage "https://github.com/mcrundo/franklin"
  url "https://files.pythonhosted.org/packages/40/8f/54bc0ee9c1e639ec8a53f36a3350a226c3070042f715a516520a8552e8eb/franklin_book-0.4.4.tar.gz"
  sha256 "1de8da918a7b6520d77f6330df1c864de9e736b10accb414b5cd345db3989849"
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
