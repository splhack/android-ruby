LOCAL_PATH:= $(call my-dir)

RUBY_TOP:= ruby

RUBY_INSTALL_PATH:= $(TARGET_OUT)/lib/ruby
RUBY_SCRIPT_PATH:= $(LOCAL_PATH)/$(RUBY_TOP)/.ext/common

RUBY_C_INCLUDE:= \
	external/openssl/include \
	external/zlib \
	$(LOCAL_PATH)/$(RUBY_TOP) \
	$(LOCAL_PATH)/$(RUBY_TOP)/.ext/include/$(TARGET_ARCH)-linux \
	$(LOCAL_PATH)/$(RUBY_TOP)/include

RUBY_CFLAGS+= \
	-DHAVE_GETCWD \
	-DHAVE_FORK \
	-DOPENSSL_NO_STATIC_ENGINE \
	-include fcntl.h \
	-include stdio.h \
	-include sys/mman.h \
	-include unistd.h

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)

LOCAL_MODULE:= libruby

LOCAL_SRC_FILES:= \
	$(RUBY_TOP)/dln.c \
	$(RUBY_TOP)/encoding.c \
	$(RUBY_TOP)/prelude.c \
	$(RUBY_TOP)/array.c \
	$(RUBY_TOP)/bignum.c \
	$(RUBY_TOP)/class.c \
	$(RUBY_TOP)/compar.c \
	$(RUBY_TOP)/complex.c \
	$(RUBY_TOP)/dir.c \
	$(RUBY_TOP)/enum.c \
	$(RUBY_TOP)/enumerator.c \
	$(RUBY_TOP)/error.c \
	$(RUBY_TOP)/eval.c \
	$(RUBY_TOP)/load.c \
	$(RUBY_TOP)/proc.c \
	$(RUBY_TOP)/file.c \
	$(RUBY_TOP)/gc.c \
	$(RUBY_TOP)/hash.c \
	$(RUBY_TOP)/inits.c \
	$(RUBY_TOP)/io.c \
	$(RUBY_TOP)/marshal.c \
	$(RUBY_TOP)/math.c \
	$(RUBY_TOP)/numeric.c \
	$(RUBY_TOP)/object.c \
	$(RUBY_TOP)/pack.c \
	$(RUBY_TOP)/parse.c \
	$(RUBY_TOP)/process.c \
	$(RUBY_TOP)/random.c \
	$(RUBY_TOP)/range.c \
	$(RUBY_TOP)/rational.c \
	$(RUBY_TOP)/re.c \
	$(RUBY_TOP)/regcomp.c \
	$(RUBY_TOP)/regenc.c \
	$(RUBY_TOP)/regerror.c \
	$(RUBY_TOP)/regexec.c \
	$(RUBY_TOP)/regparse.c \
	$(RUBY_TOP)/regsyntax.c \
	$(RUBY_TOP)/ruby.c \
	$(RUBY_TOP)/safe.c \
	$(RUBY_TOP)/signal.c \
	$(RUBY_TOP)/sprintf.c \
	$(RUBY_TOP)/st.c \
	$(RUBY_TOP)/strftime.c \
	$(RUBY_TOP)/string.c \
	$(RUBY_TOP)/struct.c \
	$(RUBY_TOP)/time.c \
	$(RUBY_TOP)/transcode.c \
	$(RUBY_TOP)/util.c \
	$(RUBY_TOP)/variable.c \
	$(RUBY_TOP)/version.c \
	$(RUBY_TOP)/compile.c \
	$(RUBY_TOP)/debug.c \
	$(RUBY_TOP)/iseq.c \
	$(RUBY_TOP)/vm.c \
	$(RUBY_TOP)/vm_dump.c \
	$(RUBY_TOP)/thread.c \
	$(RUBY_TOP)/cont.c \
	$(RUBY_TOP)/enc/ascii.c \
	$(RUBY_TOP)/enc/us_ascii.c \
	$(RUBY_TOP)/enc/unicode.c \
	$(RUBY_TOP)/enc/utf_8.c \
	$(RUBY_TOP)/newline.c \
	$(RUBY_TOP)/missing/memcmp.c \
	$(RUBY_TOP)/missing/dup2.c \
	$(RUBY_TOP)/missing/crypt.c \
	$(RUBY_TOP)/missing/flock.c \
	$(RUBY_TOP)/dmyext.c

