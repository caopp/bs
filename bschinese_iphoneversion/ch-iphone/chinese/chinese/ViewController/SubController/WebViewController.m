//
//  WebViewController.m
//  chinese
//
//  Created by zuojianshijue on 16/1/2.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.strTitle = @"基本字源";
    // Do any additional setup after loading the view.
    _webView.scalesPageToFit = YES;
    _webView.backgroundColor = [UIColor colorWithRed:0.98 green:0.95 blue:0.89 alpha:1];
    [self loadDataUrl:_strUrl];
}
-(void)loadDataUrl:(NSString *)urlStr{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
//    NSURL *url = [NSURL fileURLWithPath:path];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    //self.webView.scalesPageToFit = YES;
//    
//    [self.webView loadRequest:request];
    ;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
   // self.webView.scalesPageToFit = YES;
    [_webView  loadRequest:request];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
