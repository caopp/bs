//
//  BradgeJbzybh.m
//  chinese
//
//  Created by zhujohnle on 16/1/23.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//

#import "BradgeJbzybh.h"

@implementation BradgeJbzybh

-(void)showObject:(NSString * )mId{
    //跳转到具体ID的详情页
    [self.delegate showObjectWithId:mId];
}

@end
