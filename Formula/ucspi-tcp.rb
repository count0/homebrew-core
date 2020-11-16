class UcspiTcp < Formula
  desc "Tools for building TCP client-server applications"
  homepage "https://cr.yp.to/ucspi-tcp.html"
  url "https://cr.yp.to/ucspi-tcp/ucspi-tcp-0.88.tar.gz"
  sha256 "4a0615cab74886f5b4f7e8fd32933a07b955536a3476d74ea087a3ea66a23e9c"

  livecheck do
    url "https://cr.yp.to/ucspi-tcp/install.html"
    regex(/href=.*?ucspi-tcp[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "e6e117599fbdb3619aa5bbc6dbc0dad76b73c507cab9fcf90b4e258b3a3ffb9f" => :big_sur
    sha256 "7daae5b06fc2d2d42c1fcfc02368bf84e565d0557de006c14c2a31cc91cd25ee" => :catalina
    sha256 "f464584f762728957020fce03d331fb6e96c79a721cdd5911afb452d4b91da7b" => :mojave
    sha256 "b3f2714c61a157eb31ef53915901c29c24ad3dc5cf7d7c3403dcd501399e26b4" => :high_sierra
    sha256 "46d324e867e5a35cbb17e8a215ff33f693651d11645eed116e4e4a6c02085b34" => :sierra
    sha256 "a57368e57812063bc4e1450c0bef5cad8392c44e54abf3c8ca950ea51abe7ae9" => :el_capitan
    sha256 "727e93394b415da772b43ce5028ad54dcb569f695e6c8c4cdf05dc462b2febbe" => :yosemite
    sha256 "67eb31db588a2299c5e69a4a60f3c56d07624a58e52e77cff2e58be554085d9f" => :mavericks
  end

  # IPv6 patch
  # Used to be https://www.fefe.de/ucspi/ucspi-tcp-0.88-ipv6.diff19.bz2
  patch do
    url "https://raw.githubusercontent.com/homebrew/patches/2b3e4da/ucspi-tcp/patch-0.88-ipv6.diff"
    sha256 "c2d6ce17c87397253f298cc28499da873efe23afe97e855bdcf34ae66374036a"
  end

  def install
    (buildpath/"conf-home").unlink
    (buildpath/"conf-home").write prefix

    system "make"
    bin.mkpath
    system "make", "setup"
    system "make", "check"
    share.install prefix/"man"
  end

  test do
    assert_match(/usage: tcpserver/,
      shell_output("#{bin}/tcpserver 2>&1", 100))
  end
end
