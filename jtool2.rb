class Jtool2 < Formula
  desc "Drop in replacement for otool, nm, strings, and segedit"
  homepage "http://www.newosxbook.com/tools/jtool.html"
  url "http://www.newosxbook.com/tools/jtool2.tgz"
  version "2.0"
  sha256 "63850d1efb466a9a1f968ba5c1355fbc5640316f1bee61752ad1dff2fb285b2c"
  revision 1

  def install
    bin.mkpath

    system "install", "-S", "jtool2", "#{prefix}/bin"
    system "install", "-S", "jtool2.ELF64", "#{prefix}/bin"
    system "install", "-S", "disarm", "#{prefix}/bin"
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
