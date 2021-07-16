//
//  Model.h
//  RichFlyer
//
//  Copyright © 2019年 INFOCITY,Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum SegmentParameter {
	SegmentParameterGenre,
	SegmentParameterDay,
	SegmentParameterLaunchCount,
	SegmentParameterDayTime	
} SegmentParameter;

typedef enum EventParameter {
	EventParameterStore,
	EventParameterRecommend,
	EventParameterWishList,
	EventParameterCart,
	EventParameterPurcahse
} EventParameter;

typedef enum NotificationParameter {
	NotificationParameterStore,
	NotificationParameterRecommend,
	NotificationParameterWishList,
	NotificationParameterItemDetail,
	NotificationParameterFeature,
	NotificationParameterWeb
} NotificationParameter;

@interface Model : NSObject

- (void)setValue:(SegmentParameter)key value:(NSString*)value;
- (NSString*)getValue;
- (NSDictionary*)getDictionary;

- (NSArray*)getSegmentParameters;
- (NSArray*)getSegmentParameterValue: (SegmentParameter)param;
- (NSString*)getSegmentParameterName: (SegmentParameter)param;

- (NSArray*)getEventParameters;
- (NSString*)getEventName: (EventParameter)param;
- (NSString*)getEventParameterName: (EventParameter)param;

- (NSArray*)getNotificationParameters;
- (NSString*)getNotificationName: (NotificationParameter)param;
- (NSString*)getNotificationTitle: (NotificationParameter)param;
@end
