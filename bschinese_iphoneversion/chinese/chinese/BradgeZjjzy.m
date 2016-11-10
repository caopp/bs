//
//  BradgeZjjzy.m
//  chinese
//
//  Created by zhujohnle on 16/2/20.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//

#import "BradgeZjjzy.h"

@implementation BradgeZjjzy 

-(void)showObject:(NSString * )mId{
    //跳转到具体ID的详情页
    [self.delegate showObject:mId];
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

