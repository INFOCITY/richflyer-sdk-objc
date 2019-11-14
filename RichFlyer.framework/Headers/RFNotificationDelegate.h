//
//  RFNotificationDelegate.h
//  RichFlyer
//
//  Copyright © 2019年 INFOCITY,Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>


@protocol RFNotificationDelegate <NSObject>
@optional
- (void)willPresentNotificationWithCenter:(UNUserNotificationCenter *)center
							 notification:(UNNotification *)notification
					withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler NS_AVAILABLE_IOS(10_0);
- (void)didReceiveNotificationWithCenter:(UNUserNotificationCenter *)center
								response:(UNNotificationResponse *)response
									 withCompletionHandler:(void (^)(void))completionHandler NS_AVAILABLE_IOS(10_0);
@end
