//INSTRUCTIONS:
/*
//Store String "TestValue" in the key "testKey" -> successCallbackT returns "OK" or "WRONG PARAMETERS"
window.plugins.sharedConfigurations.addSharedConfigEntry("testKey", "TestValue", successCallbackT, errorCallbackT);

//Retrieve String stored in "testKey" -> successCallbackT returns String stored or ""
window.plugins.sharedConfigurations.getSharedConfigEntry("testKey", successCallbackT, errorCallbackT);
*/

cordova.define("com.hecticus.cordova.plugins.sharedconfigurations", function(require, exports, module) { var SharedConfigurations = function() {
};


// Call this to register for push notifications. Content of [options] depends on whether we are working with APNS (iOS) or GCM (Android)
SharedConfigurations.prototype.addSharedConfigEntry = function(configKey, value, successCallback, errorCallback) {
    console.log("PASO!!!");
	if (errorCallback == null) { errorCallback = function() {}}

    if (typeof errorCallback != "function")  {
        console.log("SharedConfigurations.addSharedConfigEntry failure: failure parameter not a function");
        return
    }

    if (typeof successCallback != "function") {
        console.log("SharedConfigurations.addSharedConfigEntry failure: success callback parameter must be a function");
        return
    }

    cordova.exec(successCallback, errorCallback, "SharedConfigurations", "addSharedConfigEntry", 
    		[{ // and this array of custom arguments to create our entry
                "configKey": configKey,
                "value": value
            }]);
};

// Call this to unregister for push notifications
SharedConfigurations.prototype.getSharedConfigEntry = function(configKey, successCallback, errorCallback) {
    if (errorCallback == null) { errorCallback = function() {}}

    if (typeof errorCallback != "function")  {
        console.log("SharedConfigurations.getSharedConfigEntry failure: failure parameter not a function");
        return
    }

    if (typeof successCallback != "function") {
        console.log("SharedConfigurations.getSharedConfigEntry failure: success callback parameter must be a function");
        return
    }

     cordova.exec(successCallback, errorCallback, "SharedConfigurations", "getSharedConfigEntry", 
     		[{ // and this array of custom arguments to create our entry
                "configKey": configKey
            }]);
};

//-------------------------------------------------------------------

if(!window.plugins) {
    window.plugins = {};
}
if (!window.plugins.sharedConfigurations) {
    window.plugins.sharedConfigurations = new SharedConfigurations();
}

if (module.exports) {
  module.exports = SharedConfigurations;
}
});
