class Shove < Formula
  desc "Test tool for shell scripts with TAP outputs"
  homepage "https://github.com/progrhyme/shove"
  url "https://github.com/progrhyme/shove/archive/v0.8.4.tar.gz"
  sha256 "e4d02ac0879d5a18b7b7dd23d40951b60cc233da0303c3bcd69c70d8eb0177c8"
  license "MIT"

  head do
    url "https://github.com/progrhyme/shove.git"
  end

  def install
    bin.mkpath
    bin.install "bin/shove"
  end

  test do
    system bin/"shove", "-V"
  end
end