LOCAL_SHARED_LIBRARIES:= \
	libdl

LOCAL_C_INCLUDES+= \
	$(RUBY_C_INCLUDE)

LOCAL_CFLAGS+= \
	$(RUBY_CFLAGS) \
	-DRUBY_EXPORT

LOCAL_PRELINK_MODULE:= false

include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)

copy_from:= \
	bigdecimal/jacobian.rb \
	bigdecimal/ludcmp.rb \
	bigdecimal/math.rb \
	bigdecimal/newton.rb \
	bigdecimal/util.rb \
	digest.rb \
	digest/hmac.rb \
	digest/sha2.rb \
	dl/callback.rb \
	dl/cparser.rb \
	dl/func.rb \
	dl/import.rb \
	dl/pack.rb \
	dl/stack.rb \
	dl/struct.rb \
	dl/types.rb \
	dl/value.rb \
	expect.rb \
	io/nonblock.rb \
	json.rb \
	json/add/core.rb \
	json/add/rails.rb \
	json/common.rb \
	json/editor.rb \
	json/ext.rb \
	json/pure.rb \
	json/pure/generator.rb \
	json/pure/parser.rb \
	json/version.rb \
	kconv.rb \
	openssl.rb \
	openssl/bn.rb \
	openssl/buffering.rb \
	openssl/cipher.rb \
	openssl/digest.rb \
	openssl/ssl.rb \
	openssl/x509.rb \
	ripper.rb \
	ripper/core.rb \
	ripper/filter.rb \
	ripper/lexer.rb \
	ripper/sexp.rb

copy_to:= $(addprefix $(RUBY_INSTALL_PATH)/,$(copy_from))
copy_from:= $(addprefix $(RUBY_SCRIPT_PATH)/,$(copy_from))

$(copy_to): $(RUBY_INSTALL_PATH)/% : $(RUBY_SCRIPT_PATH)/% | $(ACP)
	$(transform-prebuilt-to-target)

ALL_PREBUILT += $(copy_to)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/encdb
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/encdb.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/big5
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/big5.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/cp949
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/cp949.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/emacs_mule
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/emacs_mule.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/euc_jp
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/euc_jp.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/euc_kr
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/euc_kr.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/euc_tw
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/euc_tw.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/gb2312
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/gb2312.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/gb18030
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/gb18030.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/gbk
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/gbk.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/iso_8859_1
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/iso_8859_1.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/iso_8859_2
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/iso_8859_2.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/iso_8859_3
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/iso_8859_3.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/iso_8859_4
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/iso_8859_4.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/iso_8859_5
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/iso_8859_5.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/iso_8859_6
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/iso_8859_6.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/iso_8859_7
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/iso_8859_7.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/iso_8859_8
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/iso_8859_8.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/iso_8859_9
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/iso_8859_9.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/iso_8859_10
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/iso_8859_10.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/iso_8859_11
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/iso_8859_11.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/iso_8859_13
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/iso_8859_13.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/iso_8859_14
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/iso_8859_14.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/iso_8859_15
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/iso_8859_15.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/iso_8859_16
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/iso_8859_16.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/koi8_r
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/koi8_r.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/koi8_u
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/koi8_u.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/shift_jis
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/shift_jis.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/utf_16be
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/utf_16be.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/utf_16le
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/utf_16le.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/utf_32be
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/utf_32be.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/utf_32le
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/utf_32le.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/windows_1251
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/windows_1251.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/trans/transdb
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/trans/transdb.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/trans/big5
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/trans/big5.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/trans/chinese
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/trans/chinese.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/trans/escape
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/trans/escape.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/trans/gb18030
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/trans/gb18030.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/trans/gbk
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/trans/gbk.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/trans/iso2022
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/trans/iso2022.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/trans/japanese
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/trans/japanese.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/trans/japanese_euc
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/trans/japanese_euc.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/trans/japanese_sjis
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/trans/japanese_sjis.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/trans/korean
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/trans/korean.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/trans/single_byte
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/trans/single_byte.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/enc/trans/utf_16_32
LOCAL_SRC_FILES:= $(RUBY_TOP)/enc/trans/utf_16_32.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DONIG_ENC_REGISTER=rb_enc_register
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/bigdecimal
LOCAL_SRC_FILES:= $(RUBY_TOP)/ext/bigdecimal/bigdecimal.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) $(LOCAL_PATH)/$(RUBY_TOP)/ext/bigdecimal
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/continuation
LOCAL_SRC_FILES:= $(RUBY_TOP)/ext/continuation/continuation.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) $(LOCAL_PATH)/$(RUBY_TOP)/ext/continuation
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/coverage
LOCAL_SRC_FILES:= $(RUBY_TOP)/ext/coverage/coverage.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) $(LOCAL_PATH)/$(RUBY_TOP)/ext/coverage
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/digest
LOCAL_SRC_FILES:= $(RUBY_TOP)/ext/digest/digest.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) $(LOCAL_PATH)/$(RUBY_TOP)/ext/digest
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/digest/bubblebabble
LOCAL_SRC_FILES:= $(RUBY_TOP)/ext/digest/bubblebabble/bubblebabble.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) \
	$(LOCAL_PATH)/$(RUBY_TOP)/ext/digest \
	$(LOCAL_PATH)/$(RUBY_TOP)/ext/digest/bubblebabble
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/digest/md5
LOCAL_SRC_FILES:= \
	$(RUBY_TOP)/ext/digest/md5/md5init.c \
	$(RUBY_TOP)/ext/digest/md5/md5ossl.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) \
	$(LOCAL_PATH)/$(RUBY_TOP)/ext/digest/md5 \
	$(LOCAL_PATH)/$(RUBY_TOP)/ext/digest
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/digest/rmd160
LOCAL_SRC_FILES:= \
	$(RUBY_TOP)/ext/digest/rmd160/rmd160init.c \
	$(RUBY_TOP)/ext/digest/rmd160/rmd160ossl.c
