class Libcs50 < Formula
  desc "CS50 Library for C"
  homepage "https://cs50.readthedocs.io/libraries/cs50/c/"
  url "https://github.com/cs50/libcs50/archive/refs/tags/v10.1.1.tar.gz"
  sha256 "32d5d7aafbb20f2b6181f7e79df6757699208324ab202bc5984f55669557a7d4"
  license "MIT"

  def install
    system "make", "install", "DESTDIR=#{prefix}"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include <cs50.h>
      int main() {
        int count = get_int("");
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-lcs50", "-o", "test"
    system "echo", "\"3\"", "|", "./test"
  end
end
