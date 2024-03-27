//
//  EventViewController.m
//  RichFlyerDevelopmentObjC
//
//  Created by Takeshi Goto on 2023/11/26.
//  Copyright © 2023 INFOCITY, Inc. All rights reserved.
//

#import "EventViewController.h"
#import <RichFlyer/RichFlyer.h>

static const CGFloat itemHeight = 30.0f;
static const CGFloat itemTopMargin = 10.0f;
static const CGFloat itemSideMargin = 10.0f;

@interface EventViewController ()
{
  UITextField* eventText1;
  UITextField* eventText2;
  UITextField* eventText3;
  UIView* eventBaseView;

  UITextField* variable1Name;
  UITextField* variable1Value;
  UITextField* variable2Name;
  UITextField* variable2Value;
  UITextField* variable3Name;
  UITextField* variable3Value;
  UIView* variableBaseView;

  UITextField* standbyTime;
  UIView* standbyTimeBaseView;

  UIButton* sendButton;
  UIButton* cancelButton;

  UIColor* baseViewColor;
  
  NSMutableArray* postIds;
}

@end

@implementation EventViewController

- (void) loadView {
  [super loadView];
  
  baseViewColor = [UIColor colorWithRed:0.0 / 256.0 green:150.0 / 256.0 blue:136.0 / 256.0 alpha:1.0];

  eventText1 = [UITextField new];
  eventText2 = [UITextField new];
  eventText3 = [UITextField new];
  eventBaseView = [UIView new];

  variable1Name = [UITextField new];
  variable1Value = [UITextField new];
  variable2Name = [UITextField new];
  variable2Value = [UITextField new];
  variable3Name = [UITextField new];
  variable3Value = [UITextField new];
  variableBaseView = [UIView new];

  standbyTime = [UITextField new];
  standbyTimeBaseView = [UIView new];

  sendButton = [UIButton new];
  cancelButton = [UIButton new];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    // Do any additional setup after loading the view.
  
  UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
  [self.view addGestureRecognizer:tap];
  
  [self initEventView];
  
  [self initVariableView];
  
  [self initStanbyTimeView];
  
  [self initSendButton];
  
  [self initCancelButton];
  
  postIds = [NSMutableArray new];
  
  /*
   NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
   NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
   
   */
}


- (void)initEventView {
  
  CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
  CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;

  [self setBaseView:eventBaseView
              frame:CGRectMake(itemSideMargin, statusBarHeight + navBarHeight,
                               self.view.bounds.size.width - itemSideMargin * 2,
                               (itemHeight+itemTopMargin) * 4 + itemTopMargin * 2)];
  
  CGFloat itemWidth = self.view.bounds.size.width - itemSideMargin * 4;
  
  UILabel* label = [UILabel new];
  [self setLabel:label
           frame:CGRectMake(itemSideMargin, itemTopMargin, itemWidth, itemHeight)
            text:@"イベント名" baseView:eventBaseView];
  
  [self setTextField:eventText1 
               frame:CGRectMake(itemSideMargin, CGRectGetMaxY(label.frame) + itemTopMargin, itemWidth, itemHeight)
         placeholder:@"event1" baseView:eventBaseView];

  [self setTextField:eventText2
               frame:CGRectMake(itemSideMargin, CGRectGetMaxY(eventText1.frame) + itemTopMargin, itemWidth, itemHeight)
         placeholder:@"event2" baseView:eventBaseView];

  [self setTextField:eventText3
               frame:CGRectMake(itemSideMargin, CGRectGetMaxY(eventText2.frame) + itemTopMargin, itemWidth, itemHeight)
         placeholder:@"event3" baseView:eventBaseView];

  [self.view addSubview:eventBaseView];
}