LOCAL_SHARED_LIBRARIES:= libruby libcrypto
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) \
	$(LOCAL_PATH)/$(RUBY_TOP)/ext/digest/rmd160 \
	$(LOCAL_PATH)/$(RUBY_TOP)/ext/digest
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/digest/sha1
LOCAL_SRC_FILES:= \
	$(RUBY_TOP)/ext/digest/sha1/sha1init.c \
	$(RUBY_TOP)/ext/digest/sha1/sha1ossl.c
LOCAL_SHARED_LIBRARIES:= libruby libcrypto
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) \
	$(LOCAL_PATH)/$(RUBY_TOP)/ext/digest/sha1 \
	$(LOCAL_PATH)/$(RUBY_TOP)/ext/digest
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/digest/sha2
LOCAL_SRC_FILES:= \
	$(RUBY_TOP)/ext/digest/sha2/sha2.c \
	$(RUBY_TOP)/ext/digest/sha2/sha2init.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) \
	$(LOCAL_PATH)/$(RUBY_TOP)/ext/digest/sha2 \
	$(LOCAL_PATH)/$(RUBY_TOP)/ext/digest
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/dl
LOCAL_SRC_FILES:= \
	$(RUBY_TOP)/ext/dl/cfunc.c \
	$(RUBY_TOP)/ext/dl/dl.c \
	$(RUBY_TOP)/ext/dl/cptr.c \
	$(RUBY_TOP)/ext/dl/handle.c \
	$(RUBY_TOP)/ext/dl/callback-0.c \
	$(RUBY_TOP)/ext/dl/callback-1.c \
	$(RUBY_TOP)/ext/dl/callback-2.c \
	$(RUBY_TOP)/ext/dl/callback-3.c \
	$(RUBY_TOP)/ext/dl/callback-4.c \
	$(RUBY_TOP)/ext/dl/callback-5.c \
	$(RUBY_TOP)/ext/dl/callback-6.c \
	$(RUBY_TOP)/ext/dl/callback-7.c \
	$(RUBY_TOP)/ext/dl/callback-8.c
