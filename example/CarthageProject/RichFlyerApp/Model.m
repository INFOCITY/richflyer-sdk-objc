//
//  Model.m
//  RichFlyer
//
//  Copyright © 2019年 INFOCITY,Inc. All rights reserved.
//

#import "Model.h"

@interface Model()
{
	NSMutableDictionary* _dictionary;
}
@end

@implementation Model

- (instancetype)init {
	self = [super init];
	if (self) {
		_dictionary = [NSMutableDictionary dictionary];
		for (NSNumber* num in [self getSegmentParameters]) {
			SegmentParameter param = [num intValue];
			NSString* paramStr = [self getSegmentParameterName:param];
			NSObject* value = [self getSegmentParameterValue:param][0];
			[_dictionary setValue:value forKey:paramStr];
		}
	}
	return self;
}

- (void)setValue:(SegmentParameter)key value:(NSObject*)value {
	NSString* keyStr = [self getSegmentParameterName:key];
	_dictionary[keyStr] = value;
}

- (NSString*)getValue {
	NSString* str = @"";
	for (NSNumber* num in [self getSegmentParameters]) {
		SegmentParameter param = [num intValue];
		NSString* paramStr = [self getSegmentParameterName:param];
        NSString* strValue;
        NSObject* value = _dictionary[paramStr];
        if ([value isKindOfClass:[NSString class]]) {
            strValue = (NSString*)value;
        } else if ([value isKindOfClass:[NSNumber class]]) {
            strValue = [(NSNumber*)value stringValue];
        }
		if (strValue == NULL) {
            strValue = @"";
		}
		str = [[[[str stringByAppendingString:paramStr] stringByAppendingString:@" : "] stringByAppendingString:strValue] stringByAppendingString:@"\n"];
	}
	return str;
}

- (NSDictionary*)getDictionary {
	return _dictionary;
}

- (NSArray*)getSegmentParameters {
	
	NSMutableArray *segmentParameters = [NSMutableArray array];
	[segmentParameters addObject:[NSNumber numberWithInt:SegmentParameterGenre]];
	[segmentParameters addObject:[NSNumber numberWithInt:SegmentParameterDay]];
	[segmentParameters addObject:[NSNumber numberWithInt:SegmentParameterAge]];
	[segmentParameters addObject:[NSNumber numberWithInt:SegmentParameterRegistered]];
	return segmentParameters;
	
}

- (NSArray*)getSegmentParameterValue: (SegmentParameter)param {
	switch (param) {
		case SegmentParameterGenre:
			return @[@"comic", @"magazine", @"novel"];
		case SegmentParameterDay:
			return @[@"月", @"火", @"水", @"木", @"金", @"土", @"日"];
		case SegmentParameterAge:
			return @[@0,@10,@20,@30,@40,@50,@60,@70,@80,@90,@100];
		case SegmentParameterRegistered:
			return @[@"YES", @"NO"];
	}
}

- (NSString*)getSegmentParameterName: (SegmentParameter)param {
	switch (param) {
		case SegmentParameterGenre:
			return @"genre";
		case SegmentParameterDay:
			return @"day";
		case SegmentParameterAge:
			return @"age";
		case SegmentParameterRegistered:
			return @"registered";
	}
}

- (NSArray*)getEventParameters {
	
	NSMutableArray *eventParameters = [NSMutableArray array];
	[eventParameters addObject:[NSNumber numberWithInt:EventParameterStore]];
	[eventParameters addObject:[NSNumber numberWithInt:EventParameterRecommend]];
	[eventParameters addObject:[NSNumber numberWithInt:EventParameterWishList]];
	[eventParameters addObject:[NSNumber numberWithInt:EventParameterCart]];
	[eventParameters addObject:[NSNumber numberWithInt:EventParameterPurcahse]];
	return eventParameters;
	
}

- (NSString*)getEventName: (EventParameter)param {
	switch (param) {
		case EventParameterStore:
			return @"OpenStore";
		case EventParameterRecommend:
			return @"OpenRecommend";
		case EventParameterWishList:
			return @"AddWishList";
		case EventParameterCart:
			return @"AddCart";
		case EventParameterPurcahse:
			return @"Purchase";
	}
}

- (NSString*)getEventParameterName: (EventParameter)param {
	switch (param) {
		case EventParameterStore:
			return @"ストアを開く";
		case EventParameterRecommend:
			return @"オススメ画面を開く";
		case EventParameterWishList:
			return @"ほしいものリスト追加";
		case EventParameterCart:
			return @"カート追加";
		case EventParameterPurcahse:
			return @"購入";
	}
}

- (NSArray*)getNotificationParameters {
	
	NSMutableArray *notificationParameters = [NSMutableArray array];
	[notificationParameters addObject:[NSNumber numberWithInt:EventParameterStore]];
	[notificationParameters addObject:[NSNumber numberWithInt:EventParameterRecommend]];
	[notificationParameters addObject:[NSNumber numberWithInt:EventParameterWishList]];
	[notificationParameters addObject:[NSNumber numberWithInt:EventParameterCart]];
	[notificationParameters addObject:[NSNumber numberWithInt:EventParameterPurcahse]];
	[notificationParameters addObject:[NSNumber numberWithInt:EventParameterCart]];
	return notificationParameters;
	
}

- (NSString*)getNotificationName: (NotificationParameter)param {
	switch (param) {
		case NotificationParameterStore:
			return @"NotificationOpenStore";
		case NotificationParameterRecommend:
			return @"NotificationOpenRecommend";
		case NotificationParameterWishList:
			return @"NotificationAddWishList";
		case NotificationParameterItemDetail:
			return @"NotificationOpenItemDetailPage";
		case NotificationParameterFeature:
			return @"NotificationOpenFeaturePage";
		case NotificationParameterWeb:
			return @"NotificationOpenWebPage";
	}
}

- (NSString*)getNotificationTitle: (NotificationParameter)param {
	switch (param) {
		case NotificationParameterStore:
			return @"ストアを開く";
		case NotificationParameterRecommend:
			return @"オススメ画面を開く";
		case NotificationParameterWishList:
			return @"ほしいものリスト追加";
		case NotificationParameterItemDetail:
			return @"商品詳細ページを開く";
		case NotificationParameterFeature:
			return @"特集ページを開く";
		case NotificationParameterWeb:
			return @"案内ページを開く";
	}
}

@end
