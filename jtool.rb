class Jtool < Formula
  desc "Drop in replacement for otool, nm, strings, and segedit"
  homepage "http://www.newosxbook.com"
  url "http://www.newosxbook.com/files/jtool.tar"
  version "0.88"
  sha256 "3cb6942567f2b48c141f4827276b640207f64dcbfedd1cc9d944d59584dc9bdd"

  def install
    rm "jtool.ELF"
    rm "jtool.ELF32"
    bin.install "jtool"
    man1.install "jtool.1"
  end

  test do
    system "#{bin}/jtool", "--version"
  end
end
