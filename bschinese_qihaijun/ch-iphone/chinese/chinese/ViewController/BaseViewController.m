//
//  BaseViewController.m
//  chinese
//
//  Created by zuojianshijue on 15/12/8.
//  Copyright © 2015年 zhujohnle. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController (){
    UILabel *titleLabel;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *viewBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    viewBar.userInteractionEnabled = YES;
    viewBar.image = [UIImage imageNamed:@"bg_actionbar_main_acivity"];
    [self.view addSubview:viewBar];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 2, 60, 40)];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [viewBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/6, 45)];
    titleLabel.center = CGPointMake(self.view.frame.size.width/2, 25);
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [viewBar addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor
    
    self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;//arc4random()%4;//UIModalTransitionStylePartialCurl;
}
-(void)setStrTitle:(NSString *)strTitle{
    titleLabel.text = strTitle;
}
-(void)backView{
    [self dismissViewControllerAnimated:YES
                             completion:^{}];
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
