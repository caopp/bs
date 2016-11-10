//
//  BPHZSubViewController.m
//  chinese
//
//  Created by zuojianshijue on 16/1/16.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//

#import "BPHZSubViewController.h"
#import "DataModeOB.h"
#import "UIImageView+WebCache.h"
#import "paintView.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "szOB.h"
#define voiceurl @"http://www.yuwen100.cn/yuwen100/zy/zyzd-clips/pinyinread/"
#define avurl @"http://www.yuwen100.cn/yuwen100/zy/hanzi-flash/"
#define fonturl @"http://www.yuwen100.cn/yuwen100/zy/zyzd-clips/zxtu/"
#define xxurl   @"http://www.yuwen100.cn/yuwen100/zy/zyzd-clips/zytu/"

@interface BPHZSubViewController ()<AVAudioPlayerDelegate>
{
    NSArray *arrData;
    NSArray *arrPY;
    //int numbId;//序号
    int totolcount;
    int  arrIndex;//
    int  pyplay;
     UIView *viewWrite;
}
@property (nonatomic,strong) AVPlayer *audioPlayer;//播放器
@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;//视频播放控制器
@end

@implementation BPHZSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.strTitle = @"爆破汉字";
    
    //添加通知
    [self addNotification];
    arrIndex = 0;
    szOB *sz = [_arrNumb objectAtIndex:arrIndex];
    if (_numbId) {
        _redbtn.hidden = YES;
        _greenbtn.hidden = YES;
        _numbBtn.hidden = YES;
        
    }else{
        _numbId = (_arrNumb.count)?[sz.bh intValue]:(int)(120000 + _modeFirst*50 +_firstCount +1);
    }
    totolcount =_arrNumb.count?_arrNumb.count:50;

    // Do any additional setup after loading the view.
    _fontImgV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _fontImgV.layer.borderWidth = 1.0f;
    _fontImgV.layer.masksToBounds = YES;
    _xxImgV.layer.borderWidth = 1.0f;
    _xxImgV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _xxImgV.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playVoice)];
    _laba.userInteractionEnabled = YES;
    [_laba addGestureRecognizer:tapGesture];
    _bhTextV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _bhTextV.layer.borderWidth = 1.0f;
    
    _bhTextV.font = [UIFont systemFontOfSize:10];
    _bhTextV.layer.masksToBounds = YES;
    _bhTextV.editable = NO;
    
    _contentTextV.font = [UIFont systemFontOfSize:10];
  
    _contentTextV.layer.borderColor = [UIColor colorWithRed:0.66 green:0.52 blue:0.35 alpha:1].CGColor;
    _contentTextV.layer.borderWidth = 4.0f;
    _contentTextV.layer.masksToBounds = YES;
    
    _contentTextV.editable = NO;
    
    
    viewWrite =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:viewWrite];
    viewWrite.hidden = YES;
    viewWrite .backgroundColor = [UIColor clearColor];
    
    

    [self getData];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
}
-(void)setContentTextViewLine:(UITextView *) mTextView textContent:(NSString *) mContent{
//    mContent = [@"\n" stringByAppendingString:mContent];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    paragraphStyle.headIndent = 20;
    paragraphStyle.firstLineHeadIndent = 10;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:10],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
     mTextView.attributedText = [[NSAttributedString alloc] initWithString:mContent attributes:attributes];
}
-(void)getData{
    [self defaultButton];
    UIButton *btn = (UIButton *)[self.view viewWithTag:1];
    btn.selected = YES;
    DataModeOB *modeOB = [[DataModeOB alloc] init];
    arrData = [modeOB queryWithRefid:[NSString stringWithFormat:@"%d",_numbId] withTableName:@"zidian"];
    arrPY = [modeOB queryWithPYRefid:[NSString stringWithFormat:@"%d",_numbId] withTableName:@"pinyin"];
    [self reloadView];
}
-(void)reloadView{
    zidianOB *zidian = [arrData objectAtIndex:0];
    _fontLabel.text = zidian.zitou;
    _pyLabel.text = zidian.pinyin;
    _bhTextV.text = zidian.shiyi;
    UIButton *btn = [self.view viewWithTag:1];
    [self changeButton:btn];
   // _contentTextV.text = zidian.yanbian; //zidian.cy;zidian.cysy;
    [_numbBtn setTitle:[NSString stringWithFormat:@"%d",totolcount] forState:UIControlStateNormal];
    
    
    NSURL *urlFont = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@.jpg",fonturl,zidian.refid]];
    [_xxImgV sd_setImageWithURL:urlFont];
    NSURL *urlxx = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@.jpg",xxurl,zidian.refid]];
    [_fontImgV sd_setImageWithURL:urlxx];
    self.moviePlayer.contentURL = [self getNetworkUrl];
    self.moviePlayer.shouldAutoplay= YES;
    [self.moviePlayer play];
    
}
-(void)playVoice{
    
    
    if (!arrPY.count) {
        return;
    }
    pinyinOB *pinyin = [arrPY objectAtIndex:0];
    NSString *srtVoice =[NSString stringWithFormat:@"%@%@.mp3",voiceurl,pinyin.pyj];
   NSURL * srtVoiceUrl =[NSURL URLWithString:srtVoice];
    //初始化音频类 并且添加播放文件
     _audioPlayer = [[AVPlayer alloc] initWithPlayerItem:[[AVPlayerItem alloc] initWithURL:srtVoiceUrl]];
    //设置代理
    
    //设置初始音量大小
    // avAudioPlayer.volume = 1;
    
    [_audioPlayer play];
    
}
- (IBAction)rePlayVideo:(id)sender {
    [self.moviePlayer play];
}
//已经学会的
- (IBAction)pass:(id)sender {
      DataModeOB *modeOB = [[DataModeOB alloc] init];
        NSString *numbIdStr = [NSString stringWithFormat:@"%d",_numbId];
      NSArray *arr =[modeOB querywithSZWithrefid:numbIdStr];
    if (arr&&arr.count) {
        BOOL bo = [modeOB updateHZWithRefid:numbIdStr withShenzi:@"1" withtableName:@"sz"];
        NSLog(@"bo===%d",bo);
    }else{
        BOOL bo = [modeOB insertHZWithRefid:numbIdStr withShenzi:@"1" withtableName:@"sz"];
        NSLog(@"bo===%d",bo);
    }
  
    if (_arrNumb.count) {
        arrIndex ++ ;
        totolcount--;
        if (arrIndex <_arrNumb.count) {
            szOB *sz = [_arrNumb objectAtIndex:arrIndex];
            _numbId  = [sz.bh intValue];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"本组已无汉字" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return;
        }
        
    }else{
        _numbId ++;
        totolcount--;
        if (_numbId >= 120000 + _modeFirst*50 +_firstCount +1 +50||totolcount<=0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"本组已无汉字" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return;
        }
    }
   
    [self getData];
  
   
}
// 没有学会 
- (IBAction)save:(id)sender {
    DataModeOB *modeOB = [[DataModeOB alloc] init];
    NSString *numbIdStr = [NSString stringWithFormat:@"%d",_numbId];
    NSArray *arr =[modeOB querywithSZWithrefid:numbIdStr];
    if (arr&&arr.count) {
        BOOL bo = [modeOB updateHZWithRefid:numbIdStr withShenzi:@"0" withtableName:@"sz"];
        NSLog(@"bo===%d",bo);
    }else{
        BOOL bo = [modeOB insertHZWithRefid:numbIdStr withShenzi:@"0" withtableName:@"sz"];
        NSLog(@"bo===%d",bo);
    }
    if (_arrNumb.count) {
        arrIndex ++ ;
        totolcount--;
        if (arrIndex <_arrNumb.count) {
            szOB *sz = [_arrNumb objectAtIndex:arrIndex];
            _numbId  = [sz.bh intValue];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"本组已无汉字" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return;
        }
        
    }else{
        _numbId ++;
        totolcount--;
        if (_numbId >= 120000 + _modeFirst*50 +_firstCount +1 +50||totolcount<=0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"本组已无汉字" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return;
        }
    }
    [self getData];
}

