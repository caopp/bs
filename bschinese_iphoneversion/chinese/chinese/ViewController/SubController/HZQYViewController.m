//
//  HZQYViewController.m
//  chinese
//
//  Created by zuojianshijue on 15/12/7.
//  Copyright © 2015年 zhujohnle. All rights reserved.
//

#import "HZQYViewController.h"
#define WithMode  1.5
@interface HZQYViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIView *menuView;
@property (strong, nonatomic) IBOutlet UIImageView *imgBk;

@property(strong,nonatomic)NSMutableArray *arrUrl;
@property(strong,nonatomic)NSArray *arrImg;
@property(strong,nonatomic)NSArray *arrSelectImg;
@end

@implementation HZQYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
     http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziqiyuan/cjzz/index.html
     */
    _webView.scalesPageToFit = NO;
    _webView.backgroundColor = [UIColor colorWithRed:0.98 green:0.95 blue:0.74 alpha:1];
    _arrUrl = [[NSMutableArray alloc] initWithCapacity:0];
    switch (_hztype) {
        case HZQYTYPE:
             self.strTitle = @"汉字起源";
            [self loadWebUrl:@"http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziqiyuan/zx/index.html"];
            [_menuView addSubview:[self creatHZQY]];
            break;
        case QWWZTYPE:
             self.strTitle = @"趣味汉字";
            [self loadWebUrl:@"http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/zmg/index.html"];
            [_menuView addSubview:[self creatQWHZ]];
            break;
        case ZZFFTYPE:
             self.strTitle = @"造字方法";
            [self loadWebUrl:@"http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/zx/index.html"];
            [_menuView addSubview:[self creatZZFF]];
            break;
        case HZYBTYPE:
             self.strTitle = @"汉字演变";
            [self loadWebUrl:@"http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziyanbian/zx/index.html"];
            [_menuView addSubview:[self creatHZYB]];
            break;
        default:
            break;
    }

    
}
//汉字起源
/*
 <!--汉字常识 汉字起源 结绳记事  -->
 <string-array name="hzcs_hzqy_jsjs_picarray">
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziqiyuan/jsjs/index.html</item>
 </string-array>
 
 <!--汉字常识 汉字演变 伏羲八卦 -->
 <string-array name="hzcs_hzqy_fxbg_picarray">
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziqiyuan/fxbg/index.html</item>
 
 </string-array>
 <!--汉字常识 汉字起源 仓颉造字  -->
 <string-array name="hzcs_hzqy_cjzz_picarray">
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziqiyuan/cjzz/index.html</item>
 <!--   <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziqiyuan/cjzz/index.html</item> -->
 </string-array>
 */
-(UIView *)creatHZQY{
    _imgBk.image = [UIImage imageNamed:@"hzqy_ditalbg.9"];
    [_arrUrl addObject:@"http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziqiyuan/jsjs/index.html"];
    [_arrUrl addObject:@"http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziqiyuan/cjzz/index.html"];
    [_arrUrl addObject:@"http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziqiyuan/fxbg/index.html"];
//    http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziqiyuan/jsjs/index.html
    //http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziqiyuan/fxbg/index.html
    //http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziqiyuan/cjzz/index.html
    
    _arrImg = [[NSArray alloc] initWithObjects:@"bg_jsjs_normal",@"bg_cjzz_normal",@"bg_fxbg_mormal", nil];
    _arrSelectImg = [[NSArray alloc] initWithObjects:@"bg_jsjs_pressed",@"bg_cjzz_pressed",@"bg_fxbg_pressed", nil];
    UIImageView *viewBk = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150*WithMode, 347*WithMode)];
    viewBk.center= CGPointMake(viewBk.frame.size.width/2, self.view.frame.size.height/2);
    viewBk.image = [UIImage imageNamed:@"hzqy_menubg"];
    viewBk.userInteractionEnabled = YES;
    for (int i = 0; i <3; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(70, 40+100*WithMode*i, 63*WithMode, 66*WithMode)];
        button.tag = i;
        [button setBackgroundImage:[UIImage imageNamed:[_arrImg objectAtIndex:i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:[_arrSelectImg objectAtIndex:i]] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(showUrl:) forControlEvents:UIControlEventTouchUpInside];
        [viewBk addSubview:button];
    }
    
    return viewBk;
}

