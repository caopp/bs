//
//  BradgeJbzybh.h
//  chinese
//
//  Created by zhujohnle on 16/1/23.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>


@protocol TestJSObjectProtocolJbzy <JSExport>

-(void)showObject:(NSString * )mId;


@end
@protocol BradgeJbzyDelegate <JSExport>

-(void)showObjectWithId:(NSString * )mId;


@end
#import <JavaScriptCore/JavaScriptCore.h>

@interface BradgeJbzybh : NSObject<TestJSObjectProtocolJbzy>
@property(nonatomic,assign)id<BradgeJbzyDelegate>delegate;
@end
