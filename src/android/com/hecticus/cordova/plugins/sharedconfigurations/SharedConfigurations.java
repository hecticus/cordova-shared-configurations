package com.hecticus.cordova.plugins.sharedconfigurations;
 
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONObject;
import org.json.JSONArray;
import org.json.JSONException;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;

public class SharedConfigurations extends CordovaPlugin {
	public static final String TAG = "SharedConfigurations";
	
	public static final String ACTION_ADD_CONFIG_ENTRY = "addSharedConfigEntry";
	public static final String ACTION_GET_CONFIG_ENTRY = "getSharedConfigEntry";

	@Override
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		try {
			Log.v(TAG, "SharedConfigurations execute: action=" + action);
		    if (ACTION_ADD_CONFIG_ENTRY.equals(action)) { 
		        JSONObject arg_object = args.getJSONObject(0);
		        SharedPreferences sharedPref = this.cordova.getActivity().getPreferences(Context.MODE_PRIVATE);
		        SharedPreferences.Editor editor = sharedPref.edit();
		        editor.putString(arg_object.getString("configKey"), arg_object.getString("value"));
		        editor.commit();
		        callbackContext.success();
		        return true;
		    } else if (ACTION_GET_CONFIG_ENTRY.equals(action)) {
		    	JSONObject arg_object = args.getJSONObject(0);
		        SharedPreferences sharedPref = this.cordova.getActivity().getPreferences(Context.MODE_PRIVATE);
		        String getValue = sharedPref.getString(arg_object.getString("configKey"),"");
		        callbackContext.success(getValue);
		        return true;
		    }
		    callbackContext.error("Invalid action");
		    return false;
		} catch(Exception e) {
		    System.err.println("Exception: " + e.getMessage());
		    callbackContext.error(e.getMessage());
		    return false;
		} 
	}
}