LOCAL_SHARED_LIBRARIES:= libruby libdl
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) $(LOCAL_PATH)/$(RUBY_TOP)/ext/dl
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/etc
LOCAL_SRC_FILES:= $(RUBY_TOP)/ext/etc/etc.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) $(LOCAL_PATH)/$(RUBY_TOP)/ext/etc
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/fcntl
LOCAL_SRC_FILES:= $(RUBY_TOP)/ext/fcntl/fcntl.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) $(LOCAL_PATH)/$(RUBY_TOP)/ext/fcntl
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/fiber
LOCAL_SRC_FILES:= $(RUBY_TOP)/ext/fiber/fiber.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) $(LOCAL_PATH)/$(RUBY_TOP)/ext/fiber
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/io/wait
LOCAL_SRC_FILES:= $(RUBY_TOP)/ext/io/wait/wait.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) $(LOCAL_PATH)/$(RUBY_TOP)/ext/io/wait
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/json/ext/generator
LOCAL_SRC_FILES:= \
	$(RUBY_TOP)/ext/json/ext/generator/unicode.c \
	$(RUBY_TOP)/ext/json/ext/generator/generator.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) \
	$(LOCAL_PATH)/$(RUBY_TOP)/ext/json/ext/generator
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/json/ext/parser
LOCAL_SRC_FILES:= \
	$(RUBY_TOP)/ext/json/ext/parser/parser.c \
	$(RUBY_TOP)/ext/json/ext/parser/unicode.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) \
	$(LOCAL_PATH)/$(RUBY_TOP)/ext/json/ext/parser
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/mathn/complex
LOCAL_SRC_FILES:= $(RUBY_TOP)/ext/mathn/complex/complex.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) \
	$(LOCAL_PATH)/$(RUBY_TOP)/ext/mathn/complex
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/mathn/rational
LOCAL_SRC_FILES:= $(RUBY_TOP)/ext/mathn/rational/rational.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) \
	$(LOCAL_PATH)/$(RUBY_TOP)/ext/mathn/rational
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/nkf
LOCAL_SRC_FILES:= $(RUBY_TOP)/ext/nkf/nkf.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) $(LOCAL_PATH)/$(RUBY_TOP)/ext/nkf
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/openssl
LOCAL_SRC_FILES:= \
	$(RUBY_TOP)/ext/openssl/ossl_bn.c \
	$(RUBY_TOP)/ext/openssl/ossl_ocsp.c \
	$(RUBY_TOP)/ext/openssl/ossl_pkey.c \
	$(RUBY_TOP)/ext/openssl/ossl_pkey_rsa.c \
	$(RUBY_TOP)/ext/openssl/ossl_pkcs5.c \
	$(RUBY_TOP)/ext/openssl/ossl_pkcs7.c \
	$(RUBY_TOP)/ext/openssl/ossl_bio.c \
	$(RUBY_TOP)/ext/openssl/ossl_digest.c \
	$(RUBY_TOP)/ext/openssl/openssl_missing.c \
	$(RUBY_TOP)/ext/openssl/ossl_x509store.c \
	$(RUBY_TOP)/ext/openssl/ossl_pkey_dsa.c \
	$(RUBY_TOP)/ext/openssl/ossl_x509name.c \
	$(RUBY_TOP)/ext/openssl/ossl_x509.c \
	$(RUBY_TOP)/ext/openssl/ossl_ssl_session.c \
	$(RUBY_TOP)/ext/openssl/ossl_x509req.c \
	$(RUBY_TOP)/ext/openssl/ossl_cipher.c \
	$(RUBY_TOP)/ext/openssl/ossl_x509crl.c \
	$(RUBY_TOP)/ext/openssl/ossl_pkey_ec.c \
	$(RUBY_TOP)/ext/openssl/ossl_pkey_dh.c \
	$(RUBY_TOP)/ext/openssl/ossl_ns_spki.c \
	$(RUBY_TOP)/ext/openssl/ossl_x509revoked.c \
	$(RUBY_TOP)/ext/openssl/ossl_hmac.c \
	$(RUBY_TOP)/ext/openssl/ossl_rand.c \
	$(RUBY_TOP)/ext/openssl/ossl_x509attr.c \
	$(RUBY_TOP)/ext/openssl/ossl_x509ext.c \
	$(RUBY_TOP)/ext/openssl/ossl.c \
	$(RUBY_TOP)/ext/openssl/ossl_config.c \
	$(RUBY_TOP)/ext/openssl/ossl_ssl.c \
	$(RUBY_TOP)/ext/openssl/ossl_engine.c \
	$(RUBY_TOP)/ext/openssl/ossl_pkcs12.c \
	$(RUBY_TOP)/ext/openssl/ossl_asn1.c \
	$(RUBY_TOP)/ext/openssl/ossl_x509cert.c \
	$(RUBY_TOP)/ext/openssl/bn_depr.c \
	$(RUBY_TOP)/ext/openssl/rsa_depr.c
