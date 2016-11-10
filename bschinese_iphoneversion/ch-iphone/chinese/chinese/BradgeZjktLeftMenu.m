//
//  BradgeZjktLeftMenu.m
//  chinese
//
//  Created by zhujohnle on 16/1/19.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//

#import "BradgeZjktLeftMenu.h"
#import "ZJKTHViewController.h"
#define WebURL @"http://www.yuwen100.cn/yuwen100"
@implementation BradgeZjktLeftMenu


-(void)showObject:(NSString * )mId{
    if ([mId hasSuffix:@".html"]) {
        NSString *strUrl = [NSString stringWithFormat:@"%@%@",WebURL,mId];
        NSURL *url = [NSURL URLWithString:strUrl];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [webRight loadRequest:request];
    }else{
        [self.delegate showObjectWithId:mId];
    }
    
    //如果mId end with
    
    
}

- (id)initWithWebViewWithLeft: (UIWebView *)mUIWebViewLeft withRight:(UIWebView *) smUIWebViewRight{
    
    if (self = [super init])
    {
        webLeft = mUIWebViewLeft;
        webRight = smUIWebViewRight;
    }
    return self;
}

@end



