class Unoconv < Formula
  desc "Convert between any document format supported by OpenOffice"
  homepage "http://dag.wiee.rs/home-made/unoconv/"
  url       "https://github.com/yuhaoth/unoconv/archive/0.7-jy-1.tar.gz"
  sha256    "de7efaf536f7e95ae7edc50a4405ec3e8bdf0ddae338664677b3b07593c13086"
  head "https://github.com/yuhaoth/unoconv.git"

  bottle :unneeded

  depends_on :python if MacOS.version <= :snow_leopard

  def install
    system "make", "install", "prefix=#{prefix}"
    bin.install "uno.py"
    bin.install "unohelper.py"
  end

  def caveats; <<-EOS.undent
    In order to use unoconv, a copy of LibreOffice between versions 3.6.0.1 - 4.3.x must be installed.
    EOS
  end
end
