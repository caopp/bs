//
//  LoginViewController.m
//  chinese
//
//  Created by zuojianshijue on 16/2/4.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//

#import "LoginViewController.h"
#import "AFHTTPSessionManager.h"
#define JYURL @"http://verify.yuwen100.cn"
@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *bgImg;
@property (strong, nonatomic) IBOutlet UIView *loginView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *centY;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _bgImg.backgroundColor = [UIColor redColor];
    _bgImg.image = [UIImage imageNamed:@"ic_login_bg.jpg"];
    [self addNot];
}
- (IBAction)loginClick:(id)sender {
    [self verText];
}
-(void)verText{
//    if (![_userNameText.text length]) {
//        [self showAlert:@"用户名不能为空"];
//        return;
//    }
//    if (![_pwdText.text length]) {
//        [self showAlert:@"密码不能为空"];
//        return;
//    }
//    if (![_phoneText.text length]) {
//        [self showAlert:@"手机号不能为空"];
//        return;
//    }
      [self getData];
}
-(void)showAlert:(NSString *)str{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}
-(void)getData{
    NSString* identifierNumber = [[UIDevice currentDevice].identifierForVendor UUIDString] ;
    //NSString *userid = [APPHelper getStringConfig:User_info_Uid];
    NSDictionary *dict=@{
                         @"account":_userNameText.text,
                         @"password":_pwdText.text,
                         @"mobilephone":_phoneText.text,
                         @"hidVerifyCode":identifierNumber,
                         };
    AFHTTPSessionManager *manager=[AFHTTPSessionManager   manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    //如果报接受类型不一致请替换一致text/html或别的
    
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
    [manager POST:JYURL parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseString===%@",responseObject);
        
        
        int code=[[responseObject objectForKey:@"code"] intValue];
        NSDictionary *dicData = [responseObject objectForKey:@"data"];
        NSString *msg = [responseObject objectForKey:@"msg"];
        if (code==1) {
            NSString *dId = [dicData objectForKey:@"id"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"LoginYes"];
            [[NSUserDefaults standardUserDefaults] setObject:dId forKey:@"LoginId"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self showAlert:msg];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error==%@",error);
    }];
    

    
}


-(void)addNot{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
    // get keyboard size and loctaion
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    _centY.constant = -150;
    
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    // get keyboard size and loctaion
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    _centY.constant = 0 ;
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
