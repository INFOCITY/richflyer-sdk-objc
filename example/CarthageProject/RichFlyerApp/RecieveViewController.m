//
//  RecieveViewController.m
//  RichFlyer
//
//  Copyright © 2019年 INFOCITY,Inc. All rights reserved.
//

#import "RecieveViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <RichFlyer/RichFlyer.h>

@interface RecieveViewController ()
{
    SendMediaType _type;
}
@end

@implementation RecieveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _type = SendMediaTypeImage;
}

- (IBAction)onChangeSelectedItem:(UISegmentedControl *)sender {
    _type = [self getSendMediaType:sender.selectedSegmentIndex];
}

- (SendMediaType)getSendMediaType: (NSInteger)index
{
    switch (index) {
        case 1:
            return SendMediaTypeGif;
        case 2:
            return SendMediaTypeMovie;
        default:
            return SendMediaTypeImage;
    }
}

- (IBAction)show:(id)sender {
  
  RFContent* latestContent = [RFApp getLatestReceivedData];
  RFContentDisplay* rfDisplay = [[RFContentDisplay alloc] initWithContent:latestContent];
  [rfDisplay present:self completeHandler:^(RFAction* action) {
    
    if ([action.getType isEqualToString:@"url"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:action.getValue] options:@{} completionHandler:nil];
    }
    [rfDisplay dismiss];
  }];
}

@end
