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

@protocol TestJSObjectProtocol <JSExport>
-(void)showObject:(NSString * )mId;
-(void)getAllNodeSize:(NSString *) mCurrentSize;

@end
@protocol BradgeZjktSubDelegate <NSObject>
-(void)showObjectWithId:(NSString * )mId;



@end
@interface BradgeZjktSubLeftMenu : NSObject<TestJSObjectProtocol>{
    UIWebView *webLeft;
    UIWebView *webRight;
    int mCurrentSize;
    int maxSize;
}
@property(nonatomic,assign)id<BradgeZjktSubDelegate>delegate;
- (id)initWithWebViewWithLeft: (UIWebView *)mUIWebViewLeft withRight:(UIWebView *) smUIWebViewRight;
-(void)didWebViewLoadFinished;
-(void)didWebViewRightLoadFinnished;
@end
