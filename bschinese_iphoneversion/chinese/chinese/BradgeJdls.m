//
//  BradgeJdls.m
//  chinese
//
//  Created by caopenpen on 16/8/11.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//

#import "BradgeJdls.h"

@implementation BradgeJdls
-(void)playitem:(NSString *)mp3url :(NSString *)lrcUrl :(NSString *)instroUrl :(NSString *)articlId :(NSString *)isAdd{
    //跳转到具体ID的详情页
    [self.delegate playitem:mp3url :lrcUrl :instroUrl :articlId :isAdd];
}

-(void)actionfav:(NSString *)isFav{
    [self.delegate actionfav:isFav];
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