-(IBAction)showPaintView:(id)sender {
    paintView  *pinV = [[[NSBundle mainBundle] loadNibNamed:@"paint" owner:self options:nil] objectAtIndex:0];
    pinV.frame = CGRectMake(0, 0, 300, 300);
    pinV.center =self.view.center;
    viewWrite.hidden = NO;
    [viewWrite addSubview:pinV];
}

-(MPMoviePlayerController *)moviePlayer{
    if (!_moviePlayer) {
        NSURL *url=[self getNetworkUrl];
        _moviePlayer=[[MPMoviePlayerController alloc]initWithContentURL:url];
        _moviePlayer.view.frame=_bhImgV.bounds;
        _moviePlayer.backgroundView.backgroundColor = [UIColor whiteColor];
        _moviePlayer.view.backgroundColor = [UIColor whiteColor];
        _moviePlayer.shouldAutoplay=YES;
        
        _moviePlayer.controlStyle = MPMovieControlStyleNone;
       // _moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [_bhImgV addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}
/**
 *  取得网络文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getNetworkUrl{
    NSString *urlStr= [NSString stringWithFormat:@"%@%d.mp4",avurl,_numbId];
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    return url;
}

- (IBAction)changeButton:(UIButton *)sender {
    [self defaultButton];
     zidianOB *zidian = [arrData objectAtIndex:0];
    switch (sender.tag) {
        case 1:
            
            [self setContentTextViewLine:_contentTextV textContent:zidian.yanbian];

            break;
            
            
        case 2:
            [self setContentTextViewLine:_contentTextV textContent:zidian.cysy];
            
            break;
        case 3:
            
             [self setContentTextViewLine:_contentTextV textContent:zidian.cy];
            
            break;
        default:
            break;
    }
    sender.selected = YES;
}

-(void)defaultButton{
    for (int i=1; i <4; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:i];
        btn.selected = NO;
    }
}


/**
 *  添加通知监控媒体播放控制器状态
 */
-(void)addNotification{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayer];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    
}

/**
 *  播放状态改变，注意播放完成时的状态是暂停
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    switch (self.moviePlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%li",self.moviePlayer.playbackState);
            break;
    }
}
/**
 *  播放完成
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    NSLog(@"播放完成.%li",self.moviePlayer.playbackState);
}


- (void)playEnd{

    pyplay++;
    if (!(arrPY.count > pyplay)) {
        pyplay = 0;
        return;
    }
    pinyinOB *pinyin = [arrPY objectAtIndex:pyplay];
    NSString *srtVoice =[NSString stringWithFormat:@"%@%@.mp3",voiceurl,pinyin.pyj];
    NSURL * srtVoiceUrl =[NSURL URLWithString:srtVoice];
    //初始化音频类 并且添加播放文件
    _audioPlayer = [[AVPlayer alloc] initWithPlayerItem:[[AVPlayerItem alloc] initWithURL:srtVoiceUrl]];
    //设置代理
    
    //设置初始音量大小
     _audioPlayer.volume = 1;
    
    [_audioPlayer play];
    
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
