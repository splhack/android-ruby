/*
 * Copyright (C) 2008 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "ruby_jni"
#include "JNIHelp.h"
#include "ruby.h"

#include <stdio.h>
#include <assert.h>

/* -------------------------------------------------------------------------- */
static JavaVM *sJavaVM;
static jobject sListener;

/* -------------------------------------------------------------------------- */
static VALUE libruby_out(VALUE self, VALUE rstr)
{
	char *str = StringValueCStr(rstr);
	LOGV("out[%s]\n", str);

	JNIEnv *env;
	sJavaVM->AttachCurrentThread(&env, NULL);
	jclass clazz = env->GetObjectClass(sListener);
	jmethodID out = env->GetMethodID(clazz, "out", "(Ljava/lang/String;)V");
	env->CallVoidMethod(sListener, out, env->NewStringUTF(str));

	return Qnil;
}

/* -------------------------------------------------------------------------- */
static void libruby_init(JNIEnv* env, jobject me)
{
	sListener = env->NewGlobalRef(me);
}

/* -------------------------------------------------------------------------- */
static void libruby_eval(JNIEnv* env, jobject me, jstring jstr)
{
	const char *str = env->GetStringUTFChars(jstr, NULL);
	LOGV("eval[%s]\n", str);

	static bool initialized = false;
	if (!initialized) {
		int argc = 1;
		char *argv[1];
		argv[0] = "appirb";
		ruby_init();
		ruby_options(argc, argv);
		rb_define_global_function(
			"libruby_out", RUBY_METHOD_FUNC(libruby_out), 1);
		rb_eval_string_protect(
			"class MockStream\n"
				"def write(x)\n"
					"libruby_out(x)\n"
				"end\n"
				"def flush()\n"
				"end\n"
			"end\n"
			"$stdout = MockStream.new()\n"
			"$stderr = MockStream.new()\n", 0);
		initialized = true;
	}

	int state;
	rb_eval_string_protect(str, &state);

	env->ReleaseStringUTFChars(jstr, str);

	if (state)
		rb_p(rb_eval_string_protect("$!", 0));
}

/* -------------------------------------------------------------------------- */
static const JNINativeMethod gMethods[] = {
	{ "init",
		 "()V",
		 (void*)libruby_init},
	{ "eval",
		 "(Ljava/lang/String;)V",
		 (void*)libruby_eval},
};

/* -------------------------------------------------------------------------- */
jint JNI_OnLoad(JavaVM* vm, void* reserved)
{
    static const char* const kClassName = "org/splhack/android/irbapp/LibRuby";
    JNIEnv* env = NULL;
    jint result = -1;

    sJavaVM = vm;

    if (vm->GetEnv((void**) &env, JNI_VERSION_1_4) != JNI_OK) {
        LOGE("ERROR: GetEnv failed\n");
        goto bail;
    }
    assert(env != NULL);

    if (jniRegisterNativeMethods(
			env, kClassName, gMethods, NELEM(gMethods)) != 0) {
        LOGE("ERROR: LibRuby native registration failed\n");
        goto bail;
    }

    result = JNI_VERSION_1_4;

bail:
    return result;
}
