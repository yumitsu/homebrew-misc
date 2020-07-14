class JavaDeobfuscator < Formula
  desc "Tool aimed to deobfuscate most available obfuscators for Java"
  homepage "https://github.com/java-deobfuscator/deobfuscator"
  url "https://ci.samczsun.com/job/java-deobfuscator/job/Deobfuscator/51/artifact/target/deobfuscator-1.0.0.jar"
  version "1.0.0-build51"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  bottle :unneeded

  depends_on :java => "1.7+"

  def install
    libexec.install "deobfuscator-1.0.0.jar"
    bin.write_jar_script libexec/"deobfuscator-1.0.0.jar", "java-deobfuscator"
  end

  test do
    system "false"
  end
end
