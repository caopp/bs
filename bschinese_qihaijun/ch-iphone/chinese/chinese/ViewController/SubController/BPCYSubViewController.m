//
//  BPCYSubViewController.m
//  chinese
//
//  Created by zuojianshijue on 16/1/16.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//

#import "BPCYSubViewController.h"
#import "DataModeOB.h"
#import "UIImageView+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "paintView.h"
#include <CommonCrypto/CommonCryptor.h>
#define cyvideourl @"http://www.yuwen100.cn/yuwen100/hzzy/zyzd-clips/cyflv/"
#define cyimg  @"http://www.yuwen100.cn/yuwen100/hzzy/zyzd-clips/cytu/"
#define cymp3  @"http://www.yuwen100.cn/yuwen100/hzzy/zyzd-clips/cyread/"
@interface BPCYSubViewController ()
{
    NSArray *arrData;
    int numbId;
    NSURL *strVideoUrl;
    NSURL *strVoiceUrl;
    
    UIView *viewWrite;
    int  arrIndex;//
    int totolCount;
}
@property(nonatomic,strong)AVPlayer* audioPlayer ;
@end

@implementation BPCYSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.strTitle = @"爆破成语";
    arrIndex = 0;
    totolCount = _arrNumb.count?_arrNumb.count:100;
    szOB *sz = [_arrNumb objectAtIndex:arrIndex];
    numbId = (_arrNumb.count)?[sz.bh intValue]:(int)(220000 + _modeFirst*100 +_firstCount +1);
   // numbId = (int)(220000+_modeFirst*500+1);
    
    [self getData];
    _cydhImgV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _cydhImgV.layer.borderWidth = 1.0f;
    _cydhImgV.layer.masksToBounds = YES;
    _cysyText.layer.borderWidth = 1.0f;
    _cysyText.font = [UIFont systemFontOfSize:12];
    _cysyText.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _cysyText.layer.masksToBounds = YES;
    _cysyText.editable =  NO;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playVoice)];
    _bpVoice.userInteractionEnabled = YES;
    [_bpVoice addGestureRecognizer:tapGesture];
    // Do any additional setup after loading the view.
    
    viewWrite =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:viewWrite];
    viewWrite.hidden = YES;
    viewWrite .backgroundColor = [UIColor clearColor];
}
-(void)getData{
    DataModeOB *modeOB = [[DataModeOB alloc] init];
    arrData = [modeOB queryWithcybh:[NSString stringWithFormat:@"%d",numbId] withTableName:@"chengyu"];
    [self reloadView];
}
/*
 @property(nonatomic,strong)NSString *CYCimu;//
 @property(nonatomic,strong)NSString *CYFayin;//
 @property(nonatomic,strong)NSString *CYShiyi;
 @property(nonatomic,strong)NSString *CYChuchu;//
 @property(nonatomic,strong)NSString *CYShili;
 @property(nonatomic,strong)NSString *CYJinyi;//
 @property(nonatomic,strong)NSString *CYFanyi;//
 */
-(void)reloadView{
    
    if (!arrData.count) {
        return;
    }
    chengyuOB *chenyu = [arrData objectAtIndex:0];
    _fontLabel.text = chenyu.CYCimu;
    _pyLabel.text = chenyu.CYFayin;
    NSString  *strText =[NSString stringWithFormat:@"[成语释义]%@\n\n[成语出处]%@\n\n[成语示例]%@\n\n[近义词]%@\n\n[反义词]%@\n\n",chenyu.CYShiyi,chenyu.CYChuchu,chenyu.CYShili,chenyu.CYJinyi?chenyu.CYJinyi:@"",chenyu.CYFanyi?chenyu.CYFanyi:@""];
    _cysyText.text = strText;//chenyu.CYShili;
    
    NSURL *urlFont = [NSURL URLWithString:[NSString stringWithFormat:@"%@%d.jpg",cyimg,chenyu.cybh]];
    [_cydhImgV sd_setImageWithURL:urlFont];
    
    strVideoUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%d.MP4",cyvideourl,chenyu.cybh]];
    strVoiceUrl =  [NSURL URLWithString:[NSString stringWithFormat:@"%@%d.mp3",cymp3,chenyu.cybh]];
    
    [_numbButton setTitle:[NSString stringWithFormat:@"%d",totolCount] forState:UIControlStateNormal];
    [self performSelector:@selector(reloadTextView) withObject:nil afterDelay:0.1];

}
-(void)reloadTextView{
    _cysyText.contentOffset = CGPointMake(0, 0);
}
//NSURL * movieurl = [NSURL URLWithString:@"http://v.youku.com/player/getRealM3U8/vid/XNDUwNjc4MzA4/type/video.m3u8"];
//
//MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc] initWithContentURL:movieurl];
//
//[self presentMoviePlayerViewControllerAnimated:player];
- (IBAction)showWriteView:(id)sender {
    paintView  *pinV = [[[NSBundle mainBundle] loadNibNamed:@"paint" owner:self options:nil] objectAtIndex:0];
    pinV.frame = CGRectMake(0, 0, 300, 300);
    pinV.center =self.view.center;
    viewWrite.hidden = NO;
    [viewWrite addSubview:pinV];
}

- (IBAction)playVideo:(id)sender {
//    NSURL * movieurl = [NSURL URLWithString:@"http://v.youku.com/player/getRealM3U8/vid/XNDUwNjc4MzA4/type/video.m3u8"];
    
    MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc] initWithContentURL:strVideoUrl];
    
    [self presentMoviePlayerViewControllerAnimated:player];
    

}
-(void)playVoice{
    
    
    //初始化音频类 并且添加播放文件
    _audioPlayer = [[AVPlayer alloc] initWithPlayerItem:[[AVPlayerItem alloc] initWithURL:strVoiceUrl]];
    //设置代理
    // _audioPlayer.delegate = self;
    
    //设置初始音量大小
     _audioPlayer.volume = 1;
    
    [_audioPlayer play];
    
}
- (IBAction)pass:(id)sender {
    DataModeOB *modeOB = [[DataModeOB alloc] init];
    NSString *numbIdStr = [NSString stringWithFormat:@"%d",numbId];
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
        totolCount --;
        if (arrIndex <_arrNumb.count) {
            szOB *sz = [_arrNumb objectAtIndex:arrIndex];
            numbId  = [sz.bh intValue];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"本组已无成语" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return;
        }
        
    }else{
        numbId ++;
        totolCount --;
        if (numbId >= 220000 + _modeFirst*100 +_firstCount +1 +100||totolCount <=0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"本组已无成语" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return;
        }
    }
    
    [self getData];
}
- (IBAction)save:(id)sender {
    DataModeOB *modeOB = [[DataModeOB alloc] init];
    NSString *numbIdStr = [NSString stringWithFormat:@"%d",numbId];
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
        totolCount --;
        if (arrIndex <_arrNumb.count) {
            szOB *sz = [_arrNumb objectAtIndex:arrIndex];
            numbId  = [sz.bh intValue];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"本组已无成语" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return;
        }
        
    }else{
        numbId ++;
        totolCount --;
        if (numbId >= 220000 + _modeFirst*100 +_firstCount +1 +100||totolCount<=0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"本组已无成语" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return;
        }
    }
    [self getData];
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
