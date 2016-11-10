//
//  JBZYHViewController.m
//  chinese
//
//  Created by zuojianshijue on 15/12/8.
//  Copyright © 2015年 zhujohnle. All rights reserved.
//

#import "JBZYHViewController.h"
#import "JBZYSubViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "BradgeJbzybh.h"
#import "WebViewController.h"
#import "ZYYXHViewController.h"
#import "ZjjzyViewController.h"
@interface JBZYHViewController ()<UIWebViewDelegate,BradgeJbzyDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *bgImgView;
@property (strong, nonatomic) IBOutlet UIImageView *menuView;
@property (strong, nonatomic) IBOutlet UIImageView *contentView;
@property (strong, nonatomic) IBOutlet UIView *numbView;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property(strong,nonatomic) NSArray *dataArray;
@end

@implementation JBZYHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView.delegate = self;
    _webView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0.80 alpha:1];
    self.strTitle = @"基本字源";
    UIImage *img = [UIImage imageNamed:@"bg_main_activity.9"];
    img = [img stretchableImageWithLeftCapWidth:2 topCapHeight:2];
    _bgImgView.image = img;//[UIImage imageNamed:@"bg_main_activity.9"];
    // Do any additional setup after loading the view.
    _dataArray = [[NSArray alloc] initWithObjects:@"", nil];
    //_webView.scalesPageToFit = YES;
     self.webView.scrollView.zoomScale = 2;
    [self loadWebUrl:@"2"];
}



-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //网页加载完成调用此方法
    
    
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //第二种情况，js是通过对象调用的，我们假设js里面有一个对象 testobject 在调用方法
    //首先创建我们新建类的对象，将他赋值给js的对象
    
    BradgeJbzybh *testJO=[BradgeJbzybh new] ;
    testJO.delegate = self;
    context[@"zyobject"]=testJO;
    
}
- (IBAction)showMore:(UIButton *)sender {
    if (sender.tag==99) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ZYYXHViewController *zyyxVC = [storyboard instantiateViewControllerWithIdentifier:@"ZYYXHViewController"];
        [self presentViewController:zyyxVC animated:YES completion:^{}];
    }else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        JBZYSubViewController *hzcsVC = [storyboard instantiateViewControllerWithIdentifier:@"JBZYSubViewController"];
        hzcsVC.type =  (int)sender.tag;
        [self presentViewController:hzcsVC animated:YES completion:^{}];
    }
    
}
-(void)showObjectWithId:(NSString *)mId{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WebViewController *webVC = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    webVC.strUrl = [NSString stringWithFormat:@"http://www.yuwen100.cn/yuwen100/hzzy/ios/jbzy-iPhone/%@/index.html",mId];
    [self presentViewController:webVC animated:YES completion:^{}];
}
- (IBAction)showZy:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ZjjzyViewController *zjjzy = [storyboard instantiateViewControllerWithIdentifier:@"ZjjzyViewController"];
    [self presentViewController:zjjzy animated:YES completion:^{}];
}
-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"width==%f",_numbView.frame.size.width);
}
-(void)viewWillAppear:(BOOL)animated{
    [self addnumb];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    // [self addnumb];
}
-(void)awakeFromNib{
   
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

-(void)addnumb{
    for (UIButton *btn in _numbView.subviews) {
        [btn removeFromSuperview];
    }
    float w = (self.view.frame.size.width*2/7-60)/5;
    for (int i = 0; i <11; i++) {
        
        UIButton *numb_btn = [[UIButton alloc] initWithFrame:CGRectMake(10 + w*(i%5), 30 + (w)*(i/5),w, w*4/5)];
        numb_btn.tag =  i+2;
        [numb_btn setBackgroundImage:[UIImage imageNamed:@"bihua_bg_normal"] forState:UIControlStateNormal];
        [numb_btn setBackgroundImage:[UIImage imageNamed:@"bihua_bg_pressed"] forState:UIControlStateSelected];
         [numb_btn setBackgroundImage:[UIImage imageNamed:@"bihua_bg_pressed"] forState:UIControlStateHighlighted];
        [numb_btn addTarget:self action:@selector(changeData:) forControlEvents:UIControlEventTouchUpInside];
        numb_btn.backgroundColor = [UIColor redColor];
        numb_btn.titleLabel.text = [NSString stringWithFormat:@"%d",i+2];
        numb_btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_numbView addSubview:numb_btn];
        
       [numb_btn setTitle:[NSString stringWithFormat:@"%d",i+2]forState:UIControlStateNormal];
        if (i==10) {
            numb_btn.frame = CGRectMake(10 + w*(i%5), 30 + (w)*(i/5), w*3, w*4/5);
           [numb_btn setTitle:[NSString stringWithFormat:@"%d以上",i+2]forState:UIControlStateNormal];
            
        }
        
        
    }
}

-(void)changeData:(UIButton *)btn{
    
    [self loadWebUrl:[NSString stringWithFormat:@"%ld",btn.tag]];
}
-(void)loadWebUrl:(NSString *)strUrl{
    NSString *path = [[NSBundle mainBundle] pathForResource:strUrl ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //self.webView.scalesPageToFit = YES;
   
    [self.webView loadRequest:request];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"mainDocumentURL===%@",[request URL]);
    return YES;
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
