/*
    OpenBack App Inbox React Native Module.

    Copyright © 2018 OpenBack, Ltd. All rights reserved.
*/

package com.openback;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.support.annotation.Nullable;
import android.support.v4.content.LocalBroadcastManager;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.WritableNativeArray;
import com.facebook.react.bridge.WritableNativeMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import java.util.ArrayList;

import static com.openback.OpenBackAppInbox.APP_INBOX_MESSAGE_ADDED;
import static com.openback.OpenBackAppInbox.APP_INBOX_MESSAGE_EXPIRED;
import static com.openback.OpenBackAppInbox.APP_INBOX_MESSAGE_READ;
import static com.openback.OpenBackAppInbox.OPENBACK_APP_INBOX;

public class RNOpenBackAppInboxModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;

    private BroadcastReceiver mMessageReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            String event = intent.getStringExtra("event");
            switch (event) {
                case APP_INBOX_MESSAGE_ADDED:
                    sendEvent(reactContext, "OBKAppInboxMessageAdded", null);
                    break;
                case APP_INBOX_MESSAGE_READ:
                    sendEvent(reactContext, "OBKAppInboxMessageRead", null);
                    break;
                case APP_INBOX_MESSAGE_EXPIRED:
                    sendEvent(reactContext, "OBKAppInboxMessageExpired", null);
                    break;
            }
        }
    };

    public RNOpenBackAppInboxModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
        LocalBroadcastManager.getInstance(reactContext).registerReceiver(mMessageReceiver, new IntentFilter(OPENBACK_APP_INBOX));
    }

    @Override
    public String getName() {
        return "RNOpenBackAppInbox";
    }

    @ReactMethod
    public void getMessageCount(Promise promise) {
        OpenBackAppInbox inbox = OpenBack.appInbox(reactContext);
        promise.resolve(inbox.getMessageCount());
    }

    @ReactMethod
    public void getUnreadMessageCount(Promise promise) {
        OpenBackAppInbox inbox = OpenBack.appInbox(reactContext);
        promise.resolve(inbox.getUnreadMessageCount());
    }

    @ReactMethod
    public void getAllMessages(Promise promise) {
        OpenBackAppInbox inbox = OpenBack.appInbox(reactContext);
        ArrayList<OpenBackAppInboxMessage> messages = inbox.getAllMessages();
        WritableArray rctMessages = convertToRctMessages(messages);
        promise.resolve(rctMessages);
    }

    @ReactMethod
    public void getReadMessages(Promise promise) {
        OpenBackAppInbox inbox = OpenBack.appInbox(reactContext);
        ArrayList<OpenBackAppInboxMessage> messages = inbox.getReadMessages();
        WritableArray rctMessages = convertToRctMessages(messages);
        promise.resolve(rctMessages);
    }

    @ReactMethod
    public void getUnreadMessages(Promise promise) {
        OpenBackAppInbox inbox = OpenBack.appInbox(reactContext);
        ArrayList<OpenBackAppInboxMessage> messages = inbox.getUnreadMessages();
        WritableArray rctMessages = convertToRctMessages(messages);
        promise.resolve(rctMessages);
    }

    @ReactMethod
    public void markMessageAsRead(ReadableMap rctMessage, Promise promise) {
        OpenBackAppInbox inbox = OpenBack.appInbox(reactContext);
        OpenBackAppInboxMessage message = convertToInboxMessage(rctMessage);
        inbox.markMessageAsRead(message);
        promise.resolve(null);
    }

    @ReactMethod
    public void markMessagesAsRead(ReadableArray rctMessages, Promise promise) {
        OpenBackAppInbox inbox = OpenBack.appInbox(reactContext);
        ArrayList<OpenBackAppInboxMessage> messages = convertToInboxMessages(rctMessages);
        inbox.markMessagesAsRead(messages);
        promise.resolve(null);
    }

    @ReactMethod
    public void markAllMessagesAsRead(Promise promise) {
        OpenBackAppInbox inbox = OpenBack.appInbox(reactContext);
        inbox.markAllMessagesAsRead();
        promise.resolve(null);
    }

    @ReactMethod
    public void removeMessage(ReadableMap rctMessage, Promise promise) {
        OpenBackAppInbox inbox = OpenBack.appInbox(reactContext);
        OpenBackAppInboxMessage message = convertToInboxMessage(rctMessage);
        inbox.removeMessage(message);
        promise.resolve(null);
    }

    @ReactMethod
    public void removeMessages(ReadableArray rctMessages, Promise promise) {
        OpenBackAppInbox inbox = OpenBack.appInbox(reactContext);
        ArrayList<OpenBackAppInboxMessage> messages = convertToInboxMessages(rctMessages);
        inbox.removeMessages(messages);
        promise.resolve(null);
    }

    @ReactMethod
    public void removeAllMessages(Promise promise) {
        OpenBackAppInbox inbox = OpenBack.appInbox(reactContext);
        inbox.removeAllMessages();
        promise.resolve(null);
    }

    @ReactMethod
    public void executeMessage(ReadableMap rctMessage, Promise promise) {
        OpenBackAppInbox inbox = OpenBack.appInbox(reactContext);
        OpenBackAppInboxMessage message = convertToInboxMessage(rctMessage);
        inbox.executeMessage(message);
        promise.resolve(null);
    }

    // Events

    private void sendEvent(ReactContext reactContext, String eventName, @Nullable WritableMap params) {
        reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                .emit(eventName, params);
    }

    // Message Conversion

    private WritableArray convertToRctMessages(ArrayList<OpenBackAppInboxMessage> inboxMessages) {
        WritableArray rctMessages = new WritableNativeArray();
        for (OpenBackAppInboxMessage inboxMessage : inboxMessages) {
            WritableMap rctMessage = convertToRctMessage(inboxMessage);
            rctMessages.pushMap(rctMessage);
        }
        return rctMessages;
    }

    private WritableMap convertToRctMessage(OpenBackAppInboxMessage inboxMessage) {
        WritableMap rctMessage = new WritableNativeMap();
        rctMessage.putBoolean("read", inboxMessage.Read);
        rctMessage.putBoolean("actionable", inboxMessage.Actionable);
        rctMessage.putDouble("deliveryTime", inboxMessage.DisplayTime);
        rctMessage.putString("title", inboxMessage.Title);
        rctMessage.putString("content", inboxMessage.Content);
        rctMessage.putString("payload", inboxMessage.Payload);
        rctMessage.putInt("_id", (int)inboxMessage.InboxId);
        return rctMessage;
    }

    private ArrayList<OpenBackAppInboxMessage> convertToInboxMessages(ReadableArray rctMessages) {
        ArrayList<OpenBackAppInboxMessage> messages = new ArrayList<>(rctMessages.size());
        for (Object rctMessage : rctMessages.toArrayList()) {
            if (rctMessage instanceof ReadableMap) {
                OpenBackAppInboxMessage message = convertToInboxMessage((ReadableMap)rctMessage);
                messages.add(message);
            }
        }
        return messages;
    }

    private OpenBackAppInboxMessage convertToInboxMessage(ReadableMap rctMessage) {
        OpenBackAppInboxMessage inboxMessage = new OpenBackAppInboxMessage();
        inboxMessage.InboxId = rctMessage.getInt("_id");
        inboxMessage.Actionable = rctMessage.getBoolean("actionable");
        inboxMessage.Read = rctMessage.getBoolean("read");
        return inboxMessage;
    }
}
