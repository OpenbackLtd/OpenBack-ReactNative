/**
 * OpenBack React Native Module for iOS
 *
 * Copyright © 2019 OpenBack, Ltd. All rights reserved.
 */

#import "RNOpenBackAppInbox.h"
#import <OpenBack/OpenBack.h>

@interface RNOpenBackAppInbox() <OpenBackAppInboxDelegate>
@end

@implementation RNOpenBackAppInbox {
    bool hasListeners;
}

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

RCT_EXPORT_MODULE()

- (instancetype)init {
    self = [super init];
    if (self) {
        OpenBackAppInbox *inbox = [OpenBack appInbox];
        [inbox setDelegate:self];
    }
    return self;
}

RCT_EXPORT_METHOD(getMessageCount:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    OpenBackAppInbox *inbox = [OpenBack appInbox];
    [inbox getMessageCount:^(NSUInteger messageCount) {
        resolve(@(messageCount));
    }];
}

RCT_EXPORT_METHOD(getUnreadMessageCount:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    OpenBackAppInbox *inbox = [OpenBack appInbox];
    [inbox getUnreadMessageCount:^(NSUInteger unreadMessageCount) {
        resolve(@(unreadMessageCount));
    }];
}

RCT_EXPORT_METHOD(getAllMessages:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    OpenBackAppInbox *inbox = [OpenBack appInbox];
    [inbox getAllMessages:^(NSArray<OpenBackAppInboxMessage *> * _Nonnull messages) {
        resolve([RNOpenBackAppInbox convertToRctMessages:messages]);
    }];
}

RCT_EXPORT_METHOD(getReadMessages:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    OpenBackAppInbox *inbox = [OpenBack appInbox];
    [inbox getReadMessages:^(NSArray<OpenBackAppInboxMessage *> * _Nonnull messages) {
        resolve([RNOpenBackAppInbox convertToRctMessages:messages]);
    }];
}

RCT_EXPORT_METHOD(getUnreadMessages:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    OpenBackAppInbox *inbox = [OpenBack appInbox];
    [inbox getUnreadMessages:^(NSArray<OpenBackAppInboxMessage *> * _Nonnull messages) {
        resolve([RNOpenBackAppInbox convertToRctMessages:messages]);
    }];
}
    
RCT_EXPORT_METHOD(markMessageAsRead:(NSDictionary *)rctMessage resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    OpenBackAppInbox *inbox = [OpenBack appInbox];
    OpenBackAppInboxMessage *inboxMessage = [RNOpenBackAppInbox convertToInboxMessage:rctMessage];
    [inbox markMessageAsRead:inboxMessage completion:^(NSError * _Nullable error) {
        if (error) {
            reject(error.localizedDescription, nil, nil);
        } else {
            resolve([NSNull null]);
        }
    }];
}
    
RCT_EXPORT_METHOD(markMessagesAsRead:(NSArray<NSDictionary *> *)rctMessages resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    OpenBackAppInbox *inbox = [OpenBack appInbox];
    NSArray<OpenBackAppInboxMessage *> *inboxMessages = [RNOpenBackAppInbox convertToInboxMessages:rctMessages];
    [inbox markMessagesAsRead:inboxMessages completion:^(NSError * _Nullable error) {
        if (error) {
            reject(error.localizedDescription, nil, nil);
        } else {
            resolve([NSNull null]);
        }
    }];
}
    
RCT_EXPORT_METHOD(markAllMessagesAsRead:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    OpenBackAppInbox *inbox = [OpenBack appInbox];
    [inbox markAllMessagesAsRead:^(NSError * _Nullable error) {
        if (error) {
            reject(error.localizedDescription, nil, nil);
        } else {
            resolve([NSNull null]);
        }
    }];
}
    
RCT_EXPORT_METHOD(removeMessage:(NSDictionary *)rctMessage resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    OpenBackAppInbox *inbox = [OpenBack appInbox];
    OpenBackAppInboxMessage *inboxMessage = [RNOpenBackAppInbox convertToInboxMessage:rctMessage];
    [inbox removeMessage:inboxMessage completion:^(NSError * _Nullable error) {
        if (error) {
            reject(error.localizedDescription, nil, nil);
        } else {
            resolve([NSNull null]);
        }
    }];
}
    
