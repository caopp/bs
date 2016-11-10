//
//  paintView.h
//  chinese
//
//  Created by zuojianshijue on 16/1/29.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyView.h"
#import "TouchMoveView.h"
@interface paintView : UIView<UIGestureRecognizerDelegate>
{
    CGPoint _origin;
}
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIButton *closeButton;
@property (strong, nonatomic) IBOutlet UIButton *rewriteButton;
@property (strong, nonatomic) IBOutlet MyView *writeView;

@property (strong, nonatomic) IBOutlet TouchMoveView *touchMove;

@end
