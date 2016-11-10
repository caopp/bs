//
//  AppDelegate.m
//  chinese
//
//  Created by zhujohnle on 15/11/25.
//  Copyright © 2015年 zhujohnle. All rights reserved.
//

#import "AppDelegate.h"
#import "SDBManager.h"
#import "Reachability.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
       [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    // 沙盒Docu目录
    NSString * docp = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * _name = [docp stringByAppendingString:[NSString stringWithFormat:@"/%@.db",kDefaultDBName]];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL exist = [fileManager fileExistsAtPath:_name];
    if (exist) {
        
    }else {
         NSString * docp = [[NSBundle mainBundle] pathForResource:kDefaultDBName ofType:@"db"];
        NSData *data = [NSData dataWithContentsOfFile:docp];
        BOOL bo =[data writeToFile:_name atomically:YES];
        NSLog(@"bo===%d",bo);
    }
    self.network = [self NetReachable];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)prefersStatusBarHidden
{
    // iOS7后,[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    // 已经不起作用了
    return YES;
}

//监测网络
-(BOOL)NetReachable{
    Reachability *r = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
        {
            // 没有网络连接
            NSLog(@"没有网络");
            // UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
            //[GlobalMath showNotifyWithView:window withImage:nil withText:@"请检测网络"];
            return NO;
        }
            break;
        case ReachableViaWWAN:
        {
            // 使用3G网络
            NSLog(@"正在使用3G网络");
            return YES;
        }
            break;
        case ReachableViaWiFi:{
            
            
            // 使用WiFi网络
            NSLog(@"正在使用wifi网络");
            return YES;
        }
            break;
    }
    return NO;
}


@end
