encsrcdir = ./enc
topdir = .
prefix = @prefix@
exec_prefix = @exec_prefix@
libdir = @libdir@
top_srcdir = $(encsrcdir:/enc=)
srcdir = $(top_srcdir)
arch = @arch@
EXTOUT = tmp
hdrdir = $(srcdir)/include
arch_hdrdir = $(EXTOUT)/include/$(arch)
ENCSODIR =
TRANSSODIR =
DLEXT = @DLEXT@
OBJEXT = o

BUILTIN_ENCS	= ascii.c us_ascii.c\
		  unicode.c utf_8.c

BUILTIN_TRANSES	= newline.trans

RUBY_SO_NAME = 
LIBRUBY = liburyb.a
LIBRUBYARG_SHARED = @LIBRUBYARG_SHARED@
LIBRUBYARG_STATIC = $(LIBRUBYARG_SHARED)

empty =
CC = @CC@
OUTFLAG = @OUTFLAG@$(empty)
COUTFLAG = @COUTFLAG@$(empty)
CFLAGS = $(CCDLFLAGS)  
cflags = @cflags@
optflags = @optflags@
debugflags = @debugflags@
warnflags = @warnflags@
CCDLFLAGS = @CCDLFLAGS@
INCFLAGS = -I. -I$(arch_hdrdir) -I$(hdrdir) -I$(top_srcdir)
DEFS = @DEFS@
CPPFLAGS =  -DONIG_ENC_REGISTER=rb_enc_register
LDFLAGS = 
LDSHARED = @LDSHARED@
ldflags  = $(LDFLAGS)
dldflags = 
archflag = 
DLDFLAGS = $(ldflags) $(dldflags) $(archflag)
RUBY     = $(MINIRUBY)

WORKDIRS = $(ENCSODIR) $(TRANSSODIR) enc enc/trans

RM = rm -f
MAKEDIRS = @$(MINIRUBY) -run -e mkdir -- -p

.SUFFIXES: .trans

all: make-workdir

make-workdir:
	$(MAKEDIRS) $(WORKDIRS)

clean:

distclean: clean clean-srcs
	@$(RM) enc.mk

#### depend ####

.SUFFIXES: .trans .c


VPATH = $(arch_hdrdir)/ruby$(hdrdir)/ruby$(srcdir)$(encsrcdir)
LIBPATH =  -L"." -L"$(topdir)"
LIBS =   $(EXTLIBS)

ENCOBJS =

ENCSOS =

ENCCLEANLIBS = 
ENCCLEANOBJS = 

TRANSVPATH = $(srcdir)/enc/trans

TRANSCSRCS = enc/trans/big5.c \
	     enc/trans/chinese.c \
	     enc/trans/escape.c \
	     enc/trans/gb18030.c \
	     enc/trans/gbk.c \
	     enc/trans/iso2022.c \
	     enc/trans/japanese.c \
	     enc/trans/japanese_euc.c \
	     enc/trans/japanese_sjis.c \
	     enc/trans/korean.c \
	     enc/trans/newline.c \
	     enc/trans/single_byte.c \
	     enc/trans/utf_16_32.c

TRANSOBJS =

TRANSSOS =

TRANSCLEANLIBS = 
TRANSCLEANOBJS = 

encs: all
all: enc trans
enc: $(ENCSOS)
trans: $(TRANSSOS)

srcs: $(TRANSCSRCS)

.c.$(OBJEXT):
	-@$(MAKEDIRS) "$(@D)"
	$(CC) $(INCFLAGS) $(CPPFLAGS) $(CFLAGS) $(COUTFLAG)$@ -c $<


.trans.c:
	$(MINIRUBY) "$(srcdir)/tool/transcode-tblgen.rb" -vo "$@" "$<"


$(ENCOBJS): regenc.h oniguruma.h config.h defines.h
$(TRANSOBJS): ruby.h intern.h config.h defines.h missing.h encoding.h oniguruma.h st.h transcode_data.h

enc/trans/big5.c: enc/trans/big5.trans
enc/trans/big5.c: enc/trans/big5-tbl.rb $(srcdir)/tool/transcode-tblgen.rb

enc/trans/chinese.c: enc/trans/chinese.trans
enc/trans/chinese.c:  $(srcdir)/tool/transcode-tblgen.rb

enc/trans/escape.c: enc/trans/escape.trans
enc/trans/escape.c:  $(srcdir)/tool/transcode-tblgen.rb

enc/trans/gb18030.c: enc/trans/gb18030.trans
enc/trans/gb18030.c: enc/trans/gb18030-tbl.rb $(srcdir)/tool/transcode-tblgen.rb

enc/trans/gbk.c: enc/trans/gbk.trans
enc/trans/gbk.c: enc/trans/gbk-tbl.rb $(srcdir)/tool/transcode-tblgen.rb

enc/trans/iso2022.c: enc/trans/iso2022.trans
enc/trans/iso2022.c:  $(srcdir)/tool/transcode-tblgen.rb

