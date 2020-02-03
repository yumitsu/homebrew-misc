class Jtool2 < Formula
  desc "Drop in replacement for otool, nm, strings, and segedit"
  homepage "http://www.newosxbook.com/tools/jtool.html"
  url "http://www.newosxbook.com/tools/jtool2.tgz"
  version "2.0"
  sha256 "63850d1efb466a9a1f968ba5c1355fbc5640316f1bee61752ad1dff2fb285b2c"
  revision 2

  def install
    bin.mkpath
    rm "jtool2.ELF64"
    system "install", "-s", "jtool2", "#{prefix}/bin"
    system "install", "-s", "disarm", "#{prefix}/bin"
    info.install "matchers.txt"
  end

  def caveats
    <<~EOS
      File with Joker symbols was placed in #{info}
    EOS
  end

  test do
    true
  end
end