//
/*
 <!--汉字常识 汉字演变 甲骨文  -->
 <string-array name="hzcs_hzyb_jgw_picarray">
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziyanbian/jgw/index.html</item>

 </string-array>
 <!--汉字常识 汉字演变 金文  -->
 <string-array name="hzcs_hzyb_jw_picarray">
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziyanbian/jw/index.html</item>

 </string-array>
 
 <!--汉字常识 汉字演变 隶书  -->
 <string-array name="hzcs_hzyb_ls_picarray">
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziyanbian/ls/index.html</item>

 </string-array>
 
 <!--汉字常识 汉字演变 楷书  -->
 <string-array name="hzcs_hzyb_ks_picarray">
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziyanbian/ks/index.html</item>

 </string-array>
 
 <!--汉字常识 汉字演变 纂书  -->
 <string-array name="hzcs_hzyb_zs_picarray">
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziyanbian/zs/index.html</item>

 </string-array>
 
 */
-(UIView *)creatQWHZ{
    _imgBk.image = [UIImage imageNamed:@"quhz_bg.9"];
    
    [_arrUrl addObject:@"http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/zmg/index.html"];
    [_arrUrl addObject:@"http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/xyg/index.html"];
    [_arrUrl addObject:@"http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/qwhz/index.html"];
    [_arrUrl addObject:@"http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/cbzqh/index.html"];
    [_arrUrl addObject:@"http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/sjxhz/index.html"];
    
    _arrImg = [[NSArray alloc] initWithObjects:@"qwhz_zmg_normal",@"qwhz_xyg_normal",@"qwhz_qhz_normal",@"qwhz_cbz_normal",@"qwhz_sjx_normal", nil];
    _arrSelectImg = [[NSArray alloc] initWithObjects:@"qwhz_zmg_pressed",@"qwhz_xyg_pressed",@"qwhz_qhz_pressed",@"qwhz_cbz_pressed",@"qwhz_sjx_pressed", nil];
    UIImageView *viewBk = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150*WithMode, 280*WithMode)];
    viewBk.center= CGPointMake(viewBk.frame.size.width/2, self.view.frame.size.height/2);
    viewBk.image = [UIImage imageNamed:@"qwhz_menubg"];
    viewBk.userInteractionEnabled = YES;
    for (int i = 0; i <5; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(25*WithMode, (20+50*i)*WithMode, 80*WithMode, 35*WithMode)];
        button.tag = i;
        if (i==2) {
            button.frame = CGRectMake(20*WithMode, (15+50*i)*WithMode, 110*WithMode, 35*WithMode);
        }
        if (i==3) {
            button.frame = CGRectMake(15*WithMode, (32+40*i)*WithMode, 120*WithMode, 55*WithMode);
        }
        if (i == 4) {
            button.frame = CGRectMake(10*WithMode, (45+40*i)*WithMode, 120*WithMode, 55*WithMode);
        }
        [button setBackgroundImage:[UIImage imageNamed:[_arrImg objectAtIndex:i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:[_arrSelectImg objectAtIndex:i]] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(showUrl:) forControlEvents:UIControlEventTouchUpInside];
        [viewBk addSubview:button];
    }
    
    return viewBk;
}
/*         <!-- 造字方法 会意 -->
 <string-array name="hzcs_zzff_hy_picarray">
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/hy/index.html</item>
 <!--  <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/hy/hy-2.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/hy/hy-3.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/hy/hy-4.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/hy/hy-5.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/hy/hy-6.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/hy/hy-7.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/hy/hy-8.jpg</item> -->
 </string-array>
 
 <!-- 造字方法 假借 -->
 <string-array name="hzcs_zzff_jj_picarray">
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/jj/index.html</item>
 <!-- <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/jj/jj-2.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/jj/jj-3.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/jj/jj-4.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/jj/jj-5.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/jj/jj-6.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/jj/jj-7.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/jj/jj-8.jpg</item> -->
 </string-array>
 
 
 <!-- 造字方法 形声 -->
 <string-array name="hzcs_zzff_xs_picarray">
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/xs/index.html</item>
 <!--    <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/xs/xs-2.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/xs/xs-3.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/xs/xs-4.jpg</item> -->
 </string-array>
 
 <!-- 造字方法 象形 -->
 <string-array name="hzcs_zzff_xx_picarray">
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/xx/index.html</item>
 <!-- <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/xx/xx-2.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/xx/xx-3.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/xx/xx-4.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/xx/xx-5.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/xx/xx-6.jpg</item> -->
 </string-array>
 
 <!-- 造字方法 指事 -->
 <string-array name="hzcs_zzff_zs_picarray">
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/zs/index.html</item>
 <!-- <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/zs/zs-2.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/zs/zs-3.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/zs/zs-4.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/zs/zs-5.jpg</item> -->
 </string-array>
 
 
 <!-- 造字方法 zz -->
 <string-array name="hzcs_zzff_zz_picarray">
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/zz/index.html</item>
 <!--  <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/zz/zz-2.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/zz/zz-3.jpg</item> -->
 </string-array>
 */
