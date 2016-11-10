//
//  BradgeZjjzy.h
//  chinese
//
//  Created by zhujohnle on 16/2/20.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>


@protocol TestJSObjectProtocol <JSExport>

-(void)showObject:(NSString * )mId;


@end

@protocol BradgeJbzyDelegate <JSExport>

-(void)showObject:(NSString * )mId;


@end


@interface BradgeZjjzy : NSObject<TestJSObjectProtocol>{
    UIWebView *webLeft;
    UIWebView *webRight;
}
@property(nonatomic,assign)id<BradgeJbzyDelegate>delegate;
- (id)initWithWebViewWithLeft: (UIWebView *)mUIWebViewLeft withRight:(UIWebView *) smUIWebViewRight;

@end





