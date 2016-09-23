# Documentation: https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class GeanyPlugins < Formula
  desc ""
  homepage ""
  url "https://plugins.geany.org/geany-plugins/geany-plugins-1.28.tar.bz2"
  version "1.28"
  sha256 "b13471e0a4cb76d04a96bb21c965087b50c16390edee0c6b3bbd920d8ac17745"

  # depends_on "cmake" => :build
  depends_on "geany" # if your formula requires any X11/XQuartz components
  bottle do
    root_url "http://localhost:5000"
    prefix "/mnt/fileroot/jerry.yu/linuxbrew/.linuxbrew"
    cellar "/mnt/fileroot/jerry.yu/linuxbrew/.linuxbrew/Cellar"
    sha256 "ece552a030922321c267f14cd4f60cdd094fb8c6a6ab2d4c681953d1aff4951d" => :x86_64_linux
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test geany-plugins`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
