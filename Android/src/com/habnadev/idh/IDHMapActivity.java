package com.habnadev.idh;


import com.alohar.core.Alohar;
import com.alohar.user.callback.ALMotionListener;
import com.alohar.user.content.ALPlaceManager;
import com.alohar.user.content.data.ALLocation;
import com.alohar.user.content.data.MotionState;

import android.app.Activity;
import android.location.Location;
import android.os.Bundle;
import android.webkit.WebView;
import android.webkit.WebViewClient;


public class IDHMapActivity extends Activity implements ALMotionListener		{
//	private static final String MAP_URL = "http://gmaps-samples.googlecode.com/svn/trunk/articles-android-webmap/simple-android-map.html
	private static final String MAP_URL = "file:///android_asset/map_site.html";
	private static Location mostRecentLocation;
	private WebView webView;
	private Alohar alohar;
	private ALLocation curLoc;
	
	@Override
	public void onCreate(Bundle bundle)	{
		super.onCreate(bundle);
		setContentView(R.layout.activity_idhmap);
		alohar = Alohar.getInstance();
		getLocation();
		setupWebView();
	}	
	
	private void setupWebView()	{
		
		webView = (WebView) findViewById(R.id.webview);
		webView.getSettings().setJavaScriptEnabled(true);
		webView.setWebViewClient(new WebViewClient());
		webView.loadUrl(MAP_URL);
		webView.addJavascriptInterface(new JavaScriptInterface(),"android");
	}

	private class JavaScriptInterface {
		
		public double getLatitude(){
			return mostRecentLocation.getLatitude();
		}
		public double getLongitude(){
		  return mostRecentLocation.getLongitude();
		}
	}
	
	private void getLocation()	{
		ALPlaceManager alpm = alohar.getPlaceManager();
		curLoc = alpm.getCurrentLocation();
		mostRecentLocation.setLatitude(curLoc.getLatitude());
		mostRecentLocation.setLongitude(curLoc.getLongitude());	
	}
	
/*	private void getLocation()	{
		LocationManager locationManager = (LocationManager)getSystemService(Context.LOCATION_SERVICE);
		Criteria criteria = new Criteria();
		criteria.setAccuracy(Criteria.ACCURACY_FINE);
		String provider = locationManager.getBestProvider(criteria,true);
		locationManager.requestLocationUpdates(provider,1,0,this);
		mostRecentLocation = locationManager.getLastKnownLocation(provider);
		mostRecentLocation.setLatitude(40.7139);
		mostRecentLocation.setLongitude(73.5594);
	}*/
    
 /*   @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.activity_idhmap, menu);
        
        SearchManager searchManager = (SearchManager) getSystemService(Context.SEARCH_SERVICE);
        SearchView searchView = (SearchView) menu.findItem(R.id.searchBar).getActionView();
        searchView.setSearchableInfo(searchManager.getSearchableInfo(getComponentName()));
        searchView.setIconifiedByDefault(false);
        
        return true;
    }*/

	public void onMotionStateChanged(MotionState arg0, MotionState arg1) {
		ALPlaceManager alpm = alohar.getPlaceManager();
		curLoc = alpm.getCurrentLocation();
		mostRecentLocation.setLatitude(curLoc.getLatitude());
		mostRecentLocation.setLongitude(curLoc.getLongitude());
	}

}