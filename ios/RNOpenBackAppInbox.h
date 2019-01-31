/**
 * OpenBack React Native Module for iOS
 *
 * Copyright © 2019 OpenBack, Ltd. All rights reserved.
 */

#if __has_include(<React/RCTBridgeModule.h>)
  #import <React/RCTBridgeModule.h>
#elif __has_include("React/RCTBridgeModule.h")
  #import "React/RCTBridgeModule.h"
#else
  #import "RCTBridgeModule.h"
#endif

#if __has_include(<React/RCTEventEmitter.h>)
  #import <React/RCTEventEmitter.h>
#elif __has_include("React/RCTEventEmitter.h")
  #import "React/RCTEventEmitter.h"
#else
  #import "RCTEventEmitter.h"
#endif

@interface RNOpenBackAppInbox : RCTEventEmitter<RCTBridgeModule>

@end