RCT_EXPORT_METHOD(removeMessages:(NSArray<NSDictionary *> *)rctMessages resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    OpenBackAppInbox *inbox = [OpenBack appInbox];
    NSArray<OpenBackAppInboxMessage *> *inboxMessages = [RNOpenBackAppInbox convertToInboxMessages:rctMessages];
    [inbox removeMessages:inboxMessages completion:^(NSError * _Nullable error) {
        if (error) {
            reject(error.localizedDescription, nil, nil);
        } else {
            resolve([NSNull null]);
        }
    }];
}
    
RCT_EXPORT_METHOD(removeAllMessages:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    OpenBackAppInbox *inbox = [OpenBack appInbox];
    [inbox removeAllMessages:^(NSError * _Nullable error) {
        if (error) {
            reject(error.localizedDescription, nil, nil);
        } else {
            resolve([NSNull null]);
        }
    }];
}
    
RCT_EXPORT_METHOD(executeMessage:(NSDictionary *)rctMessage resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    OpenBackAppInbox *inbox = [OpenBack appInbox];
    OpenBackAppInboxMessage *inboxMessage = [RNOpenBackAppInbox convertToInboxMessage:rctMessage];
    [inbox executeMessage:inboxMessage completion:^(NSError * _Nullable error) {
        if (error) {
            reject(error.localizedDescription, nil, nil);
        } else {
            resolve([NSNull null]);
        }
    }];
}

// Events

- (void)startObserving {
    hasListeners = YES;
}

- (void)stopObserving {
    hasListeners = NO;
}

- (NSArray<NSString *> *)supportedEvents {
    return @[ kOBKAppInboxMessageRead, kOBKAppInboxMessageAdded, kOBKAppInboxMessageExpired ];
}

- (void)appInboxMessageRead:(OpenBackAppInboxMessage *)message {
    if (hasListeners) {
        NSDictionary *rctMessage = [RNOpenBackAppInbox convertToRctMessage:message];
        [self sendEventWithName:kOBKAppInboxMessageRead body:rctMessage];
    }
}

- (void)appInboxMessageAdded:(OpenBackAppInboxMessage *)message {
    if (hasListeners) {
        NSDictionary *rctMessage = [RNOpenBackAppInbox convertToRctMessage:message];
        [self sendEventWithName:kOBKAppInboxMessageAdded body:rctMessage];
    }
}

- (void)appInboxMessageExpired:(OpenBackAppInboxMessage *)message {
    if (hasListeners) {
        NSDictionary *rctMessage = [RNOpenBackAppInbox convertToRctMessage:message];
        [self sendEventWithName:kOBKAppInboxMessageExpired body:rctMessage];
    }
}

// Message Conversion

+ (NSArray<NSDictionary *> *)convertToRctMessages:(NSArray<OpenBackAppInboxMessage *> *)inboxMessages {
    NSMutableArray *rctMessages = [NSMutableArray arrayWithCapacity:inboxMessages.count];
    for (OpenBackAppInboxMessage *inboxMessage in inboxMessages) {
        [rctMessages addObject:[self convertToRctMessage:inboxMessage]];
    }
    return rctMessages;
}

+ (NSDictionary *)convertToRctMessage:(OpenBackAppInboxMessage *)inboxMessage {
    NSMutableDictionary *rctMessage = [NSMutableDictionary dictionary];
    rctMessage[@"read"] = @(inboxMessage.read);
    rctMessage[@"actionable"] = @(inboxMessage.actionable);
    rctMessage[@"deliveryTime"] = @(inboxMessage.deliveryTime);
    rctMessage[@"title"] = inboxMessage.title;
    rctMessage[@"content"] = inboxMessage.content;
    rctMessage[@"payload"] = inboxMessage.payload;
    rctMessage[@"_id"] = [inboxMessage valueForKey:@"messageId"];
    return rctMessage;
}

+ (NSArray<OpenBackAppInboxMessage *> *)convertToInboxMessages:(NSArray<NSDictionary *> *)rctMessages {
    NSMutableArray *inboxMessages = [NSMutableArray arrayWithCapacity:rctMessages.count];
    for (NSDictionary *rctMessage in rctMessages) {
        [inboxMessages addObject:[self convertToInboxMessage:rctMessage]];
    }
    return inboxMessages;
}

+ (OpenBackAppInboxMessage *)convertToInboxMessage:(NSDictionary *)rctMessage {
    OpenBackAppInboxMessage *inboxMessage = [OpenBackAppInboxMessage new];
    [inboxMessage setValue:rctMessage[@"deliveryTime"] forKey:@"deliveryTime"];
    [inboxMessage setValue:rctMessage[@"_id"] forKey:@"messageId"];
    return inboxMessage;
}

@end
