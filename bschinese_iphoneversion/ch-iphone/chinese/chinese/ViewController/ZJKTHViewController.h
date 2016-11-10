//
//  ZJKTHViewController.h
//  chinese
//
//  Created by zuojianshijue on 15/12/8.
//  Copyright © 2015年 zhujohnle. All rights reserved.
//

#import "BaseViewController.h"
#import "Constant.h"

@interface ZJKTHViewController : BaseViewController

@property(strong,nonatomic) IBOutlet UIWebView *mUIWebViewLeft;

@property(strong,nonatomic) IBOutlet  UIWebView *mUIWebViewRight;

@property (weak, nonatomic) IBOutlet UIButton *mBtShowInSystem;


@end
