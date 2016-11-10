//
//  BradgeJdls.h
//  chinese
//
//  Created by caopenpen on 16/8/11.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
@protocol TestJSObjectProtocol <JSExport>

-(void)playitem:(NSString * )mp3url :(NSString *)lrcUrl :(NSString *)instroUrl :(NSString *)articlId :(NSString *)isAdd;
-(void)actionfav:(NSString *)isFav;


@end
@protocol BradgeJdlsDelegate <JSExport>

-(void)playitem:(NSString * )mp3url :(NSString *)lrcUrl :(NSString *)instroUrl :(NSString *)articlId :(NSString *)isAdd;
-(void)actionfav:(NSString *)isFav;

@end
#import <JavaScriptCore/JavaScriptCore.h>

@interface BradgeJdls : NSObject<TestJSObjectProtocol>{
    UIWebView *webLeft;
    UIWebView *webRight;
}
@property(nonatomic,assign)id<BradgeJdlsDelegate>delegate;
- (id)initWithWebViewWithLeft: (UIWebView *)mUIWebViewLeft withRight:(UIWebView *) smUIWebViewRight;
@end
