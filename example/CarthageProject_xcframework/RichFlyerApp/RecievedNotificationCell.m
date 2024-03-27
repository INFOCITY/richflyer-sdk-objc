//
//  RecievedNotificationCell.m
//  RichFlyerDevelopmentObjC
//
//  Created by Takeshi Goto on 2023/11/27.
//  Copyright © 2023 INFOCITY, Inc. All rights reserved.
//

#import "RecievedNotificationCell.h"

static const CGFloat itemTopMargin = 10.0f;
static const CGFloat itemSideMargin = 10.0f;

@interface RecievedNotificationCell() {
  UILabel* title;
  UILabel* body;
  UIImageView* image;
}

@end

@implementation RecievedNotificationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setup:(CGSize)size content:(RFContent*)content {
  title = [UILabel new];
  body = [UILabel new];
  image = [UIImageView new];

  self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
  
  NSData* imageData = [NSData dataWithContentsOfURL:content.imagePath];
  if (imageData) {
    image.image = [UIImage imageWithData:imageData];
  }
  title.text = content.title;
  body.text = content.body;

  
  CGSize baseSize = CGSizeMake(size.width - itemSideMargin * 2, size.height - itemTopMargin * 2);
  CGRect imageRect = CGRectMake(0, 0, 0, 0);
  if (imageData) {
    imageRect = CGRectMake(itemSideMargin, itemTopMargin, baseSize.width * 0.3, baseSize.height);
  }
  CGRect titleRect = CGRectMake(CGRectGetMaxX(imageRect) + itemSideMargin, itemTopMargin, baseSize.width * 0.7, baseSize.height * 0.3);
  CGRect bodyRect = CGRectMake(CGRectGetMaxX(imageRect) + itemSideMargin, CGRectGetMaxY(titleRect), baseSize.width * 0.7, baseSize.height * 0.7);

  image.frame = imageRect;
  title.frame = titleRect;
  body.frame = bodyRect;
  
  body.lineBreakMode = NSLineBreakByWordWrapping;
  body.numberOfLines = 0;
  body.font = [UIFont systemFontOfSize:14.0];
  if (@available(iOS 13.0, *)) {
    body.textColor = UIColor.secondaryLabelColor;
  } else {
    body.textColor = UIColor.darkGrayColor;
  }
    
  [self addSubview:image];
  [self addSubview:title];
  [self addSubview:body];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
