//
//  ViewController.m
//  RichFlyer
//
//  Copyright © 2019年 INFOCITY,Inc. All rights reserved.
//

#import <RichFlyer/RichFlyer.h>
#import "Model.h"
#import "InputParameterView.h"

#import "ViewController.h"

#define MARGIN 8
#define ITEM_COUNT 7

@interface ViewController ()
{
	Model* _model;
	NSMutableArray<InputParameterView*>* _inputViews;
	UIButton* _sendSegment;
}

@end

@implementation ViewController

- (void)loadView {
	[super loadView];

	self.view.backgroundColor = [UIColor whiteColor];
	_model = [[Model alloc] init];
	_inputViews = [NSMutableArray array];
	
	for (NSNumber* num in [_model getSegmentParameters]) {
		InputParameterView* input = [[InputParameterView alloc] init];
		[input setModel:_model];
		SegmentParameter param = [num intValue];
		[input setType:param];
		[_inputViews addObject:input];
		
		[input loadView];
		[self.view addSubview:input];
	}
	
	_sendSegment = [[UIButton alloc] init];
	[_sendSegment setTitle:@"登録" forState:UIControlStateNormal];
	[_sendSegment setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	_sendSegment.backgroundColor = [UIColor darkGrayColor];
	[_sendSegment addTarget:self action:@selector(registerSegment) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_sendSegment];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
  RFAlertController* alert = [[RFAlertController alloc] initWithApplication:[UIApplication sharedApplication]
                                                                      title:@"プッシュ通知"
                                                                    message:@"プッシュ通知の受信を許可してお得なお知らせをゲットしよう！"];
  
  [alert addImage:@"Information"];
  
  [alert present:^{
    [RFApp requestAuthorization:[UIApplication sharedApplication]
                               applicationDelegate:[UIApplication sharedApplication].delegate];
  }];

  NSArray<RFContent*>* history = RFApp.getReceivedData;
  for (RFContent* content in history) {
    //プッシュ通知のタイトル
    NSLog(@"%@", content.title);
    //プッシュ通知の本文
    NSLog(@"%@", content.body);
    //保存されている画像のパス
    NSLog(@"%@", content.imagePath);
    //通知ID
    NSLog(@"%@", content.notificationId);

  }
  
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onOpenPushNotification:) name:@"openNotification" object:nil];
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];

	CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
	CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
	CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
	
	CGFloat contentsHeight = self.view.frame.size.height - (statusBarHeight + navBarHeight + tabBarHeight);
	
	CGFloat viewWidth = self.view.frame.size.width - MARGIN * 2;
	CGFloat viewHeight = (contentsHeight - (MARGIN * (ITEM_COUNT + 1))) / ITEM_COUNT;
	
	CGFloat y = statusBarHeight + navBarHeight + MARGIN;

	for (InputParameterView* input in _inputViews) {
		input.frame = CGRectMake(MARGIN, y, viewWidth, viewHeight);
		[input viewDidLayoutSubviews];
		y = y + MARGIN + viewHeight;
	}
	
	_sendSegment.layer.masksToBounds = YES;
	_sendSegment.layer.cornerRadius = viewHeight / 2;
	_sendSegment.frame = CGRectMake(self.view.frame.size.width / 2 - viewHeight / 2, y, viewHeight, viewHeight);
}

- (void)registerSegment {

    NSDictionary* segments = [_model getDictionary];
    NSMutableDictionary<NSString*, NSString*>* stringSegments = [NSMutableDictionary dictionary];
    NSMutableDictionary<NSString*, NSNumber*>* intSegments = [NSMutableDictionary dictionary];
    NSMutableDictionary<NSString*, NSNumber*>* boolSegments = [NSMutableDictionary dictionary];
    NSMutableDictionary<NSString*, NSDate*>* dateSegments = [NSMutableDictionary dictionary];

    for (NSString* key in [segments allKeys]) {
        id value = [segments objectForKey:key];
        
        if ([value isKindOfClass:[NSString class]]) {
            if ([value isEqualToString:@"YES"]) {
                [boolSegments setObject:[NSNumber numberWithBool:YES] forKey:key];
            } else if ([value isEqualToString:@"NO"]) {
              [boolSegments setObject:[NSNumber numberWithBool:NO] forKey:key];
            } else {
                [stringSegments setObject:value forKey:key];
            }
            continue;
        }
        
        if ([value isKindOfClass:[NSNumber class]]) {
            [intSegments setObject:value forKey:key];
            continue;
        }
      
        if ([value isKindOfClass:[NSDate class]]) {
            [dateSegments setObject:value forKey:key];
            continue;
        }
    }
    [dateSegments setObject:[NSDate new] forKey:@"registeredDate"];

    [RFApp registSegments:stringSegments intSegments:intSegments
             boolSegments:boolSegments dateSegments:dateSegments completion:^(RFResult * _Nonnull result) {
        dispatch_async(dispatch_get_main_queue(), ^{
          NSString* message = @"";
          if (result.result) {
            message = [[self->_model getValue] stringByAppendingString:@"でSegmentを登録しました。"];
          } else {
            message = [NSString stringWithFormat:@"Segmentを登録できませんでした。(%ld)", result.code];
          }
          UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Segmentの登録" message:message preferredStyle:UIAlertControllerStyleAlert];
          UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:NULL];
          [alert addAction:defaultAction];
          [self presentViewController:alert animated:YES completion:NULL];
       });
	}];
       
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)onOpenPushNotification:(NSNotification*)notification
{
	if ([notification object] == nil || ![[notification object] isKindOfClass:[NSDictionary class]]) {
		return;
	}

	NSDictionary* dictionary = [notification object];

	NSString* eventName = @"NotificationEvent";
	for (NSNumber* num in [_model getNotificationParameters]) {
		NotificationParameter param = [num intValue];
		NSString* title = dictionary[@"title"];
		if (title != NULL) {
			if ([title isEqualToString:[_model getNotificationTitle:param]]) {
				eventName = [_model getNotificationName:param];
				break;
			}
		}
	}
	
//	[RFLogEventsUtil sendEventLog:eventName param:dictionary options:RFSendEventOptionFirebase|RFSendEventOptionFlurry];

}

@end

