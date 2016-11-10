//
//  MusicViewController.m
//  chinese
//
//  Created by caopenpen on 16/8/6.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//

#import "MusicViewController.h"
#import "ZYLrcView.h"
#import <AVFoundation/AVFoundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "UIWebView+VideoControl.h"
#import "BradgeJdls.h"
#import "UIView+AutoLayout.h"
#import "UIView+Extension.h"

#import "AFHTTPSessionManager.h"
#define SUBWEB @"http://study1.yuwen100.cn?uid="
#define  MBASEURL @"https://study1.yuwen100.cn/articles"//添加我的
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
@interface MusicViewController ()<AVAudioPlayerDelegate,UIWebViewDelegate,BradgeJdlsDelegate>
/**
 *  显示播放进度条的定时器
 */
@property (strong, nonatomic) IBOutlet UIView *pressView;
@property (nonatomic, strong) NSTimer *timer;
/**
 *  显示歌词的定时器
 */
@property (nonatomic, strong) CADisplayLink *lrcTimer;

@property (nonatomic, strong) ZYLrcView *lrcView;//歌词视图，里面是两个lab
@property (nonatomic,weak) UIScrollView * backScrollView;//歌词滑动的ScrollView
@property (strong, nonatomic) IBOutlet UIWebView *left;
@property (strong, nonatomic) IBOutlet UIWebView *right;
@property (strong, nonatomic) IBOutlet UIView *rightView;
@property (strong, nonatomic) AVPlayer *player;
@property(strong,nonatomic)AVAudioPlayer *playerBackground;
@property (strong, nonatomic) NSString * strInfo;//内容
@property (strong, nonatomic) NSString *strVideoUrl;//音频url
@property (strong, nonatomic) NSString *strLrc;
@property (strong,nonatomic) NSString *articlId;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraintWith;
@property (strong, nonatomic) IBOutlet UIButton *playBtn;
@end

@implementation MusicViewController

{
    
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    self.player = nil;
    
    //清空歌词
    self.lrcView.fileName = @"";
    self.lrcView.currentTime = 0;
    [self removeCurrentTimer];
    [self removeLrcTimer];
    [_right stop];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.strTitle = @"经典诵读";
    _left.scalesPageToFit = YES;
    _left.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0.80 alpha:1];
    _right.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0.80 alpha:1];
    //左边默认地址
    
    NSString *loginId =  [[NSUserDefaults standardUserDefaults]  objectForKey:@"LoginId"];
    NSString *paths = [NSString stringWithFormat:@"%@%@",SUBWEB,loginId];
    NSURL *urls = [[NSURL alloc] initWithString:paths];
    [self.left loadRequest:[NSURLRequest requestWithURL:urls]];     // Do any additional setup after loading the view.
    

    self.left.delegate=self;
    JSContext *context=[self.left valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    BradgeJdls *testJO=[[BradgeJdls alloc] init];
    context[@"jdsd"]=testJO;
    testJO.delegate = self;
    
    
    
    //拿到歌词
   // self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupLrcView];
        //get the lyric string
    
    //从budle路径下读取音频文件　　轻音乐 - 萨克斯回家 这个文件名是你的歌曲名字,mp3是你的音频格式
    //[self createBackGoundMusic];
}
-(void)createBackGoundMusic{
    if (_playerBackground) {
        _playerBackground = nil;
    }
    NSString *budleStr = [NSString stringWithFormat:@"sd%d",arc4random()%3+1];
    NSString *string = [[NSBundle mainBundle] pathForResource:budleStr ofType:@"mp3"];
    //把音频文件转换成url格式
    NSURL *url = [NSURL fileURLWithPath:string];
    //初始化音频类 并且添加播放文件
    _playerBackground = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    //设置代理
    _playerBackground.delegate = self;
    
    //设置初始音量大小
    // avAudioPlayer.volume = 1;
    
    //设置音乐播放次数  -1为一直循环
    _playerBackground.numberOfLoops = -1;
    
    //预播放
    [_playerBackground prepareToPlay];
    [_playerBackground play];
    

}
-(void)webViewDidFinishLoad:(UIWebView *) webView
{
    //网页加载完成调用此方法
    if(webView ==self.left){
        //网页加载完成调用此方法
       
    }else{
        
    }
    
    
}


