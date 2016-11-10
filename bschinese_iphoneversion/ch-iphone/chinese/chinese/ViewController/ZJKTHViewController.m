//
//  ZJKTHViewController.m
//  chinese
//
//  Created by zuojianshijue on 15/12/8.
//  Copyright © 2015年 zhujohnle. All rights reserved.
//

#import "ZJKTHViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

#import "BradgeZjktLeftMenu.h"
#import "ZJKTSUBViewController.h"
@interface ZJKTHViewController ()<UIWebViewDelegate,BradgeZjktDelegate>

{
    //定义本类中的变量等
    //
}


@end



@implementation ZJKTHViewController


#pragma mark --webViewDelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //网页加载之前会调用此方法
    
    //retrun YES 表示正常加载网页 返回NO 将停止网页加载
    
    
    
//    
//    //同样我们也用刚才的方式模拟一下js调用方法
//    NSString *jsStr1=@"testobject.TestNOParameter()";
//    [context evaluateScript:jsStr1];
//    NSString *jsStr2=@"testobject.TestOneParameter('参数1')";
//    [context evaluateScript:jsStr2];
//    NSString *jsStr3=@"testobject.TestTowParameterSecondParameter('参数A','参数B')";
//    [context evaluateScript:jsStr3];
    
    
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //开始加载网页调用此方法
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //网页加载完成调用此方法
    
    
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //第二种情况，js是通过对象调用的，我们假设js里面有一个对象 testobject 在调用方法
    //首先创建我们新建类的对象，将他赋值给js的对象
    
    BradgeZjktLeftMenu *testJO=[[BradgeZjktLeftMenu alloc] initWithWebViewWithLeft:_mUIWebViewLeft withRight:_mUIWebViewRight];
    testJO.delegate = self;
    context[@"zjktd"]=testJO;

}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //网页加载失败 调用此方法
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.strTitle = @"专家课堂";
    //左边默认地址
    NSString *path = URL_ZJKT_FIRSTPAGE_LEFTMENU;
    NSURL *url = [[NSURL alloc] initWithString:path];
    [self.mUIWebViewLeft loadRequest:[NSURLRequest requestWithURL:url]];     // Do any additional setup after loading the view.
    _mUIWebViewLeft.scalesPageToFit = YES;
    _mUIWebViewLeft.backgroundColor =[UIColor colorWithRed:0.99 green:0.96 blue:0.90 alpha:1];
    _mUIWebViewRight.backgroundColor = [UIColor colorWithRed:0.99 green:0.96 blue:0.90 alpha:1];
    _mUIWebViewLeft.delegate=self;
    
    //右边的webview 默认的地址
    NSString * mRightPath =URL_DEFINE_ZJKT_FIRST_RIGHT;
    NSURL * mRightPathUri =[[NSURL alloc] initWithString:mRightPath];
    [self.mUIWebViewRight loadRequest:[NSURLRequest requestWithURL:mRightPathUri]];
    // Do any additional setup after loading the view.]
    
//    
//    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    NSString *alertJS=@"alert('test js OC')"; //准备执行的js代码
//    [context evaluateScript:alertJS];//通过oc方法调用js的alert
    
}
-(void)showObjectWithId:(NSString *)mId{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ZJKTSUBViewController *zjktSub = [storyboard instantiateViewControllerWithIdentifier:@"ZJKTSUBViewController"];
    zjktSub.mId = mId;
    [self presentViewController:zjktSub animated:YES completion:^{}];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

//单个条目点击的时候 提示相关内容
-(void)onItemTreeViewClick{
    [self playVideoWithWebView:@""];
}


-(void)playVideoWithWebView:mPlayUrl{
    
    UIWebView *myWeb = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    NSURL *url = [NSURL URLWithString:@"http:devimages.apple.com/iphone/samples/bipbop/gear1/prog_index.m3u8"];
                  
                  NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
                  [myWeb loadRequest:request];
}



@end
