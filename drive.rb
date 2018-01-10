class Drive < Formula
  desc "Google Drive client for the command-line"
  homepage "https://github.com/odeke-em/drive"

  # TODO: Replace head repo with original one after PR
  head "https://github.com/yumitsu/drive.git", :branch => "dep-vendor-locking"

  stable do
    url "https://github.com/odeke-em/drive/archive/v0.3.9.tar.gz"
    sha256 "ce7e4dd994c01d4534251c9a31adca34ed89ff6e64045813a7ce5c588ddd04be"
  end

  devel do
    url "https://github.com/odeke-em/drive.git", :tag => "v0.3.9.1"
  end

  depends_on "go"  => :build
  depends_on "dep" => :build

  def install
    # install will fail if buildpath contains 'src'
    tempdir = buildpath/"gopath"
    tempdir.mkpath
    (tempdir/"src/github.com/odeke-em/drive").install buildpath.children - [tempdir]

    ENV["GOPATH"] = tempdir

    cd tempdir/"src/github.com/odeke-em/drive" do
      system "dep", "ensure"
      system "make", "darwin"

      mv "./bin/drive_darwin", "./bin/drive"
      bin.install "./bin/drive"
      prefix.install_metafiles
    end
  end

  test do
    # TODO: Tests
    system bin/"drive", "version"
  end
end
