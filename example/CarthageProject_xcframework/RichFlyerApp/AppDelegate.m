//
//  AppDelegate.m
//  RichFlyer
//
//  Copyright © 2019年 INFOCITY,Inc. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [RFApp resetBadgeNumber:application];
  
  NSString* bundlPath = [[NSBundle mainBundle] pathForResource:@"RichFlyer" ofType:@"plist"];
  NSDictionary* rfConf = [NSDictionary dictionaryWithContentsOfFile:bundlPath];
  NSString* serviceKey = [rfConf objectForKey:@"serviceKey"];
  NSString* groupId = [rfConf objectForKey:@"groupId"];
  
#if DEBUG
	[RFApp setServiceKey:serviceKey appGroupId:groupId sandbox:YES];
#else
  [RFApp setServiceKey:serviceKey appGroupId:groupId sandbox:NO];
#endif
  
  if (@available(iOS 10, *)) {
		[RFApp setRFNotificationDelegate:self];
	}
	
	return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
#if DEBUG
  NSData* deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
	if (deviceToken) {
		NSLog(@"token: %@", [[deviceToken description] stringByReplacingOccurrencesOfString:@" " withString:@""]);
#endif
	}
}


- (void)applicationWillTerminate:(UIApplication *)application {
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
	//サーバにデバイスを登録
    [RFApp registDevice:deviceToken completion:^(RFResult* result){
      if (result.result) {
        NSLog(@"デバイス登録に成功");
      } else {
        NSLog(@"デバイス登録に失敗(%@:%ld)", result.message, (long)result.code);
      }
    }];

#if DEBUG
	NSLog(@"token: %@", [[deviceToken description] stringByReplacingOccurrencesOfString:@" " withString:@""]);
	[[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:@"deviceToken"];
#endif
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
}

#pragma mark - RFNotificationDelegate

- (void)didReceiveNotificationWithCenter:(UNUserNotificationCenter *)center response:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
{
	//通知を開封したときに呼ばれる
	[RFApp didReceiveNotification:response handler:^(RFAction *action, NSString* extendedProperty) {
		
    NSString* notificationId = RFLastNotificationInfo.identifier;
    
		NSNotificationCenter* nc = NSNotificationCenter.defaultCenter;
		
		NSMutableDictionary* param = [NSMutableDictionary dictionary];
		[param setObject:notificationId forKey:@"notificationId"];
		
		if (action) {
			[param setObject:[action getTitle] forKey:@"title"];
			[param setObject:[action getType] forKey:@"actionType"];
			[param setObject:[action getValue] forKey:@"actionValue"];
		}
		
		[nc postNotificationName:@"openNotification" object:param];
	}];
	
	completionHandler();
}

- (void)willPresentNotificationWithCenter:(UNUserNotificationCenter *)center notification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
	//Foregroundで通知を受け取る場合の設定
	//optionsにUNNotificationPresentationOptionNoneを設定すると
	//Foregroundの際に通知が表示されなくなる
	UNNotificationPresentationOptions options = UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound;
	[RFApp willPresentNotification:options completionHandler:completionHandler];
}

- (void)dismissedContentDisplay:(RFAction *)action content:(RFContent*)content
{
  NSNotificationCenter* nc = NSNotificationCenter.defaultCenter;
  
  NSMutableDictionary* param = [NSMutableDictionary dictionary];
  [param setObject:content.notificationId forKey:@"notificationId"];
  
  if (action) {
    [param setObject:[action getTitle] forKey:@"title"];
    [param setObject:[action getType] forKey:@"actionType"];
    [param setObject:[action getValue] forKey:@"actionValue"];
  }
  
  [nc postNotificationName:@"openNotification" object:param];
}

@end
