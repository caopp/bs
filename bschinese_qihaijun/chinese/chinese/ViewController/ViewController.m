//
//  ViewController.m
//  chinese
//
//  Created by zhujohnle on 15/11/25.
//  Copyright © 2015年 zhujohnle. All rights reserved.
//

#import "ViewController.h"
#import "ZYYXHViewController.h"
#import "PYXXHViewController.h"
#import "HZCSHViewController.h"
#import "JBZYHViewController.h"
#import "BPHZHViewController.h"
#import "BPCYHViewController.h"
#import "ZYCDHViewController.h"
#import "ZJKTHViewController.h"
#import "LoginViewController.h"
#import "MusicViewController.h"
#import "AppDelegate.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *pyxx;
@property (weak, nonatomic) IBOutlet UIImageView *backImg;
@property (weak, nonatomic) IBOutlet UIButton *hzcs;
@property (weak, nonatomic) IBOutlet UIButton *jbzy;
@property (weak, nonatomic) IBOutlet UIButton *zyyx;
@property (weak, nonatomic) IBOutlet UIButton *bphz;
@property (weak, nonatomic) IBOutlet UIButton *bpcy;

@property (weak, nonatomic) IBOutlet UIButton *zycd;
@property (weak, nonatomic) IBOutlet UIButton *zjkt;
@property (strong, nonatomic) IBOutlet UIButton *jdls;
@end

@implementation ViewController
- (IBAction)showMore:(id)sender {
    if (sender ==_zyyx) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ZYYXHViewController *zyyxVC = [storyboard instantiateViewControllerWithIdentifier:@"ZYYXHViewController"];
        [self presentViewController:zyyxVC animated:YES completion:^{}];
        
        
        NSLog(@"you");
    }else if(sender == _pyxx){
        PYXXHViewController *pyxxVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PYXXHViewController"];
        [self presentViewController:pyxxVC animated:YES completion:nil];
//        pyxx
//        pyxx`* destViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CSPPayAvailabelViewController"];
//        destViewController.orderAddDTO = orderAddDTO;
//        destViewController.isAvailable = YES;
//        [self.navigationController pushViewController:destViewController animated:YES];
    }
    else if(sender == _hzcs){

        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HZCSHViewController *hzcsVC = [storyboard instantiateViewControllerWithIdentifier:@"HZCSHViewController"];
        [self presentViewController:hzcsVC animated:YES completion:^{}];
    }
    else if(sender == _jbzy){
        JBZYHViewController *jbzyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"JBZYHViewController"];
        [self presentViewController:jbzyVC animated:YES completion:nil];
    }
    else if(sender == _bphz){
        BPHZHViewController *bphzVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BPHZHViewController"];
        bphzVC.totalCount = 7000;
        bphzVC.modeCount = 500;
        [self presentViewController:bphzVC animated:YES completion:nil];
    }
    else if(sender == _bpcy){
        BPCYHViewController *bpcyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BPCYHViewController"];
//         BPHZHViewController *bpcyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BPHZHViewController"];
        bpcyVC.totalCount = 13000;
        bpcyVC.modeCount = 1000;
        [self presentViewController:bpcyVC animated:YES completion:nil];
    }
    else if(sender == _zycd){
        ZYCDHViewController *zycdVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ZYCDHViewController"];
        [self presentViewController:zycdVC animated:YES completion:nil];
    }
    else if(sender == _zjkt){
        ZJKTHViewController *zjktVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ZJKTHViewController"];
        [self presentViewController:zjktVC animated:YES completion:nil];
    }else if(sender == _jdls){
        
        MusicViewController *music = [[MusicViewController alloc] init];
        [self presentViewController:music animated:YES completion:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //_backImg.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view, typically from a nib.
   BOOL loginYes = [[NSUserDefaults standardUserDefaults] boolForKey:@"LoginYes"];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    if (loginYes&&delegate.network) {
    }else{
        [self performSelector:@selector(showLogin) withObject:nil afterDelay:0.1];
   }
   // [self performSelector:@selector(showLogin) withObject:nil afterDelay:0.1];
}

-(void)showLogin{
    LoginViewController *login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:login animated:YES completion:nil];
}
-(void)viewDidAppear:(BOOL)animated{
  //添加跳转登录页面。
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
