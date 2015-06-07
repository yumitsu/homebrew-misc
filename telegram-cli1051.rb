class Telegram < Formula
  desc "Command-line interface for Telegram"
  homepage "https://github.com/vysheng/tg"
  url "https://github.com/vysheng/tg/archive/1.0.5.1.tar.gz"
  sha256 "5a78fd46e978ff450eda6f4664499042dddf053f4fe233fe3157499869646fb8"

  head "https://github.com/vysheng/tg.git"

  depends_on "openssl"
  depends_on "libevent"
  depends_on "libconfig"
  depends_on "readline"
  depends_on "lua"

  patch :DATA

  def install
    ENV.append "CFLAGS", "-I#{Formula["readline"].opt_include}"
    ENV.append "LDFLAGS", "-L#{Formula["readline"].opt_lib}"

    system "./configure", "--prefix=#{prefix}"
    system "make"

    bin.install "bin/telegram-cli"
    etc.install "tg-server.pub"
  end

  test do
    (testpath/"tg.txt").write <<-EOS.undent
      #
      not a phone number
      #
    EOS
    `#{bin}/telegram-cli < tg.txt 2 >&1`
  end
end

__END__
diff --git a/main.c b/main.c
index ff57ec1..b1d314d 100644
--- a/main.c
+++ b/main.c
@@ -804,6 +804,7 @@ int main (int argc, char **argv) {
   parse_config ();

   tgl_set_rsa_key ("/etc/" PROG_NAME "/server.pub");
+  tgl_set_rsa_key ("HOMEBREW_PREFIX/etc/tg-server.pub");
   tgl_set_rsa_key ("tg-server.pub");
