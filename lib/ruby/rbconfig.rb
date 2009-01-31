
# This file was created by mkconfig.rb when ruby was built.  Any
# changes made to this file will be lost the next time ruby is built.

module RbConfig
  RUBY_VERSION == "1.9.1" or
    raise "ruby lib version (1.9.1) doesn't match executable version (#{RUBY_VERSION})"

  TOPDIR = File.dirname(__FILE__).chomp!("/lib/ruby/1.9.1/arm-linux")
  DESTDIR = '' unless defined? DESTDIR
  CONFIG = {}
  CONFIG["DESTDIR"] = DESTDIR
  CONFIG["INSTALL"] = '/usr/bin/install -c'
  CONFIG["EXEEXT"] = ""
  CONFIG["prefix"] = (TOPDIR || DESTDIR + "/data/ruby")
  CONFIG["ruby_install_name"] = "ruby"
  CONFIG["RUBY_INSTALL_NAME"] = "ruby"
  CONFIG["RUBY_SO_NAME"] = "ruby"
  CONFIG["BUILTIN_TRANSSRCS"] = " newline.c"
  CONFIG["MANTYPE"] = "doc"
  CONFIG["NROFF"] = "/usr/bin/nroff"
  CONFIG["vendorhdrdir"] = "$(rubyhdrdir)/vendor_ruby"
  CONFIG["sitehdrdir"] = "$(rubyhdrdir)/site_ruby"
  CONFIG["rubyhdrdir"] = "$(includedir)/$(RUBY_INSTALL_NAME)-$(ruby_version)"
  CONFIG["configure_args"] = " '--build=arm-android-linux' '--target=arm-android-linux' '--host=i686-linux' '--enable-wide-getaddrinfo' '--prefix=/data/ruby' 'build_alias=arm-android-linux' 'host_alias=i686-linux' 'target_alias=arm-android-linux' 'CC=/home/sakamoto/android/prebuilt/linux-x86/toolchain/arm-eabi-4.2.1/bin/arm-eabi-gcc' 'LIBS=-nostdlib -L/home/sakamoto/android/out/target/product/dream/obj/lib -lstdc++ -lc -lm -ldl -Wl,-dynamic-linker,/system/bin/linker,-rpath,/system/lib' 'CPPFLAGS=-nostdinc -I/home/sakamoto/android/external/zlib -I/home/sakamoto/android/external/openssl/include -I/home/sakamoto/android/bionic/libc/include -I/home/sakamoto/android/bionic/libc/arch-arm/include -I/home/sakamoto/android/bionic/libc/kernel/common -I/home/sakamoto/android/bionic/libc/kernel/arch-arm -I/home/sakamoto/android/bionic/libc/kernel/common/linux -I/home/sakamoto/android/bionic/libm/include -I/home/sakamoto/android/prebuilt/linux-x86/toolchain/arm-eabi-4.2.1/lib/gcc/arm-eabi/4.2.1/include -Dptrdiff_t=__ptrdiff_t -include stdio.h -include unistd.h -include fcntl.h -include sys/mman.h -DHAVE_GETCWD'"
  CONFIG["vendordir"] = "$(libdir)/$(RUBY_INSTALL_NAME)/vendor_ruby"
  CONFIG["sitedir"] = "$(libdir)/$(RUBY_INSTALL_NAME)/site_ruby"
  CONFIG["ruby_version"] = "1.9.1"
  CONFIG["sitearch"] = "arm-linux"
  CONFIG["arch"] = "arm-linux"
  CONFIG["MAKEFILES"] = "Makefile"
  CONFIG["THREAD_MODEL"] = "pthread"
  CONFIG["EXPORT_PREFIX"] = ""
  CONFIG["COMMON_HEADERS"] = ""
  CONFIG["COMMON_MACROS"] = ""
  CONFIG["COMMON_LIBS"] = ""
  CONFIG["MAINLIBS"] = "/home/sakamoto/android/out/target/product/dream/obj/lib/crtbegin_dynamic.o /home/sakamoto/android/out/target/product/dream/obj/lib/crtend_android.o"
  CONFIG["ENABLE_SHARED"] = "no"
  CONFIG["DLDLIBS"] = " -lc"
  CONFIG["SOLIBS"] = ""
  CONFIG["LIBRUBYARG_SHARED"] = "-Wl,-R -Wl,$(libdir) -L$(libdir) -l$(RUBY_SO_NAME)"
  CONFIG["LIBRUBYARG_STATIC"] = "-Wl,-R -Wl,$(libdir) -L$(libdir) -l$(RUBY_SO_NAME)-static"
  CONFIG["LIBRUBYARG"] = "$(LIBRUBYARG_STATIC)"
  CONFIG["LIBRUBY"] = "$(LIBRUBY_A)"
  CONFIG["LIBRUBY_ALIASES"] = "lib$(RUBY_SO_NAME).so"
  CONFIG["LIBRUBY_SO"] = "lib$(RUBY_SO_NAME).so.$(MAJOR).$(MINOR).$(TEENY)"
  CONFIG["LIBRUBY_A"] = "lib$(RUBY_SO_NAME)-static.a"
  CONFIG["RUBYW_INSTALL_NAME"] = ""
  CONFIG["rubyw_install_name"] = ""
  CONFIG["LIBRUBY_DLDFLAGS"] = ""
  CONFIG["LIBRUBY_LDSHARED"] = "$(CC) -shared"
  CONFIG["warnflags"] = "-Wall -Wno-parentheses"
  CONFIG["debugflags"] = ""
  CONFIG["optflags"] = "-O2"
  CONFIG["cflags"] = "$(optflags) $(debugflags) $(warnflags)"
  CONFIG["cppflags"] = "-nostdinc -I/home/sakamoto/android/external/zlib -I/home/sakamoto/android/external/openssl/include -I/home/sakamoto/android/bionic/libc/include -I/home/sakamoto/android/bionic/libc/arch-arm/include -I/home/sakamoto/android/bionic/libc/kernel/common -I/home/sakamoto/android/bionic/libc/kernel/arch-arm -I/home/sakamoto/android/bionic/libc/kernel/common/linux -I/home/sakamoto/android/bionic/libm/include -I/home/sakamoto/android/prebuilt/linux-x86/toolchain/arm-eabi-4.2.1/lib/gcc/arm-eabi/4.2.1/include -Dptrdiff_t=__ptrdiff_t -include stdio.h -include unistd.h -include fcntl.h -include sys/mman.h -DHAVE_GETCWD"
  CONFIG["RDOCTARGET"] = "install-doc"
  CONFIG["ARCHFILE"] = ""
  CONFIG["EXTOUT"] = ".ext"
  CONFIG["PREP"] = "fake.rb"
  CONFIG["setup"] = "Setup"
  CONFIG["EXTSTATIC"] = ""
  CONFIG["STRIP"] = "strip -S -x"
  CONFIG["TRY_LINK"] = ""
  CONFIG["LIBPATHENV"] = "LD_LIBRARY_PATH"
  CONFIG["RPATHFLAG"] = " -Wl,-R%1$-s"
  CONFIG["LIBPATHFLAG"] = " -L%1$-s"
  CONFIG["LINK_SO"] = ""
  CONFIG["LIBEXT"] = "a"
  CONFIG["DLEXT2"] = ""
  CONFIG["DLEXT"] = "so"
  CONFIG["LDSHAREDXX"] = "$(CXX) -shared"
  CONFIG["LDSHARED"] = "$(CC) -shared"
  CONFIG["CCDLFLAGS"] = " -fPIC"
  CONFIG["STATIC"] = ""
  CONFIG["ARCH_FLAG"] = ""
  CONFIG["DLDFLAGS"] = ""
  CONFIG["ALLOCA"] = ""
  CONFIG["RMALL"] = "rm -fr"
  CONFIG["RMDIRS"] = "$(top_srcdir)/tool/rmdirs"
  CONFIG["MAKEDIRS"] = "mkdir -p"
  CONFIG["CP"] = "cp"
  CONFIG["RM"] = "rm -f"
  CONFIG["INSTALL_DATA"] = "$(INSTALL) -m 644"
  CONFIG["INSTALL_SCRIPT"] = "$(INSTALL)"
  CONFIG["INSTALL_PROGRAM"] = "$(INSTALL)"
  CONFIG["SET_MAKE"] = ""
  CONFIG["LN_S"] = "ln -s"
  CONFIG["DLLWRAP"] = ""
  CONFIG["WINDRES"] = ""
  CONFIG["NM"] = ""
  CONFIG["OBJCOPY"] = "objcopy"
  CONFIG["OBJDUMP"] = "objdump"
  CONFIG["ASFLAGS"] = ""
  CONFIG["AS"] = "as"
  CONFIG["AR"] = "/home/sakamoto/android/prebuilt/linux-x86/toolchain/arm-eabi-4.2.1/bin/arm-eabi-ar"
  CONFIG["RANLIB"] = "/home/sakamoto/android/prebuilt/linux-x86/toolchain/arm-eabi-4.2.1/bin/arm-eabi-ranlib"
  CONFIG["COUTFLAG"] = "-o "
  CONFIG["OUTFLAG"] = "-o "
  CONFIG["CPPOUTFILE"] = "-o conftest.i"
  CONFIG["GNU_LD"] = "yes"
  CONFIG["EGREP"] = "/bin/grep -E"
  CONFIG["GREP"] = "/bin/grep"
  CONFIG["CPP"] = "/home/sakamoto/android/prebuilt/linux-x86/toolchain/arm-eabi-4.2.1/bin/arm-eabi-gcc -E"
  CONFIG["CXXFLAGS"] = " -O2 -Wall -Wno-parentheses"
  CONFIG["CXX"] = "g++"
  CONFIG["OBJEXT"] = "o"
  CONFIG["CPPFLAGS"] = "-nostdinc -I/home/sakamoto/android/external/zlib -I/home/sakamoto/android/external/openssl/include -I/home/sakamoto/android/bionic/libc/include -I/home/sakamoto/android/bionic/libc/arch-arm/include -I/home/sakamoto/android/bionic/libc/kernel/common -I/home/sakamoto/android/bionic/libc/kernel/arch-arm -I/home/sakamoto/android/bionic/libc/kernel/common/linux -I/home/sakamoto/android/bionic/libm/include -I/home/sakamoto/android/prebuilt/linux-x86/toolchain/arm-eabi-4.2.1/lib/gcc/arm-eabi/4.2.1/include -Dptrdiff_t=__ptrdiff_t -include stdio.h -include unistd.h -include fcntl.h -include sys/mman.h -DHAVE_GETCWD $(DEFS) $(cppflags)"
  CONFIG["LDFLAGS"] = "-L.  -Wl,-export-dynamic"
  CONFIG["CFLAGS"] = " -O2 -Wall -Wno-parentheses"
  CONFIG["CC"] = "/home/sakamoto/android/prebuilt/linux-x86/toolchain/arm-eabi-4.2.1/bin/arm-eabi-gcc"
  CONFIG["target_os"] = "linux"
  CONFIG["target_vendor"] = "android"
  CONFIG["target_cpu"] = "arm"
  CONFIG["target"] = "arm-android-linux-gnu"
  CONFIG["host_os"] = "linux-gnu"
  CONFIG["host_vendor"] = "pc"
  CONFIG["host_cpu"] = "i686"
  CONFIG["host"] = "i686-pc-linux-gnu"
  CONFIG["build_os"] = "linux-gnu"
  CONFIG["build_vendor"] = "android"
  CONFIG["build_cpu"] = "arm"
  CONFIG["build"] = "arm-android-linux-gnu"
  CONFIG["TEENY"] = "1"
  CONFIG["MINOR"] = "9"
  CONFIG["MAJOR"] = "1"
  CONFIG["BASERUBY"] = "ruby"
  CONFIG["target_alias"] = "arm-android-linux"
  CONFIG["host_alias"] = "i686-linux"
  CONFIG["build_alias"] = "arm-android-linux"
  CONFIG["LIBS"] = "-ldl -lm -nostdlib -L/home/sakamoto/android/out/target/product/dream/obj/lib -lstdc++ -lc -lm -ldl -Wl,-dynamic-linker,/system/bin/linker,-rpath,/system/lib"
  CONFIG["ECHO_T"] = ""
  CONFIG["ECHO_N"] = "-n"
  CONFIG["ECHO_C"] = ""
  CONFIG["DEFS"] = ""
  CONFIG["mandir"] = "$(datarootdir)/man"
  CONFIG["localedir"] = "$(datarootdir)/locale"
  CONFIG["libdir"] = "$(exec_prefix)/lib"
  CONFIG["psdir"] = "$(docdir)"
  CONFIG["pdfdir"] = "$(docdir)"
  CONFIG["dvidir"] = "$(docdir)"
  CONFIG["htmldir"] = "$(docdir)"
  CONFIG["infodir"] = "$(datarootdir)/info"
  CONFIG["docdir"] = "$(datarootdir)/doc/$(PACKAGE)"
  CONFIG["oldincludedir"] = "/usr/include"
  CONFIG["includedir"] = "$(prefix)/include"
  CONFIG["localstatedir"] = "$(prefix)/var"
  CONFIG["sharedstatedir"] = "$(prefix)/com"
  CONFIG["sysconfdir"] = "$(prefix)/etc"
  CONFIG["datadir"] = "$(datarootdir)"
  CONFIG["datarootdir"] = "$(prefix)/share"
  CONFIG["libexecdir"] = "$(exec_prefix)/libexec"
  CONFIG["sbindir"] = "$(exec_prefix)/sbin"
  CONFIG["bindir"] = "$(exec_prefix)/bin"
  CONFIG["exec_prefix"] = "$(prefix)"
  CONFIG["PACKAGE_BUGREPORT"] = ""
  CONFIG["PACKAGE_STRING"] = ""
  CONFIG["PACKAGE_VERSION"] = ""
  CONFIG["PACKAGE_TARNAME"] = ""
  CONFIG["PACKAGE_NAME"] = ""
  CONFIG["PATH_SEPARATOR"] = ":"
  CONFIG["SHELL"] = "/bin/bash"
  CONFIG["rubylibdir"] = "$(libdir)/$(ruby_install_name)/$(ruby_version)"
  CONFIG["archdir"] = "$(rubylibdir)/$(arch)"
  CONFIG["sitelibdir"] = "$(sitedir)/$(ruby_version)"
  CONFIG["sitearchdir"] = "$(sitelibdir)/$(sitearch)"
  CONFIG["vendorlibdir"] = "$(vendordir)/$(ruby_version)"
  CONFIG["vendorarchdir"] = "$(vendorlibdir)/$(sitearch)"
  CONFIG["topdir"] = File.dirname(__FILE__)
  MAKEFILE_CONFIG = {}
  CONFIG.each{|k,v| MAKEFILE_CONFIG[k] = v.dup}
  def RbConfig::expand(val, config = CONFIG)
    val.gsub!(/\$\$|\$\(([^()]+)\)|\$\{([^{}]+)\}/) do
      var = $&
      if !(v = $1 || $2)
	'$'
      elsif key = config[v = v[/\A[^:]+(?=(?::(.*?)=(.*))?\z)/]]
	pat, sub = $1, $2
	config[v] = false
	RbConfig::expand(key, config)
	config[v] = key
	key = key.gsub(/#{Regexp.quote(pat)}(?=\s|\z)/n) {sub} if pat
	key
      else
	var
      end
    end
    val
  end
  CONFIG.each_value do |val|
    RbConfig::expand(val)
  end
end
Config = RbConfig # compatibility for ruby-1.8.4 and older.
CROSS_COMPILING = nil unless defined? CROSS_COMPILING
