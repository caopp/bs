//
//  HZCSViewController.m
//  chinese
//
//  Created by zuojianshijue on 15/12/7.
//  Copyright © 2015年 zhujohnle. All rights reserved.
//

#import "HZCSHViewController.h"
#import "HZQYViewController.h"
@interface HZCSHViewController ()
@property (weak, nonatomic) IBOutlet UIButton *hzqyBtn;
@property (weak, nonatomic) IBOutlet UIButton *qwhzBtn;
@property (weak, nonatomic) IBOutlet UIButton *zzffBtn;
@property (weak, nonatomic) IBOutlet UIButton *hzybBtn;
@property (strong, nonatomic) IBOutlet UIImageView *bgImg;

@end

@implementation HZCSHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.strTitle = @"汉字常识";
    UIImage *img = [UIImage imageNamed:@"bg_main_activity.9"];
    img = [img stretchableImageWithLeftCapWidth:2 topCapHeight:2];
    _bgImg.image = img;
}


- (IBAction)hzqyClick:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HZQYViewController *hzcsVC = [storyboard instantiateViewControllerWithIdentifier:@"HZQYViewController"];
    hzcsVC.hztype = HZQYTYPE;
    [self presentViewController:hzcsVC animated:YES completion:^{}];
}
- (IBAction)qwhzClick:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HZQYViewController *hzcsVC = [storyboard instantiateViewControllerWithIdentifier:@"HZQYViewController"];
    hzcsVC.hztype = QWWZTYPE;
    [self presentViewController:hzcsVC animated:YES completion:^{}];
}
- (IBAction)zzffClick:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HZQYViewController *hzcsVC = [storyboard instantiateViewControllerWithIdentifier:@"HZQYViewController"];
    hzcsVC.hztype = ZZFFTYPE;
    [self presentViewController:hzcsVC animated:YES completion:^{}];
}
- (IBAction)hzybClick:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HZQYViewController *hzcsVC = [storyboard instantiateViewControllerWithIdentifier:@"HZQYViewController"];
    hzcsVC.hztype = HZYBTYPE;
    [self presentViewController:hzcsVC animated:YES completion:^{}];
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
