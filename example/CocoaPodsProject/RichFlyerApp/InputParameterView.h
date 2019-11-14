//
//  InputParameterView.h
//  RichFlyer
//
//  Copyright © 2019年 INFOCITY,Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface InputParameterView : UIView

- (void)setModel:(Model*) model;
- (void)setType:(SegmentParameter) type;

- (void)loadView;
- (void)viewDidLayoutSubviews;

@end
