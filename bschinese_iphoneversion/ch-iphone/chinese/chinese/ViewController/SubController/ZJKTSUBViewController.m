//
//  ZJKTSUBViewController.m
//  chinese
//
//  Created by zuojianshijue on 16/1/23.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//

#import "ZJKTSUBViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "BradgeZjktSubLeftMenu.h"
#define SUBWEB @"http://www.yuwen100.cn/yuwen100/hzzy/Android/zhuanjiaindex/"
#define  MBASEURL @"http://www.yuwen100.cn/yuwen100/";
#import "UIWebView+VideoControl.h"

@interface ZJKTSUBViewController ()<UIWebViewDelegate,BradgeZjktSubDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *leftweb;
@property (strong, nonatomic) IBOutlet UIWebView *rightweb;
@property (strong,nonatomic)  IBOutlet UIButton *mButtonShowMovive;

@end


@implementation ZJKTSUBViewController{
    BradgeZjktSubLeftMenu *testJO;
}


-(void)showObjectWithId :(NSString *) mId{
 
    NSString * mBasicUrl = [self getBasicVideoUrl:mId];
    [self playItemVideoByUrl:mBasicUrl];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.strTitle = @"专家课堂";
    _leftweb.scalesPageToFit = YES;
    _leftweb.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0.80 alpha:1];
    _rightweb.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0.80 alpha:1];
    //左边默认地址
    NSArray *arrayId = [_mId  componentsSeparatedByString:@"-"];
 
    NSString *path = [NSString stringWithFormat:@"%@%@/secondpage/index.html",SUBWEB,arrayId[0]];
    NSURL *url = [[NSURL alloc] initWithString:path];
    [self.leftweb loadRequest:[NSURLRequest requestWithURL:url]];     // Do any additional setup after loading the view.
    
    JSContext *context=[self.leftweb valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    testJO=[[BradgeZjktSubLeftMenu alloc] initWithWebViewWithLeft:_leftweb withRight:_rightweb];
    context[@"zjkt"]=testJO;
    testJO.delegate = self;
    self.leftweb.delegate=self;
    self.rightweb.delegate=self;
    
    
    //右边的webview 默认的地址
//    NSString * mRightPath =URL_DEFINE_ZJKT_FIRST_RIGHT;
//    NSURL * mRightPathUri =[[NSURL alloc] initWithString:mRightPath];
//    [self.rightweb loadRequest:[NSURLRequest requestWithURL:mRightPathUri]];
    // Do any additional setup after loading the view.
}
-(void)webViewDidFinishLoad:(UIWebView *) webView
{
    //网页加载完成调用此方法
    if(webView ==self.leftweb){
         [testJO didWebViewLoadFinished];
    }else{
        [testJO didWebViewRightLoadFinnished];

    }
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-  (void) playItemVideoByUrl :(NSString * ) mUrl{

    [_rightweb loadRequest:[NSURLRequest requestWithURL:[NSURL    URLWithString:mUrl]]];
}

-(void)viewWillDisappear:(BOOL)animated{
  
     [_rightweb stop];

}


-(NSString *)getBasicVideoUrl :(NSString *) mCurrentSize{
      NSArray *arrayId = [_mId  componentsSeparatedByString:@"-"];
    NSString * mDefineZj= @"/zhuanjia/";
    NSString * mCurrentSizeVideo=[NSString stringWithFormat:@"/%@.mp4",mCurrentSize];
    NSString * mDefineShiPin =@"/shipin/";
    
    NSString * mBaseUrl = [NSString stringWithFormat:@"http://www.yuwen100.cn/yuwen100%@%@%@%@%@",mDefineZj,arrayId[0],mDefineShiPin,arrayId[1],mCurrentSizeVideo];
    
    return mBaseUrl;
   // http://www.yuwen100.cn/yuwen100/
    
//    mBuilder.append("/zhuanjia/");
//    mBuilder.append(mSpitArray[0] + "/shipin/");
//    mBuilder.append(mSpitArray[1] + "/");
    
 
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
