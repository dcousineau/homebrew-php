require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Intl < AbstractPhp54Extension
  init
  homepage 'http://php.net/manual/en/book.intl.php'
  url 'http://www.php.net/get/php-5.4.12.tar.bz2/from/this/mirror'
  sha1 '9e1af30b763ba3de19b68b9b8abde1aae1e5e630'
  version '5.4.12'

  depends_on 'icu4c'

  def install
    Dir.chdir "ext/intl"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-icu-dir=#{Formula.factory('icu4c').opt_prefix}",
                          "--enable-intl"
    system "make"
    prefix.install "modules/intl.so"
    write_config_file unless build.include? "without-config-file"
  end
end
