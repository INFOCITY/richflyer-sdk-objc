//
//  RecieveViewController.h
//  RichFlyer
//
//  Copyright © 2019年 INFOCITY,Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SendMediaTypeImage,
    SendMediaTypeGif,
    SendMediaTypeMovie
}SendMediaType;

@interface RecieveViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
  
}

@end