LOCAL_SHARED_LIBRARIES:= libruby libssl libcrypto
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) $(LOCAL_PATH)/$(RUBY_TOP)/ext/openssl
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/pty
LOCAL_SRC_FILES:= $(RUBY_TOP)/ext/pty/pty.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) $(LOCAL_PATH)/$(RUBY_TOP)/ext/pty
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/racc/cparse
LOCAL_SRC_FILES:= $(RUBY_TOP)/ext/racc/cparse/cparse.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) $(LOCAL_PATH)/$(RUBY_TOP)/ext/racc/cparse
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/ripper
LOCAL_SRC_FILES:= $(RUBY_TOP)/ext/ripper/ripper.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) $(LOCAL_PATH)/$(RUBY_TOP)/ext/ripper
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/sdbm
LOCAL_SRC_FILES:= \
	$(RUBY_TOP)/ext/sdbm/init.c \
	$(RUBY_TOP)/ext/sdbm/_sdbm.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) $(LOCAL_PATH)/$(RUBY_TOP)/ext/sdbm
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/socket
LOCAL_SRC_FILES:= $(RUBY_TOP)/ext/socket/socket.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) $(LOCAL_PATH)/$(RUBY_TOP)/ext/socket
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/stringio
LOCAL_SRC_FILES:= $(RUBY_TOP)/ext/stringio/stringio.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) $(LOCAL_PATH)/$(RUBY_TOP)/ext/stringio
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/strscan
LOCAL_SRC_FILES:= $(RUBY_TOP)/ext/strscan/strscan.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) $(LOCAL_PATH)/$(RUBY_TOP)/ext/strscan
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/syck
LOCAL_SRC_FILES:= \
	$(RUBY_TOP)/ext/syck/handler.c \
	$(RUBY_TOP)/ext/syck/rubyext.c \
	$(RUBY_TOP)/ext/syck/syck.c \
	$(RUBY_TOP)/ext/syck/bytecode.c \
	$(RUBY_TOP)/ext/syck/emitter.c \
	$(RUBY_TOP)/ext/syck/node.c \
	$(RUBY_TOP)/ext/syck/gram.c \
	$(RUBY_TOP)/ext/syck/token.c \
	$(RUBY_TOP)/ext/syck/yaml2byte.c \
	$(RUBY_TOP)/ext/syck/implicit.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) $(LOCAL_PATH)/$(RUBY_TOP)/ext/syck
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/syslog
LOCAL_SRC_FILES:= $(RUBY_TOP)/ext/syslog/syslog.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) $(LOCAL_PATH)/$(RUBY_TOP)/ext/syslog
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= ruby/$(TARGET_ARCH)-linux/zlib
LOCAL_SRC_FILES:= $(RUBY_TOP)/ext/zlib/zlib.c
LOCAL_SHARED_LIBRARIES:= libruby libz
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE) $(LOCAL_PATH)/$(RUBY_TOP)/ext/zlib
LOCAL_CFLAGS+= $(RUBY_CFLAGS) -DRUBY_EXTCONF_H=\"extconf.h\"
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)

# ------------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE:= cruby
LOCAL_SRC_FILES:= $(RUBY_TOP)/main.c
LOCAL_SHARED_LIBRARIES:= libruby
LOCAL_C_INCLUDES+= $(RUBY_C_INCLUDE)
LOCAL_CFLAGS+= $(RUBY_CFLAGS)
include $(BUILD_EXECUTABLE)
