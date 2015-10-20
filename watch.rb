class Watch < Formula
  desc "Executes a program periodically, showing output fullscreen"
  homepage "https://gitlab.com/procps-ng/procps"
  url "https://gitlab.com/procps-ng/procps/repository/archive.tar.gz?ref=v3.3.11"
  version "3.3.11"
  sha256 "69e421cb07d5dfd38100b4b68714e9cb05d4fe58a7c5145c7b672d1ff08ca58b"

  head "https://gitlab.com/procps-ng/procps.git"

  option "with-watch8bit", "Enable watch to be 8bit clean (requires ncurses)"
  option "with-nls", "Enable Native Language Support"

  depends_on "gettext" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "homebrew/dupes/ncurses" => :optional

  conflicts_with "visionmedia-watch"

  def install
    args = ["--prefix=#{prefix}",
            "--disable-dependency-tracking",]

    make_args = ["LDADD="]

    if build.with? "nls"
      ENV.append "LDFLAGS", "-L#{Formula["gettext"].opt_lib}"
      ENV.append "CPPFLAGS", "-L#{Formula["gettext"].opt_include}"

      # libtool breaks build if libintl isn't included strictly
      make_args << "LIBS=-lintl"
    else
      # disabling Native Language Support removes libintl usage
      args << "--disable-nls"
    end

    if build.with? "ncurses"
      ENV.append "LDFLAGS", "-L#{Formula["ncurses"].opt_lib}"
      ENV.append "CPPFLAGS", "-I#{Formula["ncurses"].opt_include}"

      # enabling it without installed ncurses will break the build
      args << "--enable-watch8bit" if build.with? "watch8bit"
    end

    inreplace "autogen.sh", /libtool/, "glibtool"

    system "./autogen.sh"
    system "./configure", *args
    system "make", "watch", *make_args

    bin.mkpath
    bin.install "watch"
    man1.install "watch.1"
  end

  test do
    ENV["TERM"] = "xterm"
    system "#{bin}/watch", "--errexit", "--chgexit", "--interval", "1", "date"
  end
end