-(void)playitem:(NSString * )mp3url :(NSString *)lrcUrl :(NSString *)instroUrl :(NSString *)articlId :(NSString *)isAdd{
    self.player = nil;
    
    //清空歌词
    self.lrcView.fileName = @"";
    self.lrcView.currentTime = 0;
    [self removeCurrentTimer];
    [self removeLrcTimer];
    
    [self createPlayer:mp3url];
    [self getlrc:lrcUrl];
    _strInfo = instroUrl;
    _strVideoUrl = mp3url;
    _articlId = articlId;
    
    [_right loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_strInfo]]];
    [self createBackGoundMusic];
    
    
   

}

-(void)actionfav:(NSString *)isFav{
    self.player = nil;
    
    //清空歌词
    self.lrcView.fileName = @"";
    self.lrcView.currentTime = 0;
    [self removeCurrentTimer];
    [self removeLrcTimer];

    if ([isFav isEqualToString:@"1"]) {
        _addBtn.selected = YES;

    }else{
        _addBtn.selected = NO;

    }
}

#pragma mark ----setup系列方法

- (void)setupLrcView
{
    ZYLrcView *lrcView = [[ZYLrcView alloc] init];
    self.lrcView = lrcView;
    lrcView.hidden = NO;
    [self.rightView addSubview:lrcView];
    [lrcView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
   // lrcView.backgroundColor = [UIColor redColor];
   // [self.topView insertSubview:self.exitBtn aboveSubview:lrcView];
    //[self.topView insertSubview:self.lyricOrPhotoBtn aboveSubview:lrcView];
}



#pragma mark ----进度条定时器处理
/**
 *  添加定时器
 */
- (void)addCurrentTimer
{
    _constraintWith.constant = 0;
    //在新增定时器之前，先移除之前的定时器
    [self removeCurrentTimer];
    
    [self updateCurrentTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCurrentTimer) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/**
 *  移除定时器
 */
- (void)removeCurrentTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

/**
 *  触发定时器
 */
- (void)updateCurrentTimer
{
    if (self.player) {
        AVPlayerItem *playerItem=self.player.currentItem;
        double current=CMTimeGetSeconds(self.player.currentTime);
        
        double total=CMTimeGetSeconds([playerItem duration]);
        NSLog(@"%f---%f",current,total);
        if (isnan(total)) {
            return;
        }
        double temp = current / total;
        // [self.slider setTitle:[self stringWithTime:self.player.currentTime] forState:UIControlStateNormal];
        _constraintWith.constant = temp*self.right.width;
    }
    
}

#pragma mark ----歌词定时器

- (void)addLrcTimer
{
    if (self.lrcView.hidden == YES) return;
    
//    if (self.player.isPlaying == NO && self.lrcTimer) {
//        [self updateLrcTimer];
//        return;
//    }
    
    [self removeLrcTimer];
    
    [self updateLrcTimer];
    
    self.lrcTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLrcTimer)];
    [self.lrcTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)removeLrcTimer
{
    [self.lrcTimer invalidate];
    self.lrcTimer = nil;
}

- (void)updateLrcTimer
{
    float current=CMTimeGetSeconds(self.player.currentTime);

    self.lrcView.currentTime = current;
}
#pragma mark ----私有方法
/**
 *  将时间转化为合适的字符串
 *
 */
- (NSString *)stringWithTime:(NSTimeInterval)time
{
    int minute = time / 60;
    int second = (int)time % 60;
    return [NSString stringWithFormat:@"%02d:%02d",minute, second];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)createPlayer:(NSString *)strUrl{
//    self.player = nil;
//    
//    //清空歌词
//    self.lrcView.fileName = @"";
//    self.lrcView.currentTime = 0;
//    
//    [self removeCurrentTimer];
//    [self removeLrcTimer];
    
    NSURL * url  = [NSURL URLWithString:strUrl];
    AVPlayerItem * songItem = [[AVPlayerItem alloc]initWithURL:url];
    _player = [[AVPlayer alloc]initWithPlayerItem:songItem];
}
- (IBAction)playBtn:(UIButton *)sender {

    _right.hidden = YES;
    if (sender.selected) {
        sender.selected = NO;
        [_player pause];
//        self.player = nil;
//        
//        //清空歌词
//        self.lrcView.fileName = @"";
//        self.lrcView.currentTime = 0;
//        
//        [self removeCurrentTimer];
//        [self removeLrcTimer];
    }else{
        sender.selected = YES;
        [_player play];
        [self addLrcTimer];
        [self addCurrentTimer];
    }
 
    
}

- (IBAction)showInfo:(id)sender {
    
    _right.hidden  = NO;

    [_right loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_strInfo]]];

}
- (IBAction)refreshPlay:(id)sender {
    
    self.player = nil;
    
    //清空歌词
    self.lrcView.fileName = @"";
    self.lrcView.currentTime = 0;
    [self removeCurrentTimer];
    [self removeLrcTimer];
    self.lrcView.fileName = _strLrc;
    
    
    [self createPlayer:_strVideoUrl];
    [self addLrcTimer];
    [self addCurrentTimer];
    _playBtn.selected = YES;
    [_player play];

}