- (void)initVariableView {
  
  [self setBaseView:variableBaseView
              frame:CGRectMake(itemSideMargin, CGRectGetMaxY(eventBaseView.frame)+itemTopMargin,
                               self.view.bounds.size.width - itemSideMargin * 2,
                               (itemHeight+itemTopMargin) * 4 + itemTopMargin * 2)];
  
  CGFloat itemWidth = self.view.bounds.size.width - itemSideMargin * 4;
  
  UILabel* label = [UILabel new];
  [self setLabel:label
           frame:CGRectMake(itemSideMargin, itemTopMargin, itemWidth, itemHeight)
            text:@"変数" baseView:variableBaseView];
  
  itemWidth = itemWidth / 2 - itemTopMargin;
  [self setTextField:variable1Name
               frame:CGRectMake(itemSideMargin, CGRectGetMaxY(label.frame) + itemTopMargin, itemWidth, itemHeight)
         placeholder:@"名前" baseView:variableBaseView];

  [self setTextField:variable1Value
               frame:CGRectMake(variableBaseView.bounds.size.width - (itemWidth + itemSideMargin),
                                variable1Name.frame.origin.y, itemWidth, itemHeight)
         placeholder:@"値" baseView:variableBaseView];

  [self setTextField:variable2Name
               frame:CGRectMake(itemSideMargin, CGRectGetMaxY(variable1Name.frame) + itemTopMargin, itemWidth, itemHeight)
         placeholder:@"名前" baseView:variableBaseView];

  [self setTextField:variable2Value
               frame:CGRectMake(variableBaseView.bounds.size.width - (itemWidth + itemSideMargin),
                                variable2Name.frame.origin.y, itemWidth, itemHeight)
         placeholder:@"値" baseView:variableBaseView];

  [self setTextField:variable3Name
               frame:CGRectMake(itemSideMargin, CGRectGetMaxY(variable2Name.frame) + itemTopMargin, itemWidth, itemHeight)
         placeholder:@"名前" baseView:variableBaseView];

  [self setTextField:variable3Value
               frame:CGRectMake(variableBaseView.bounds.size.width - (itemWidth + itemSideMargin),
                                variable3Name.frame.origin.y, itemWidth, itemHeight)
         placeholder:@"値" baseView:variableBaseView];


  [self.view addSubview:variableBaseView];
}

- (void)initStanbyTimeView {
  
  [self setBaseView:standbyTimeBaseView
              frame:CGRectMake(itemSideMargin, CGRectGetMaxY(variableBaseView.frame)+itemTopMargin,
                               self.view.bounds.size.width - itemSideMargin * 2,
                               (itemHeight+itemTopMargin) * 2 + itemTopMargin * 2)];
  
  CGFloat itemWidth = self.view.bounds.size.width - itemSideMargin * 4;
  
  UILabel* label = [UILabel new];
  [self setLabel:label
           frame:CGRectMake(itemSideMargin, itemTopMargin, itemWidth, itemHeight)
            text:@"待機時間" baseView:standbyTimeBaseView];
  
  [self setTextField:standbyTime
               frame:CGRectMake(itemSideMargin, CGRectGetMaxY(label.frame) + itemTopMargin, itemWidth, itemHeight)
         placeholder:@"分" baseView:standbyTimeBaseView];
  
  [self.view addSubview:standbyTimeBaseView];
}

- (void)initSendButton {
  
  [sendButton setTitle:@"送信" forState:UIControlStateNormal];
  [sendButton setTintColor:UIColor.whiteColor];
  [sendButton setBackgroundColor:UIColor.darkGrayColor];
  [sendButton addTarget:self action:@selector(onSendButtonTapped) forControlEvents:UIControlEventTouchUpInside];

  CGFloat buttonHeight = itemHeight * 3;
  sendButton.layer.masksToBounds = YES;
  sendButton.layer.cornerRadius = buttonHeight / 2;
  sendButton.frame = CGRectMake(self.view.frame.size.width / 2.0 - buttonHeight / 2.0,
                                CGRectGetMaxY(standbyTimeBaseView.frame) + itemTopMargin,
                                buttonHeight, buttonHeight);
  [self.view addSubview:sendButton];
  
}

- (void)initCancelButton {
  
  [cancelButton setTitle:@"キャンセル" forState:UIControlStateNormal];
  [cancelButton setTintColor:UIColor.whiteColor];
  [cancelButton setBackgroundColor:UIColor.darkGrayColor];
  [cancelButton addTarget:self action:@selector(onCancelButtonTapped) forControlEvents:UIControlEventTouchUpInside];

  CGFloat buttonHeight = itemHeight * 3;
  cancelButton.layer.masksToBounds = YES;
  cancelButton.layer.cornerRadius = buttonHeight / 2;
  cancelButton.frame = CGRectMake(self.view.frame.size.width / 2.0 - buttonHeight / 2.0,
                                CGRectGetMaxY(sendButton.frame) + itemTopMargin,
                                buttonHeight, buttonHeight);
  [self.view addSubview:cancelButton];
  
}