enc/trans/japanese.c: enc/trans/japanese.trans
enc/trans/japanese.c:  $(srcdir)/tool/transcode-tblgen.rb

enc/trans/japanese_euc.c: enc/trans/japanese_euc.trans
enc/trans/japanese_euc.c:  $(srcdir)/tool/transcode-tblgen.rb

enc/trans/japanese_sjis.c: enc/trans/japanese_sjis.trans
enc/trans/japanese_sjis.c:  $(srcdir)/tool/transcode-tblgen.rb

enc/trans/korean.c: enc/trans/korean.trans
enc/trans/korean.c: enc/trans/euckr-tbl.rb enc/trans/cp949-tbl.rb $(srcdir)/tool/transcode-tblgen.rb

enc/trans/newline.c: enc/trans/newline.trans
enc/trans/newline.c:  $(srcdir)/tool/transcode-tblgen.rb

enc/trans/single_byte.c: enc/trans/single_byte.trans
enc/trans/single_byte.c:  $(srcdir)/tool/transcode-tblgen.rb

enc/trans/utf_16_32.c: enc/trans/utf_16_32.trans
enc/trans/utf_16_32.c:  $(srcdir)/tool/transcode-tblgen.rb

$(ENCSODIR)/encdb.$(DLEXT): enc/encdb.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/encdb.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/ascii.$(DLEXT): enc/ascii.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/ascii.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/big5.$(DLEXT): enc/big5.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/big5.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/cp949.$(DLEXT): enc/cp949.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/cp949.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/emacs_mule.$(DLEXT): enc/emacs_mule.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/emacs_mule.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/euc_jp.$(DLEXT): enc/euc_jp.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/euc_jp.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/euc_kr.$(DLEXT): enc/euc_kr.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/euc_kr.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/euc_tw.$(DLEXT): enc/euc_tw.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/euc_tw.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/gb2312.$(DLEXT): enc/gb2312.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/gb2312.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/gb18030.$(DLEXT): enc/gb18030.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/gb18030.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/gbk.$(DLEXT): enc/gbk.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/gbk.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/iso_8859_1.$(DLEXT): enc/iso_8859_1.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/iso_8859_1.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/iso_8859_2.$(DLEXT): enc/iso_8859_2.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/iso_8859_2.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/iso_8859_3.$(DLEXT): enc/iso_8859_3.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/iso_8859_3.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/iso_8859_4.$(DLEXT): enc/iso_8859_4.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/iso_8859_4.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/iso_8859_5.$(DLEXT): enc/iso_8859_5.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/iso_8859_5.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/iso_8859_6.$(DLEXT): enc/iso_8859_6.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/iso_8859_6.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/iso_8859_7.$(DLEXT): enc/iso_8859_7.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/iso_8859_7.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/iso_8859_8.$(DLEXT): enc/iso_8859_8.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/iso_8859_8.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/iso_8859_9.$(DLEXT): enc/iso_8859_9.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/iso_8859_9.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/iso_8859_10.$(DLEXT): enc/iso_8859_10.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/iso_8859_10.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/iso_8859_11.$(DLEXT): enc/iso_8859_11.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/iso_8859_11.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/iso_8859_13.$(DLEXT): enc/iso_8859_13.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/iso_8859_13.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/iso_8859_14.$(DLEXT): enc/iso_8859_14.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/iso_8859_14.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/iso_8859_15.$(DLEXT): enc/iso_8859_15.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/iso_8859_15.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/iso_8859_16.$(DLEXT): enc/iso_8859_16.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/iso_8859_16.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/koi8_r.$(DLEXT): enc/koi8_r.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/koi8_r.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/koi8_u.$(DLEXT): enc/koi8_u.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/koi8_u.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/shift_jis.$(DLEXT): enc/shift_jis.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/shift_jis.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/unicode.$(DLEXT): enc/unicode.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/unicode.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/us_ascii.$(DLEXT): enc/us_ascii.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/us_ascii.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/utf_8.$(DLEXT): enc/utf_8.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/utf_8.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/utf_16be.$(DLEXT): enc/utf_16be.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/utf_16be.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/utf_16le.$(DLEXT): enc/utf_16le.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/utf_16le.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/utf_32be.$(DLEXT): enc/utf_32be.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/utf_32be.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/utf_32le.$(DLEXT): enc/utf_32le.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/utf_32le.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/windows_1251.$(DLEXT): enc/windows_1251.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/windows_1251.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/trans/transdb.$(DLEXT): enc/trans/transdb.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/trans/transdb.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/trans/big5.$(DLEXT): enc/trans/big5.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/trans/big5.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/trans/chinese.$(DLEXT): enc/trans/chinese.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/trans/chinese.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/trans/escape.$(DLEXT): enc/trans/escape.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/trans/escape.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/trans/gb18030.$(DLEXT): enc/trans/gb18030.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/trans/gb18030.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/trans/gbk.$(DLEXT): enc/trans/gbk.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/trans/gbk.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/trans/iso2022.$(DLEXT): enc/trans/iso2022.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/trans/iso2022.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/trans/japanese.$(DLEXT): enc/trans/japanese.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/trans/japanese.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/trans/japanese_euc.$(DLEXT): enc/trans/japanese_euc.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/trans/japanese_euc.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/trans/japanese_sjis.$(DLEXT): enc/trans/japanese_sjis.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/trans/japanese_sjis.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/trans/korean.$(DLEXT): enc/trans/korean.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/trans/korean.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/trans/newline.$(DLEXT): enc/trans/newline.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/trans/newline.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/trans/single_byte.$(DLEXT): enc/trans/single_byte.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/trans/single_byte.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

