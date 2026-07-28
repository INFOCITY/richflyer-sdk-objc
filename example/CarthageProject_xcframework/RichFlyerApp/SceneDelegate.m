//
//  SceneDelegate.m
//  RichFlyer
//
//  Copyright © 2019年 INFOCITY,Inc. All rights reserved.
//

#import "SceneDelegate.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
}


- (void)sceneDidDisconnect:(UIScene *)scene {
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
#if DEBUG
  NSData* deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
	if (deviceToken) {
		NSLog(@"token: %@", [[deviceToken description] stringByReplacingOccurrencesOfString:@" " withString:@""]);
	}
#endif
}


- (void)sceneWillResignActive:(UIScene *)scene {
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
}


@end
