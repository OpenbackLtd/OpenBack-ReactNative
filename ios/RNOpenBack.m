/**
 * OpenBack React Native Module for iOS
 *
 * Copyright © 2019 OpenBack, Ltd. All rights reserved.
 */

#import "RNOpenBack.h"

#if __has_include(<React/RCTConvert.h>)
  #import <React/RCTConvert.h>
#elif __has_include("React/RCTConvert.h")
  #import "React/RCTConvert.h"
#else
  #import "RCTConvert.h"
#endif

#import <OpenBack/OpenBack.h>

@implementation RCTConvert (OpenBack)

RCT_ENUM_CONVERTER(OBKCustomTriggerType,
   (@{ @"kOBKCustomTrigger1" : @(kOBKCustomTrigger1),
       @"kOBKCustomTrigger2" : @(kOBKCustomTrigger2),
       @"kOBKCustomTrigger3" : @(kOBKCustomTrigger3),
       @"kOBKCustomTrigger4" : @(kOBKCustomTrigger4),
       @"kOBKCustomTrigger5" : @(kOBKCustomTrigger5),
       @"kOBKCustomTrigger6" : @(kOBKCustomTrigger6),
       @"kOBKCustomTrigger7" : @(kOBKCustomTrigger7),
       @"kOBKCustomTrigger8" : @(kOBKCustomTrigger8),
       @"kOBKCustomTrigger9" : @(kOBKCustomTrigger9),
       @"kOBKCustomTrigger10" : @(kOBKCustomTrigger10)
    }),
   kOBKCustomTrigger1, integerValue)

@end

@implementation RNOpenBack

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(sdkVersion:(RCTResponseSenderBlock)callback) {
    callback(@[[NSNull null], kOBKFrameworkVersion]);
}

RCT_EXPORT_METHOD(coppaCompliant:(BOOL)compliant) {
    [OpenBack coppaCompliant:compliant];
}

RCT_EXPORT_METHOD(gdprForgetUser:(BOOL)forgetUser) {
    [OpenBack gdprForgetUser:forgetUser error:nil];
}

RCT_EXPORT_METHOD(logGoal:(NSString*)goal step:(NSUInteger)step value:(double)value callback:(RCTResponseSenderBlock)callback) {
    NSError *error = nil;
    if (![OpenBack logGoal:goal step:step value:value error:&error]) {
        callback(@[RCTMakeError(error.localizedDescription, nil, nil)]);
    }
}

RCT_EXPORT_METHOD(setCustomTriggerString:(OBKCustomTriggerType)trigger value:(NSString *)value callback:(RCTResponseSenderBlock)callback) {
    NSError *error = nil;
    if (![OpenBack setValue:value forCustomTrigger:trigger error:&error]) {
        callback(@[RCTMakeError(error.localizedDescription, nil, nil)]);
    }
}

RCT_EXPORT_METHOD(setCustomTriggerInteger:(OBKCustomTriggerType)trigger value:(NSInteger)value callback:(RCTResponseSenderBlock)callback) {
    NSError *error = nil;
    if (![OpenBack setValue:[NSNumber numberWithInteger:value] forCustomTrigger:trigger error:&error]) {
        callback(@[RCTMakeError(error.localizedDescription, nil, nil)]);
    }
}

RCT_EXPORT_METHOD(setCustomTriggerFloat:(OBKCustomTriggerType)trigger value:(float)value callback:(RCTResponseSenderBlock)callback) {
    NSError *error = nil;
    if (![OpenBack setValue:[NSNumber numberWithFloat:value] forCustomTrigger:trigger error:&error]) {
        callback(@[RCTMakeError(error.localizedDescription, nil, nil)]);
    }
}


RCT_EXPORT_METHOD(setUserInfo:(NSDictionary *)userInfo callback:(RCTResponseSenderBlock)callback) {
    NSError *error = nil;
    if (![OpenBack setUserInfo:userInfo error:&error]) {
        callback(@[RCTMakeError(error.localizedDescription, nil, nil)]);
    }
}

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

- (NSDictionary *)constantsToExport {
    return @{
        @"kOBKCustomTrigger1" : @(kOBKCustomTrigger1),
        @"kOBKCustomTrigger2" : @(kOBKCustomTrigger2),
        @"kOBKCustomTrigger3" : @(kOBKCustomTrigger3),
        @"kOBKCustomTrigger4" : @(kOBKCustomTrigger4),
        @"kOBKCustomTrigger5" : @(kOBKCustomTrigger5),
        @"kOBKCustomTrigger6" : @(kOBKCustomTrigger6),
        @"kOBKCustomTrigger7" : @(kOBKCustomTrigger7),
        @"kOBKCustomTrigger8" : @(kOBKCustomTrigger8),
        @"kOBKCustomTrigger9" : @(kOBKCustomTrigger9),
        @"kOBKCustomTrigger10" : @(kOBKCustomTrigger10)
    };
}

@end
