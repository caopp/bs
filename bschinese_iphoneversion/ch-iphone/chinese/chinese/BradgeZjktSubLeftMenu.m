//
//  BradgeZjktSubLeftMenu.m
//  chinese
//
//  Created by zhujohnle on 16/2/2.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//
//
//  BradgeZjktLeftMenu.m
//  chinese
//
//  Created by zhujohnle on 16/1/19.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//

#import "BradgeZjktSubLeftMenu.h"
#import "ZJKTHViewController.h"
#define WebURL @"http://www.yuwen100.cn/yuwen100"


@implementation BradgeZjktSubLeftMenu
-(void)didWebViewLoadFinished{
    
    
    JSContext *context=[webLeft valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //    NSString *alertJS=@"alert('test js OC')"; //准备执行的js代码
    //    [context evaluateScript:alertJS];//通过oc方法调用js的alert
    
    NSString *mActionJsNodeSize=@"javascript:getAllNodeSize()"; //准备执行的js代码
//    
//    NSString *mCurrentSelectedItem =@"javascript:selectNode(" + mCurremtSize
//    + @")";
    
    
   [context evaluateScript:mActionJsNodeSize];//通过oc方法调用js的alert"; //准备执行的js代码
    //    [context evaluateScript:alertJS];//通过oc方法调用js的alert
}

-(void)showObject:(NSString * )mId{
   
    //根据特定的数据播放视频
    //如果mId end with
    mCurrentSize=[mId intValue]; ;
    
    [self.delegate showObjectWithId:mId];
    
    
}

-(void)getAllNodeSize:(NSString *) mAllsize{
    mCurrentSize = 1;
    maxSize = [mAllsize intValue];
    
    [self.delegate showObjectWithId:@"1"];
}



- (id)initWithWebViewWithLeft: (UIWebView *)mUIWebViewLeft withRight:(UIWebView *) smUIWebViewRight{
    
    if (self = [super init])
    {
        webLeft = mUIWebViewLeft;
        webRight = smUIWebViewRight;
    }
    return self;
}

-(void)didWebViewRightLoadFinnished{
    mCurrentSize++;
    if(mCurrentSize<maxSize){
        NSString *stringInt = [NSString stringWithFormat:@"%d",mCurrentSize];
        [self.delegate showObjectWithId:stringInt];
    }
}


@end



