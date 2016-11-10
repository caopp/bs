//
//  ZjjzyViewController.m
//  chinese
//
//  Created by zhujohnle on 16/2/20.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//

#import "ZjjzyViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "BradgeZjjzy.h"
#import "UIWebView+VideoControl.h"

@interface ZjjzyViewController ()<UIWebViewDelegate,BradgeJbzyDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *leftweb;
@property (strong, nonatomic) IBOutlet UIWebView *rightweb;

@end



@implementation ZjjzyViewController

-(void)showObject :(NSString *) mId{
    NSString *mBasicUrl = @"http://www.yuwen100.cn/yuwen100/hzzy/jbzy-clips/video/%@.mp4";
    
    [self playItemVideoByUrl:[NSString stringWithFormat:mBasicUrl,mId]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.strTitle = @"专家讲字源";
    self.rightweb.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0.80 alpha:1];
    self.leftweb.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0.80 alpha:1];
    
    //左边默认地址
    NSString *path = [[NSBundle mainBundle] pathForResource:@"videoindex" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
 
    [self.leftweb loadRequest:[NSURLRequest requestWithURL:url]];     // Do any additional setup after loading the view.
    
    self.leftweb.delegate=self;
    [self showObject:@"1"];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //网页加载完成调用此方法
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    BradgeZjjzy *testJO=[[BradgeZjjzy alloc] initWithWebViewWithLeft:_leftweb withRight:_rightweb];
    context[@"zjjzy"]=testJO;
    testJO.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillDisappear:(BOOL)animated{
     [_rightweb stop];
}

-  (void) playItemVideoByUrl :(NSString * ) mUrl{
    
    [_rightweb loadRequest:[NSURLRequest requestWithURL:[NSURL    URLWithString:mUrl]]];
}


@end