-(UIView *)creatZZFF{
    _imgBk.image = [UIImage imageNamed:@"hzqy_ditalbg.9"];
    [_arrUrl addObject:@"http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/xx/index.html"];
    [_arrUrl addObject:@"http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/zs/index.html"];
    [_arrUrl addObject:@"http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/hy/index.html"];
    [_arrUrl addObject:@"http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/xs/index.html"];
    [_arrUrl addObject:@"http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/jj/index.html"];
    [_arrUrl addObject:@"http://www.yuwen100.cn/yuwen100/hzzy/ios/zaozifangfa/zz/index.html"];
    //    http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziqiyuan/jsjs/index.html
    //http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziqiyuan/fxbg/index.html
    //http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziqiyuan/cjzz/index.html
    
    _arrImg = [[NSArray alloc] initWithObjects:@"zzff_xx_normal",@"zzff_zs_normal",@"zzff_hy_normal",@"zzff_xs_normal",@"zzff_jj_normal",@"zzff_zz_normal", nil];
    _arrSelectImg = [[NSArray alloc] initWithObjects:@"zzff_xx_pressed",@"zzff_zs_pressed",@"zzff_hy_pressed",@"zzff_xs_pressed",@"zzff_jj_pressed",@"zzff_zz_pressed", nil];
    UIImageView *viewBk = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150*WithMode,420*WithMode)];
    viewBk.image = [UIImage imageNamed:@"zzff_menubg"];
    viewBk.userInteractionEnabled = YES;
    viewBk.center = CGPointMake(viewBk.frame.size.width/2, self.view.frame.size.height/2);
    for (int i = 0; i <6; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15*WithMode, (15+70*i)*WithMode, 60*WithMode, 40*WithMode)];
        button.tag = i;
        [button addTarget:self action:@selector(showUrl:) forControlEvents:UIControlEventTouchUpInside];
        [viewBk addSubview:button];
        CGRect rect = button.frame;
        if (i ==1) {
            rect.origin.x += 10*WithMode;
            button.frame = rect;
        }
        if (i == 2) {
            rect.origin.x += 10*WithMode;
            button.frame = rect;
        }
        if (i == 3) {
            rect.origin.x += 15*WithMode;
            button.frame = rect;
        }
        if (i == 4) {
            rect.origin.y -= 10*WithMode;
            button.frame = rect;
        }
        if (i == 5) {
            rect.origin.x += 10*WithMode;
            rect.origin.y -= 10*WithMode;
            button.frame = rect;
        }
        [button setBackgroundImage:[UIImage imageNamed:[_arrImg objectAtIndex:i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:[_arrSelectImg objectAtIndex:i]] forState:UIControlStateHighlighted];
    }
    
    return viewBk;
}
/*
 <string-array name="hzcs_qwhz_zmg_picarray">
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/zmg/index.html</item>
 <!-- <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/zmg/zmg-2.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/zmg/zmg-3.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/zmg/zmg-4.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/zmg/zmg-5.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/zmg/zmg-6.jpg</item> -->
 </string-array>
 
 
 <string-array name="hzcs_qwhz_qwhz_picarray">
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/qwhz/index.html</item>
 <!--   <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/qwhz/qwhz-2.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/qwhz/qwhz-3.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/qwhz/qwhz-4.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/qwhz/qwhz-5.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/qwhz/qwhz-6.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/qwhz/qwhz-7.jpg</item> -->
 </string-array>
 
 
 <string-array name="hzcs_qwhz_xyg_picarray">
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/xyg/index.html</item>
 <!--  <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/xyg/xyg-2.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/xyg/xyg-3.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/xyg/xyg-4.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/xyg/xyg-5.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/xyg/xyg-6.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/xyg/xyg-7.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/xyg/xyg-8.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/xyg/xyg-9.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/xyg/xyg-10.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/xyg/xyg-11.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/xyg/xyg-12.jpg</item> -->
 </string-array>
 <string-array name="hzcs_qwhz_cbzqu_picarray">
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/cbzqh/index.html</item>
 <!--  <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/cbzqh/cbzqh-2.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/cbzqh/cbzqh-3.jpg</item> -->
 </string-array>
 
 <string-array name="hzcs_qwhz_sjxhz_picarray">
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/sjxhz/index.html</item>
 <!--   <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/sjxhz/sjxhz-2.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/sjxhz/sjxhz-3.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/sjxhz/sjxhz-4.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/sjxhz/sjxhz-5.jpg</item>
 <item>http://www.yuwen100.cn/yuwen100/hzzy/ios/quweihanzi/sjxhz/sjxhz-6.jpg</item> -->
 </string-array>
 
 */
