package com.habnadev.idh;

import com.alohar.core.Alohar;
import com.alohar.user.callback.ALEventListener;
import com.alohar.user.content.ALMotionManager;
import com.alohar.user.content.ALPlaceManager;
import com.alohar.user.content.data.ALEvents;

import android.app.Activity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;

public class MainActivity extends Activity	{

	private static final int ALOHAR_APP_ID = 245;
	private static final String ALOHAR_API_KEY = "50f8f7ca3121fb897eb8f9877737ebf662af5480";
	private static Button btn1;
	Alohar aloharInst;
	private static final String PREF_KEY = "uid";
	SharedPreferences prefs;
	public String uid;
	ALPlaceManager placeMan;
	ALMotionManager motionMan;
	

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		
		prefs = PreferenceManager.getDefaultSharedPreferences(this);
		
		aloharInst = Alohar.init(getApplication());
		placeMan = aloharInst.getPlaceManager();
		
		
/*		alohar.register(ALOHAR_APP_ID, ALOHAR_API_KEY, new ALEventListener() {
			public void handleEvent(ALEvents arg0, Object arg1) {
				if (arg0 == ALEvents.REGISTRATION_CALLBACK) {
					if (arg1 instanceof String) {
						uid = (String) arg1;
					}
				} else if (arg0 == ALEvents.GENERAL_ERROR_CALLBACK
						|| arg0 == ALEvents.SERVER_ERROR_CALLBACK) {
					return;
				}
			}
		});*/
		aloharInst.startServices();

		btn1 = (Button) findViewById(R.id.button1);
		btn1.setOnClickListener(new View.OnClickListener() {
			public void onClick(View v) {
				// to map view
				Intent i = new Intent(btn1.getContext(), IDHMapActivity.class);
				startActivity(i);
			}
		});
	}
}
