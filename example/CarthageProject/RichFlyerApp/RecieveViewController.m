//
//  RecieveViewController.m
//  RichFlyer
//
//  Copyright © 2019年 INFOCITY,Inc. All rights reserved.
//

#import "RecieveViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <RichFlyer/RichFlyer.h>
#import "RecievedNotificationCell.h"

static const CGFloat cellHeight = 120;

@interface RecieveViewController ()
{
  SendMediaType _type;
  IBOutlet UITableView *tableView;
  NSArray<RFContent*>* recievedContents;
}
@end

@implementation RecieveViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  recievedContents = [RFApp getReceivedData];
  [tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _type = SendMediaTypeImage;
  
  tableView.delegate = self;
  tableView.dataSource = self;
  tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
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

- (void)showContent:(RFContent*)content {
  RFContentDisplay* rfDisplay = [[RFContentDisplay alloc] initWithContent:content];
  [rfDisplay present:self completeHandler:^(RFAction* action) {
    
    if ([action.getType isEqualToString:@"url"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:action.getValue] options:@{} completionHandler:nil];
    }
    [rfDisplay dismiss];
  }];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  if (recievedContents) {
    return [recievedContents count];
  } else {
    return 1;
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  RecievedNotificationCell* cell = [tableView dequeueReusableCellWithIdentifier:@"RecievedNotificationCell"];
  CGSize cellSize = CGSizeMake(tableView.frame.size.width, cellHeight);

  if (!recievedContents) {
    cell = [[RecievedNotificationCell alloc] initWithFrame:CGRectMake(0, 0, cellSize.width, cellSize.height)];
    return cell;
  }
  
  RFContent* content = [recievedContents objectAtIndex:indexPath.row];
  if (!cell) {
    cell = [[RecievedNotificationCell alloc] initWithFrame:CGRectMake(0, 0, cellSize.width, cellSize.height)];
  }

  [cell setup:cellSize content:content];

  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return cellHeight;
}


#pragma mark -
#pragma mark UITablewViewDelegation

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  if (!recievedContents) return;
  
  RFContent* content = [recievedContents objectAtIndex:indexPath.row];
  [self showContent:content];
}

@end