- (void)setBaseView:(UIView*)baseView frame:(CGRect)frame {

  baseView.frame = frame;
  baseView.backgroundColor = baseViewColor;
  baseView.layer.masksToBounds = YES;
  baseView.layer.cornerRadius = 5;
  [self.view addSubview:baseView];
  
}

- (void)setLabel:(UILabel*)label frame:(CGRect)frame text:(NSString*)text baseView:(UIView*)baseView {

  label.text = text;
  label.textColor = UIColor.whiteColor;
  label.frame = frame;
  [baseView addSubview:label];

}

- (void)setTextField:(UITextField*)textField frame:(CGRect)frame placeholder:(NSString*)placeholder baseView:(UIView*)baseView {

  textField.frame = frame;
  textField.backgroundColor = UIColor.clearColor;
  textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder
                                                                    attributes:@{NSForegroundColorAttributeName : UIColor.lightGrayColor}];
  textField.textColor = UIColor.whiteColor;
  textField.layer.cornerRadius = 5;
  textField.layer.masksToBounds = YES;
  textField.autocapitalizationType = UITextAutocapitalizationTypeNone;

  CALayer* bottomLine = [CALayer new];
  bottomLine.frame = CGRectMake(0.0, frame.size.height - 1.0, frame.size.width, 1.0);
  bottomLine.backgroundColor = UIColor.whiteColor.CGColor;
  textField.borderStyle = UITextBorderStyleNone;
  [textField.layer addSublayer:bottomLine];

  [baseView addSubview:textField];

}

-(void)onSendButtonTapped {
  
  NSMutableArray* events = [[NSMutableArray alloc] init];
  if (eventText1.text && [eventText1.text length] > 0) {
    [events addObject:eventText1.text];
  }
  if (eventText2.text && [eventText2.text length] > 0) {
    [events addObject:eventText2.text];
  }
  if (eventText3.text && [eventText3.text length] > 0) {
    [events addObject:eventText3.text];
  }

  NSMutableDictionary* variables = [[NSMutableDictionary alloc] init];
  if (variable1Name.text && [variable1Name.text length] > 0 &&
      variable1Value.text && [variable1Value.text length] > 0) {
    variables[variable1Name.text] = variable1Value.text;
  }
  if (variable2Name.text && [variable2Name.text length] > 0 &&
      variable2Value.text && [variable2Value.text length] > 0) {
    variables[variable2Name.text] = variable2Value.text;
  }
  if (variable3Name.text && [variable3Name.text length] > 0 &&
      variable3Value.text && [variable3Value.text length] > 0) {
    variables[variable3Name.text] = variable3Value.text;
  }

  NSNumber* standbyTimeValue = nil;
  if (standbyTime.text && [standbyTime.text length] > 0) {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    standbyTimeValue = [formatter numberFromString:standbyTime.text];
  }

  [RFApp postMessage:events variables:variables standbyTime:standbyTimeValue completion:^(RFResult * _Nonnull result, NSArray<NSString *> * _Nonnull eventPostIds) {

    NSMutableString* postIds = [NSMutableString string];
    for (NSString* postId in eventPostIds) {
      NSLog(@"PostId:%@", postId);
      [self->postIds addObject:postId];
      [postIds appendFormat:@"%@\n", postId];
    }

    NSString* message = nil;
    if (result.result) {
      message = [NSString stringWithFormat:@"メッセージ送信リクエストに成功しました。\n送信ID:\n%@", postIds];
      NSLog(@"Post Message has succeeded.");
    } else {
      message = [NSString stringWithFormat:@"メッセージ送信リクエストに失敗しました。\nstatus:%ld\nmessage:%@", result.code, result.message];
      NSLog(@"Post Message has failed.");
    }
    
    dispatch_sync(dispatch_get_main_queue(), ^{
      UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"イベント送信" message:message preferredStyle:UIAlertControllerStyleAlert];
      UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:NULL];
      [alert addAction:defaultAction];
      [self presentViewController:alert animated:YES completion:NULL];
    });
  }];
}

-(void)onCancelButtonTapped {
  for (NSString* postId in postIds) {
    [RFApp cancelPosting:postId completion:^(RFResult * _Nonnull result) {
      if (result.result) {
        NSLog(@"Cancel Message has succeeded. ID:%@", postId);
      } else {
        NSLog(@"Cancel Message has failed. ID:%@", postId);
      }
    }];
  }
  
}

-(void)dismissKeyboard {
  [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