-(UIView *)creatHZYB{
    _imgBk.image = [UIImage imageNamed:@"hzqy_ditalbg.9"];
    [_arrUrl addObject:@"http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziyanbian/jgw/index.html"];
    [_arrUrl addObject:@"http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziyanbian/jw/index.html"];
    [_arrUrl addObject:@"http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziyanbian/zs/index.html"];
    [_arrUrl addObject:@"http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziyanbian/ls/index.html"];
    [_arrUrl addObject:@"http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziyanbian/ks/index.html"];

    //    http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziqiyuan/jsjs/index.html
    //http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziqiyuan/fxbg/index.html
    //http://www.yuwen100.cn/yuwen100/hzzy/ios/hanziqiyuan/cjzz/index.html
    _arrImg = [[NSArray alloc] initWithObjects:@"hzyb_jgw_normal",@"hzyb_jw_normal",@"hzyb_zs_normal",@"hzyb_ls_normal",@"hzyb_ks_normal", nil];
    _arrSelectImg = [[NSArray alloc] initWithObjects:@"hzyb_jgw_pressed",@"hzyb_jw_pressed",@"hzyb_zs_pressed",@"hzyb_ls_pressed",@"hzyb_ks_pressed", nil];
    
    UIImageView *viewBk = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150*WithMode, 500*WithMode)];
    viewBk.image = [UIImage imageNamed:@"hzyb_menubg"];
    viewBk.userInteractionEnabled = YES;
    for (int i = 0; i <5; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20*WithMode, (45+90*i)*WithMode, 64*WithMode, 40*WithMode)];
        button.tag = i;
        [button addTarget:self action:@selector(showUrl:) forControlEvents:UIControlEventTouchUpInside];
        [viewBk addSubview:button];
        CGRect rect = button.frame;
        if (i==0) {
            rect.size.width = 88*WithMode;
            button.frame = rect;
        }
        if (i ==1) {
            rect.origin.x += 10*WithMode;
            button.frame = rect;
        }
        if (i == 2) {
            rect.origin.x += 10*WithMode;
            button.frame = rect;
        }
        if (i == 3) {
            button.frame = rect;
        }
        if (i == 4) {
            rect.origin.y += 10*WithMode;
            button.frame = rect;
        }
        [button setBackgroundImage:[UIImage imageNamed:[_arrImg objectAtIndex:i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:[_arrSelectImg objectAtIndex:i]] forState:UIControlStateHighlighted];
    }

    return viewBk;
}
-(void)showUrl:(UIButton *)btn{
    NSString *url = [_arrUrl objectAtIndex:btn.tag];
    [self loadWebUrl:url];
}
-(void)loadWebUrl:(NSString *)url{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:request];
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
