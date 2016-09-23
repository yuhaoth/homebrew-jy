class Geany < Formula
  desc "Basic text editor with IDE support"
  homepage "http://geany.org/"
  url "http://download.geany.org/geany-1.28.tar.bz2"
  version "1.28"
  sha256 "f73a3708f1a26e9bf72da564d5037d6f7fedca2e0d6175db0681c2b672100a5a"



  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "gettext"
  depends_on "gtk+"
  depends_on "vte"

  bottle do
    root_url "http://localhost:5000"
    prefix "/mnt/fileroot/jerry.yu/linuxbrew/.linuxbrew"
    cellar "/mnt/fileroot/jerry.yu/linuxbrew/.linuxbrew/Cellar"
    sha256 "dd13af9c0ff3583cf6351c4d4ab6585c2bc37073b0cee625cd1caa7840987b2e" => :x86_64_linux
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    # main executable test (GUI)
    system "#{bin}/geany", "--version"
    # API test
    (testpath/"test.c").write <<-EOS.undent
      #include <geanyplugin.h>
      PLUGIN_SET_INFO("HelloWorld", "Just another tool to say hello world", "1.0", "Joe Doe <joe.doe@example.org>");
      int main(int argc, char *argv[]) {
        return 0;
      }
    EOS
    atk = Formula["atk"]
    cairo = Formula["cairo"]
    fontconfig = Formula["fontconfig"]
    freetype = Formula["freetype"]
    gdk_pixbuf = Formula["gdk-pixbuf"]
    gettext = Formula["gettext"]
    glib = Formula["glib"]
    gtkx = Formula["gtk+"]
    libpng = Formula["libpng"]
    pango = Formula["pango"]
    pixman = Formula["pixman"]
    flags = (ENV.cflags || "").split + (ENV.cppflags || "").split + (ENV.ldflags || "").split
    flags += %W[
      -I#{atk.opt_include}/atk-1.0
      -I#{cairo.opt_include}/cairo
      -I#{fontconfig.opt_include}
      -I#{freetype.opt_include}/freetype2
      -I#{gdk_pixbuf.opt_include}/gdk-pixbuf-2.0
      -I#{gettext.opt_include}
      -I#{glib.opt_include}/glib-2.0
      -I#{glib.opt_lib}/glib-2.0/include
      -I#{gtkx.opt_include}/gtk-2.0
      -I#{gtkx.opt_lib}/gtk-2.0/include
      -I#{include}/geany
      -I#{include}/geany/scintilla
      -I#{include}/geany/tagmanager
      -I#{libpng.opt_include}/libpng16
      -I#{pango.opt_include}/pango-1.0
      -I#{pixman.opt_include}/pixman-1
      -DGTK
      -D_REENTRANT
      -L#{atk.opt_lib}
      -L#{cairo.opt_lib}
      -L#{gdk_pixbuf.opt_lib}
      -L#{gettext.opt_lib}
      -L#{glib.opt_lib}
      -L#{gtkx.opt_lib}
      -L#{lib}
      -L#{pango.opt_lib}
      -latk-1.0
      -lcairo
      -lgdk-quartz-2.0
      -lgdk_pixbuf-2.0
      -lgio-2.0
      -lglib-2.0
      -lgobject-2.0
      -lgtk-quartz-2.0
      -lintl
      -lpango-1.0
      -lpangocairo-1.0
    ]
    system ENV.cc, "test.c", "-o", "test", *flags
    system "./test"
  end
end
