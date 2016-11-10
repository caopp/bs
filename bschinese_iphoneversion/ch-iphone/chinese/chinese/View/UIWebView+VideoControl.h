//
//  UIWebView+VideoControl.h
//  Enjoy
//
//  Created by zeng songgen on 12-10-15.
//  Copyright (c) 2012年 zeng songgen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (VideoControl)


- (BOOL)hasVideo;
- (NSString *)getVideoTitle;
- (double)getVideoDuration;
- (double)getVideoCurrentTime;

- (int)play;
- (int)pause;
- (int)resume;
- (int)stop;

@end