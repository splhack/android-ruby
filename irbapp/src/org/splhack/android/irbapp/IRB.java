package org.splhack.android.irbapp;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.view.KeyEvent;
import android.view.View.OnKeyListener;
import android.widget.EditText;
import android.widget.TextView;

/* -------------------------------------------------------------------------- */
public class IRB extends Activity {
	LibRuby mRuby;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);

		mRuby = new LibRuby((TextView)findViewById(R.id.text_id));

		EditText editText = (EditText)findViewById(R.id.edit_text_id);
		editText.setOnKeyListener(new OnKeyListener() {
			public boolean onKey(View v, int keyCode, KeyEvent event) {
				if (event.getAction() == KeyEvent.ACTION_DOWN &&
						keyCode == KeyEvent.KEYCODE_ENTER) {
					EditText editText = (EditText)v;
					String str = editText.getText().toString();
					mRuby.out("> " + str + "\n");
					mRuby.eval(str);
					editText.setText("");
					return true;
				}
				return false;
			}
		});
	}
}
