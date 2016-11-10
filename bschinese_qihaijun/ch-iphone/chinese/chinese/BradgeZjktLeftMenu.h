//
//  BradgeZjktLeftMenu.h
//  chinese
//
//  Created by zhujohnle on 16/1/19.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>

@protocol TestJSObjectProtocolZjkt <JSExport>
-(void)showObject:(NSString * )mId;

@end
@protocol BradgeZjktDelegate <NSObject>
-(void)showObjectWithId:(NSString * )mId;

@end
@interface BradgeZjktLeftMenu : NSObject<TestJSObjectProtocolZjkt>{
    UIWebView *webLeft;
    UIWebView *webRight;
}
@property(nonatomic,assign)id<BradgeZjktDelegate>delegate;
- (id)initWithWebViewWithLeft: (UIWebView *)mUIWebViewLeft withRight:(UIWebView *) smUIWebViewRight;


@end
