//
//  NotificationService.m
//  NotificationService
//
//  Copyright © 2019 INFOCITY,Inc. All rights reserved.
//

#import "NotificationService.h"
#import <RichFlyer/RichFlyer.h>
@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    NSString* bundlPath = [[NSBundle mainBundle] pathForResource:@"RichFlyer" ofType:@"plist"];
    NSDictionary* rfConf = [NSDictionary dictionaryWithContentsOfFile:bundlPath];
    NSString* groupId = [rfConf objectForKey:@"groupId"];

    [RFNotificationService configureRFNotification:self.bestAttemptContent
                                        appGroupId:groupId
                                   completeHandler:^(UNMutableNotificationContent *content) {
                                     self.bestAttemptContent = content;
                                     self.contentHandler(self.bestAttemptContent);
                                   }
     ];
  
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
