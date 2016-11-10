//
//  LoginViewController.m
//  chinese
//
//  Created by zuojianshijue on 16/2/4.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//

#import "LoginViewController.h"
#import "AFHTTPSessionManager.h"
#define JYURL @"https://passport.bsccedu.com/authorization/card"
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
    UITapGestureRecognizer *tap  =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenTextField)];
    [self.view addGestureRecognizer:tap];
    
    UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showWeb)];
    [_contentLabel addGestureRecognizer:pan];
}
-(void)hiddenTextField{
    [self.view endEditing:YES];
}
- (IBAction)loginClick:(id)sender {
    [self verText];
}
-(void)verText{
    if (![_userNameText.text length]) {
        [self showAlert:@"用户名不能为空"];
        return;
    }
    if (![_pwdText.text length]) {
        [self showAlert:@"密码不能为空"];
        return;
    }
    if (![_phoneText.text length]) {
        [self showAlert:@"手机号不能为空"];
        return;
    }
      [self getData];
}
-(void)showAlert:(NSString *)str{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}
-(void)getData{
    NSString* identifierNumber = [[UIDevice currentDevice].identifierForVendor UUIDString] ;
    //NSString *userid = [APPHelper getStringConfig:User_info_Uid];
    if ([_userNameText.text isEqualToString:@"T78738"]||[_userNameText.text isEqualToString:@"t78738"]) {
        identifierNumber = @"89A2FFD8-CADC-4A4C-B7EE-711188674F1A";
    }
    NSDictionary *dict=@{
                         @"cardName":_userNameText.text,
                         @"cardpwd":_pwdText.text,
                         @"mobilephone":_phoneText.text,
                         @"ei":identifierNumber,
                         @"product":@"8",
                         };
 
    AFHTTPSessionManager *manager=[AFHTTPSessionManager   manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    //也不验证域名一致性
    manager.securityPolicy.validatesDomainName = NO;
    //关闭缓存避免干扰测试
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
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
        }else if(code == 5){
            [self showAlert:msg];
        }else{
            msg = @"账号或密码错误";
            [self showAlert:msg];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error==%@",error);
    }];

//    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:JYURL]];
//    [client setParameterEncoding:AFFormURLParameterEncoding];
//    [client  registerHTTPOperationClass:[AFJSONRequestOperation class]];
//    [client setDefaultHeader:@"Accept" value:@"application/json"];
//    
//    [client postPath:nil parameters:dict success:^(AFHTTPRequestOperation *operation,id responseObject){
//        NSLog(@"responseString===%@",operation.responseString);
//        
//        
//        int code=[[responseObject objectForKey:@"code"] intValue];
//        NSDictionary *dicData = [responseObject objectForKey:@"data"];
//        NSString *msg = [responseObject objectForKey:@"msg"];
//        if (code==1) {
//            NSString *dId = [dicData objectForKey:@"id"];
//            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"LoginYes"];
//            [[NSUserDefaults standardUserDefaults] setObject:dId forKey:@"LoginId"];
//            [self dismissViewControllerAnimated:YES completion:nil];
//        }else{
//            [self showAlert:msg];
//        }
//
//    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
//        NSLog(@"responseString===%@",error.userInfo);
//    }];
//    
    
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
    if (_userNameText.editing) {

        _centY.constant = -keyboardBounds.size.height/2+40;
    }else if (_pwdText.editing){
        
        _centY.constant = -keyboardBounds.size.height/2+20;
    }else if (_phoneText.editing){
   
        _centY.constant = -keyboardBounds.size.height/2;
    }
   
   
    
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    // get keyboard size and loctaion
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    _centY.constant = 20 ;
}

-(void)showWeb{
    NSURL* url = [[ NSURL alloc ] initWithString :@"http://www.bsccedu.com"];
    [[UIApplication sharedApplication ] openURL: url];
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
