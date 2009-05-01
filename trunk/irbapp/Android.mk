LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS:= eng development
LOCAL_PACKAGE_NAME:= irbapp
LOCAL_SRC_FILES:= $(call all-java-files-under, src)
LOCAL_SDK_VERSION:= current
LOCAL_JNI_SHARED_LIBRARIES:= libruby

include $(BUILD_PACKAGE)
