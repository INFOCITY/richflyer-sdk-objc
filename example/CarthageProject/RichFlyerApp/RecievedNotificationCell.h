//
//  RecievedNotificationCell.h
//  RichFlyerDevelopmentObjC
//
//  Created by Takeshi Goto on 2023/11/27.
//  Copyright © 2023 INFOCITY, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RichFlyer/RichFlyer.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecievedNotificationCell : UITableViewCell

- (void)setup:(CGSize)size content:(RFContent*)content;

@end

NS_ASSUME_NONNULL_END
