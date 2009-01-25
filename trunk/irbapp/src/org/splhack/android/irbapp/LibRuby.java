package org.splhack.android.irbapp;

import android.widget.TextView;
import android.widget.ScrollView;
import android.text.Layout;
import android.util.Log;

public final class LibRuby {
	TextView mTextView;

	static {
		System.loadLibrary("ruby_jni");
	}

	LibRuby(TextView textView) {
		mTextView = textView;
		init();
	}
	synchronized void out(String str) {
		mTextView.append(str.subSequence(0, str.length()));
		ScrollView scrollView = (ScrollView)mTextView.getParent();
		scrollView.scrollTo(0, mTextView.getHeight());
	}

	native void init();
	native void eval(String str);
}