$(ENCSODIR)/trans/utf_16_32.$(DLEXT): enc/trans/utf_16_32.$(OBJEXT)
	@$(MAKEDIRS) "$(@D)"
	$(LDSHARED) $@ enc/trans/utf_16_32.$(OBJEXT) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)

enc/encdb.$(OBJEXT): enc/encdb.c
enc/ascii.$(OBJEXT): enc/ascii.c
enc/big5.$(OBJEXT): enc/big5.c
enc/cp949.$(OBJEXT): enc/cp949.c
enc/emacs_mule.$(OBJEXT): enc/emacs_mule.c
enc/euc_jp.$(OBJEXT): enc/euc_jp.c
enc/euc_kr.$(OBJEXT): enc/euc_kr.c
enc/euc_tw.$(OBJEXT): enc/euc_tw.c
enc/gb2312.$(OBJEXT): enc/gb2312.c
enc/gb18030.$(OBJEXT): enc/gb18030.c
enc/gbk.$(OBJEXT): enc/gbk.c
enc/iso_8859_1.$(OBJEXT): enc/iso_8859_1.c
enc/iso_8859_2.$(OBJEXT): enc/iso_8859_2.c
enc/iso_8859_3.$(OBJEXT): enc/iso_8859_3.c
enc/iso_8859_4.$(OBJEXT): enc/iso_8859_4.c
enc/iso_8859_5.$(OBJEXT): enc/iso_8859_5.c
enc/iso_8859_6.$(OBJEXT): enc/iso_8859_6.c
enc/iso_8859_7.$(OBJEXT): enc/iso_8859_7.c
enc/iso_8859_8.$(OBJEXT): enc/iso_8859_8.c
enc/iso_8859_9.$(OBJEXT): enc/iso_8859_9.c
enc/iso_8859_10.$(OBJEXT): enc/iso_8859_10.c
enc/iso_8859_11.$(OBJEXT): enc/iso_8859_11.c
enc/iso_8859_13.$(OBJEXT): enc/iso_8859_13.c
enc/iso_8859_14.$(OBJEXT): enc/iso_8859_14.c
enc/iso_8859_15.$(OBJEXT): enc/iso_8859_15.c
enc/iso_8859_16.$(OBJEXT): enc/iso_8859_16.c
enc/koi8_r.$(OBJEXT): enc/koi8_r.c
enc/koi8_u.$(OBJEXT): enc/koi8_u.c
enc/shift_jis.$(OBJEXT): enc/shift_jis.c
enc/unicode.$(OBJEXT): enc/unicode.c
enc/us_ascii.$(OBJEXT): enc/us_ascii.c
enc/utf_8.$(OBJEXT): enc/utf_8.c
enc/utf_16be.$(OBJEXT): enc/utf_16be.c
enc/utf_16le.$(OBJEXT): enc/utf_16le.c
enc/utf_32be.$(OBJEXT): enc/utf_32be.c
enc/utf_32le.$(OBJEXT): enc/utf_32le.c
enc/windows_1251.$(OBJEXT): enc/windows_1251.c
enc/trans/transdb.$(OBJEXT): enc/trans/transdb.c
enc/trans/big5.$(OBJEXT): enc/trans/big5.c
enc/trans/chinese.$(OBJEXT): enc/trans/chinese.c
enc/trans/escape.$(OBJEXT): enc/trans/escape.c
enc/trans/gb18030.$(OBJEXT): enc/trans/gb18030.c
enc/trans/gbk.$(OBJEXT): enc/trans/gbk.c
enc/trans/iso2022.$(OBJEXT): enc/trans/iso2022.c
enc/trans/japanese.$(OBJEXT): enc/trans/japanese.c
enc/trans/japanese_euc.$(OBJEXT): enc/trans/japanese_euc.c
enc/trans/japanese_sjis.$(OBJEXT): enc/trans/japanese_sjis.c
enc/trans/korean.$(OBJEXT): enc/trans/korean.c
enc/trans/newline.$(OBJEXT): enc/trans/newline.c
enc/trans/single_byte.$(OBJEXT): enc/trans/single_byte.c
enc/trans/utf_16_32.$(OBJEXT): enc/trans/utf_16_32.c

enc/encdb.$(OBJEXT): encdb.h
enc/trans/transdb.$(OBJEXT): transdb.h

clean:

clean-srcs:
	@$(RM) $(TRANSCSRCS)
	@-rmdir enc/trans
	@-rmdir enc
