class FranklinBook < Formula
  include Language::Python::Virtualenv

  desc "Turn technical books into Claude Code plugins (Opus advises, Sonnet executes)"
  homepage "https://github.com/mcrundo/franklin"
  url "https://files.pythonhosted.org/packages/41/0b/fc92a83a7a3c6521cf850973207c8be6d9947255c8f0b57a0d1b5d901590/franklin_book-0.2.0.tar.gz"
  sha256 "c58a2c5f3cfc2d082de8407effb357f429a897b138eb50c30f5cb4e2e6f1c23f"
  license "MIT"

  depends_on "python@3.12"

  # Resource blocks below are populated by `brew update-python-resources`.
  # Do not edit by hand — re-run that command on every version bump.

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "franklin", shell_output("#{bin}/franklin --help")
    system bin/"franklin", "doctor", "--skip-network"
  end
end
