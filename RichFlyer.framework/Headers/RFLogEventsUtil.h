//
//  RFLogEventsUtil.h
//  RichFlyer
//
//  Created by akita on 2017/08/09.
//  Copyright © 2018年 INFOCITY,Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RichFlyerEvent/RichFlyerEvent.h>

typedef NS_ENUM(int8_t, RFSendEventOption) {
	RFSendEventOptionFirebase = SendEventOptionFirebase,
	RFSendEventOptionGoogle   = SendEventOptionGoogle,
	RFSendEventOptionFacebook = SendEventOptionFacebook,
	RFSendEventOptionFlurry   = SendEventOptionFlurry
};

@interface RFLogEventsUtil : NSObject

+ (void)setLogForFirebase:(void (^)(NSString* name, NSDictionary* param))logForFirebase;
+ (void)setLogForGoogle:(void (^)(NSString* name, NSString* category, NSDictionary* param))logForGoogle;
+ (void)setLogForFacebook:(void (^)(NSString* name, NSDictionary* param))logForFacebook;
+ (void)setLogForFlurry:(void (^)(NSString* name, NSDictionary* param))logForFlurry;

+ (void)sendEventLog:(NSString*)eventName param:(NSDictionary*)param;
+ (void)sendEventLog:(NSString*)eventName param:(NSDictionary*)param options:(RFSendEventOption)option;
+ (void)sendEventLog:(NSString*)eventName category:(NSString*)category param:(NSDictionary*)param options:(RFSendEventOption)option;

+ (void)reset;

+ (NSString*)currentNotificationId;

@end
