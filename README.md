## Ruby for Android

Now support cupcake (Android 1.5)

irbapp.apk includes libruby.so

additional ruby scripts and shared libraries in /sdcard/ruby.

and, native ruby command

    ruby: ELF 32-bit LSB executable, ARM, version 1 (SYSV),
      dynamically linked (uses shared libs), stripped

## Screenshot
![](https://raw.githubusercontent.com/splhack/android-ruby/gh-pages/androidruby_s.png)

## How to build
Follow http://source.android.com/download

Build android-ruby

    $ cd android-ruby
    $ export TOP=$HOME/mydroid
    $ . $TOP/build/envsetup.sh
    $ mm

generated files

    $TOP/out/target/product/generic/system/app/irbapp.apk    pseudo irb application with libruby.so
    $TOP/out/target/product/generic/system/lib/ruby    ruby scripts and ext shared libraries
    $TOP/out/target/product/generic/system/bin/cruby    native command

## Layer
![](https://raw.githubusercontent.com/splhack/android-ruby/gh-pages/blocks.png)
