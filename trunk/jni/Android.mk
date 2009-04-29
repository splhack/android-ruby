LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE:= libruby_jni

LOCAL_SRC_FILES:= \
	libruby_jni.cpp

LOCAL_SHARED_LIBRARIES:= \
	libandroid_runtime \
	libnativehelper \
	libcutils \
	libutils \
	libdl

LOCAL_STATIC_LIBRARIES:= \
	libruby

RUBY_TOP:= ruby
LOCAL_C_INCLUDES+= \
	$(JNI_H_INCLUDE) \
	$(LOCAL_PATH)/../lib/$(RUBY_TOP)/include \
	$(LOCAL_PATH)/../lib/$(RUBY_TOP)/.ext/include/arm-linux

LOCAL_PRELINK_MODULE:= false

include $(BUILD_SHARED_LIBRARY)
