class EchaouchnaWatch < Formula
  desc "Periodically executes the given command"
  homepage "https://github.com/echaouchna/watch"
  url "https://github.com/echaouchna/watch/archive/master.zip"
  sha256 "935e46e762385e2bbb9dc67e6f181a13ed9d9a16649b33755cc4c4312e510028"

  head "https://github.com/echaouchna/watch.git"

  conflicts_with "watch"
  conflicts_with "visionmedia-watch"

  def install
    bin.mkdir
    system "make", "PREFIX=#{prefix}", "install"
  end
end