- (IBAction)upVoice:(UIButton *)sender {
    if (sender.selected) {
        sender.selected = NO;
        if (!_playerBackground.play) {
            [_playerBackground play];
        }
       
    }else{
        sender.selected = YES;
        if (_playerBackground.play) {
            [_playerBackground pause];
        }

    }
}
- (IBAction)offMusic:(id)sender {
    self.player = nil;
    
    //清空歌词
    self.lrcView.fileName = @"";
    self.lrcView.currentTime = 0;
    [self removeCurrentTimer];
    [self removeLrcTimer];
    self.lrcView.fileName = _strLrc;
    
    
    [self createPlayer:_strVideoUrl];
    _playBtn.selected = NO;
}
- (IBAction)addMine:(UIButton *)sender {
    NSString *iscall;
    if (sender.selected) {
        //sender.selected = NO;
        iscall = @"0";
    }else{
        //sender.selected = YES;
        iscall = @"1";
    }
    [self getData:iscall];
}
#pragma mark - get data
-(void)getlrc:(NSString *)urlPath{
    //    2.发送请求给服务器（带上账号和密码）
        //添加一个遮罩，禁止用户操作
    //   [MBProgressHUD showMessage:@"正在努力加载中...."];
  
   //
    //    1.设置请求路径
       NSURL *url=[NSURL URLWithString:urlPath];
   //    2.创建请求对象
      NSURLRequest *request=[NSURLRequest requestWithURL:url];

        //获取一个主队列
       NSOperationQueue *queue=[NSOperationQueue mainQueue];
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            //隐藏HUD，刷新UI的操作一定要放在主线程执行
            //  [MBProgressHUD hideHUD];
            
            　　NSString *aString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

            _lrcView.currentTime = 0;

            _lrcView.fileName = aString;
            _strLrc = aString;
            [self addLrcTimer];
            [self addCurrentTimer];
            _playBtn.selected = YES;
            [_player play];

           }];
        NSLog(@"请求发送完毕");

}


-(void)getData:(NSString *)isColl{
   
    NSString *loginId =  [[NSUserDefaults standardUserDefaults]  objectForKey:@"LoginId"];
    NSDictionary *dict=@{
                         @"method":@"setCollect",
                         @"IsColl":isColl,
                         @"Id":_articlId,
                         @"uid":loginId,
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
    //如果报接受类型不一致请替换一致text/html或别的
//
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];

    
    [manager POST:MBASEURL parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *msg = [responseObject objectForKey:@"msg"];
        [self showAlert:msg];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@,%ld",error.userInfo,error.code);
    }];
    

}

-(void)showAlert:(NSString *)str{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}
@end
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

