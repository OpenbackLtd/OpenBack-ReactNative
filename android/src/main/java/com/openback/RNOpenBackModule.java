/*
    OpenBack React Native Module.

    Copyright © 2018 OpenBack, Ltd. All rights reserved.
*/

package com.openback;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Nullable;

public class RNOpenBackModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;

    public RNOpenBackModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "RNOpenBack";
    }

    @Nullable
    @Override
    public Map<String, Object> getConstants() {
        final Map<String, Object> constants = new HashMap<>();
        constants.put("kOBKCustomTrigger1", OpenBack.CUSTOM_TRIGGER_1);
        constants.put("kOBKCustomTrigger2", OpenBack.CUSTOM_TRIGGER_2);
        constants.put("kOBKCustomTrigger3", OpenBack.CUSTOM_TRIGGER_3);
        constants.put("kOBKCustomTrigger4", OpenBack.CUSTOM_TRIGGER_4);
        constants.put("kOBKCustomTrigger5", OpenBack.CUSTOM_TRIGGER_5);
        constants.put("kOBKCustomTrigger6", OpenBack.CUSTOM_TRIGGER_6);
        constants.put("kOBKCustomTrigger7", OpenBack.CUSTOM_TRIGGER_7);
        constants.put("kOBKCustomTrigger8", OpenBack.CUSTOM_TRIGGER_8);
        constants.put("kOBKCustomTrigger9", OpenBack.CUSTOM_TRIGGER_9);
        constants.put("kOBKCustomTrigger10", OpenBack.CUSTOM_TRIGGER_10);
        return constants;
    }

    @ReactMethod
    public void sdkVersion(Callback callback) {
        callback.invoke(null, OpenBack.getSdkVersion());
    }

    @ReactMethod
    public void coppaCompliant(Boolean compliant) {
        OpenBack.coppaCompliant(reactContext, compliant);
    }

    @ReactMethod
    public void gdprForgetUser(Boolean forgetUser) {
        OpenBack.gdprForgetUser(reactContext, forgetUser);
    }

    @ReactMethod
    public void logGoal(String goal, int step, double value, Callback callback) {
        OpenBack.logGoal(reactContext, goal, step, value);
        callback.invoke();
    }

    @ReactMethod
    public void setCustomTriggerString(int trigger, String value, Callback callback) {
        OpenBack.setCustomTrigger(reactContext, trigger, value);
        callback.invoke();
    }

    @ReactMethod
    public void setCustomTriggerInteger(int trigger, Integer value, Callback callback) {
        OpenBack.setCustomTrigger(reactContext, trigger, value);
        callback.invoke();
    }

    @ReactMethod
    public void setCustomTriggerFloat(int trigger, Float value, Callback callback) {
        OpenBack.setCustomTrigger(reactContext, trigger, value);
        callback.invoke();
    }

    @ReactMethod
    public  void setUserInfo(ReadableMap userInfo, Callback callback) {
        OpenBack.Config config = new OpenBack.Config(reactContext);
        UserInfoExtra userInfoExtra = new UserInfoExtra();
        if (userInfo.hasKey("addressLine1")) {
            userInfoExtra.AddressLine1 = userInfo.getString("addressLine1");
        }
        if (userInfo.hasKey("addressLine2")) {
            userInfoExtra.AddressLine2 = userInfo.getString("addressLine2");
        }
        if (userInfo.hasKey("advertisingId")) {
            userInfoExtra.AdvertisingId = userInfo.getString("advertisingId");
        }
        if (userInfo.hasKey("age")) {
            userInfoExtra.Age = userInfo.getString("age");
        }
        if (userInfo.hasKey("city")) {
            userInfoExtra.City = userInfo.getString("city");
        }
        if (userInfo.hasKey("country")) {
            userInfoExtra.Country = userInfo.getString("country");
        }
        if (userInfo.hasKey("countryCode")) {
            userInfoExtra.CountryCode  = userInfo.getString("countryCode");
        }
        if (userInfo.hasKey("dateOfBirth")) {
            userInfoExtra.DateOfBirth = userInfo.getString("dateOfBirth");
        }
        if (userInfo.hasKey("firstName")) {
            userInfoExtra.FirstName = userInfo.getString("firstName");
        }
        if (userInfo.hasKey("gender")) {
            userInfoExtra.Gender = userInfo.getString("gender");
        }
        if (userInfo.hasKey("postCode")) {
            userInfoExtra.PostCode = userInfo.getString("postCode");
        }
        if (userInfo.hasKey("profession")) {
            userInfoExtra.Profession = userInfo.getString("profession");
        }
        if (userInfo.hasKey("state")) {
            userInfoExtra.State = userInfo.getString("state");
        }
        if (userInfo.hasKey("surname")) {
            userInfoExtra.Surname = userInfo.getString("surname");
        }
        if (userInfo.hasKey("title")) {
            userInfoExtra.Title = userInfo.getString("title");
        }
        if (userInfo.hasKey("identity1")) {
            userInfoExtra.Identity1 = userInfo.getString("identity1");
        }
        if (userInfo.hasKey("identity2")) {
            userInfoExtra.Identity2 = userInfo.getString("identity2");
        }
        if (userInfo.hasKey("identity3")) {
            userInfoExtra.Identity3 = userInfo.getString("identity3");
        }
        if (userInfo.hasKey("identity4")) {
            userInfoExtra.Identity4 = userInfo.getString("identity4");
        }
        if (userInfo.hasKey("identity5")) {
            userInfoExtra.Identity5 = userInfo.getString("identity5");
        }

        config.setExtraUserInfo(userInfoExtra);

        if (userInfo.hasKey("emailAddress")) {
            config.setUserEmail(userInfo.getString("emailAddress"));
        }
        if (userInfo.hasKey("phoneNumber")) {
            config.setUserMsisdn(userInfo.getString("phoneNumber"));
        }

        try {
            OpenBack.update(config);
            callback.invoke();
        } catch (Exception e) {
            callback.invoke(e.getMessage());
        }
    }
}