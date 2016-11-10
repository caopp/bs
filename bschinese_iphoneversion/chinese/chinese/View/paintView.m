//
//  paintView.m
//  chinese
//
//  Created by zuojianshijue on 16/1/29.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//

#import "paintView.h"

@implementation paintView

//撤销
- (IBAction)cancelClick:(id)sender {
    [_writeView revocation];
}
- (IBAction)closeClick:(id)sender {
    UIView *view = [self superview];
    view.hidden = YES;
    [self removeFromSuperview];
}
//重写
- (IBAction)rewriteClick:(id)sender {
    
    [_writeView clear];
}
-(void)awakeFromNib{
    //_bgImg.image = [UIImage imageNamed:@"tian"];
    UIPanGestureRecognizer *_panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    _panGesture.delegate = self;
    [self.touchMove addGestureRecognizer:_panGesture];
}

- (void)onPan:(UIPanGestureRecognizer *)pan
{
    
    CGPoint translation = [pan translationInView:self];
    //CGPoint velocity = [pan velocityInView:self];
   // CGPoint local = [pan locationInView:self];
//    if ((local.x>100&&local.x <500&&local.y>100&&local.y<500)) {
//        return;
//    }
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            _origin = self.frame.origin;
            CGRect f = self.frame;
            self.frame = f;
          
            break;
        case UIGestureRecognizerStateChanged:
            
            
                self.transform = CGAffineTransformMakeTranslation(translation.x, translation.y);

                
         
            break;
            
        case UIGestureRecognizerStateCancelled:
            [pan setEnabled:YES];
            break;
        case UIGestureRecognizerStateEnded:
        {

            //[self transitionToDown:(velocity.y >= 0)];
        }
            break;
            
        default:
            break;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
