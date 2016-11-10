//
//  ZYYXHViewController.m
//  chinese
//
//  Created by zuojianshijue on 15/12/8.
//  Copyright © 2015年 zhujohnle. All rights reserved.
//

#import "ZYYXHViewController.h"
#import "DataModeOB.h"
#import <AudioToolbox/AudioToolbox.h>
static SystemSoundID shake_sound_good_id = 0;
static SystemSoundID shake_sound_bad_id = 1;
@interface ZYYXHViewController (){
    NSIndexPath *indexFirst;
    int  mode;//关卡
    NSArray *arrData;
    int  arrCount;//标记
}
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ZYYXHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    [ud setObject:string forKey:@"myKey"];
    mode = [[ud objectForKey:@"myKey"] intValue];
    self.strTitle = @"字源游戏";
   // mode = 0;
    self.collectionView.layer.cornerRadius = 8;
    self.collectionView.layer.masksToBounds = YES;
    self.collectionView.layer.borderColor = [UIColor orangeColor].CGColor;
    self.collectionView.layer.borderWidth = 5.0f;
    self.collectionView.backgroundColor = [UIColor orangeColor];
    [self addnumb];
    [self getData:mode];

    // Do any additional setup after loading the view.
}
-(void)addnumb{
    for (int i = 0; i < 9; i++) {
        UIButton *btnYX = [[UIButton alloc] initWithFrame:CGRectMake(15 + i*35, 70, 30, 30)];
        if (i <=mode ) {
            btnYX.alpha = 0.5;
        }else{
            btnYX.alpha = 1;
        }
        btnYX.layer.cornerRadius = 15.0f;
        btnYX.layer.masksToBounds = YES;
        btnYX.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btnYX.layer.borderWidth = 1.0f;
        btnYX.tag = 1000+i;
        [btnYX setBackgroundImage:[UIImage imageNamed:@"zy_category_background"] forState:UIControlStateNormal];
        [btnYX setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        [btnYX addTarget:self action:@selector(nextView:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnYX];
    }
}
-(void)nextView:(UIButton *)btn{
    if (btn.tag <=(mode+1000)) {
        
        [self getData:(btn.tag - 1000)];
      
    }else{
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"需要先通过前面关卡" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    
}
-(void)getData:(int)modetap{
    indexFirst = nil;
    DataModeOB *modeOB = [[DataModeOB alloc] init];
    arrData = [modeOB queryWithStep:[NSString stringWithFormat:@"%d",modetap] withTableName:@"game"];
    arrCount =(int) arrData.count;
    [_collectionView reloadData];
}



#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return arrData.count;
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const reuseIdentifier = @"JBYXCollectionViewCell";
    gameOB *game =[arrData objectAtIndex:indexPath.row];
    NSArray *arr = [game.icon_path  componentsSeparatedByString:@"/"];
    NSString *imgName = [arr lastObject];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
    // Configure the cell
    cell.alpha = game.isHidden?0:1;
    cell.userInteractionEnabled = game.isHidden?NO:YES;
    
    return cell;
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    gameOB *game =[arrData objectAtIndex:indexPath.row];
    if (indexFirst&&indexFirst!=indexPath) {
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        UICollectionViewCell *cellF = [collectionView cellForItemAtIndexPath:indexFirst];
        gameOB *gameFirst = [arrData objectAtIndex:indexFirst.row];
        if (game.type == gameFirst.type) {
            cell.alpha = 0;// [UIColor clearColor];
            cellF.alpha = 0;//[UIColor clearColor];
            game.isHidden = YES;
            gameFirst.isHidden = YES;
            
            cell.userInteractionEnabled = NO;
            cell.userInteractionEnabled = NO;
            arrCount -=2;
            if (arrCount==0) {
                mode += 1;
                UIButton *btn =(UIButton *)[self.view viewWithTag:mode+1000];
                btn.alpha = 0.5;
                UIButton *btnP =(UIButton *)[self.view viewWithTag:mode+1000-1];
                btnP.alpha = 0.5;
               
                NSString *modeStr = [NSString stringWithFormat:@"%d",mode];
                if (mode >[modeStr intValue]) {
                    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                    [ud setObject:modeStr forKey:@"myKey"];
                }
               
                [self getData:mode];
                
            }
            [self plavySound:YES];
        }else{
            cell.alpha = 1;// [UIColor clearColor];
            cellF.alpha = 1;//[UIColor clearColor];
            game.isHidden = NO;
            gameFirst.isHidden = NO;
            cell.userInteractionEnabled = YES;
            cell.userInteractionEnabled = YES;
            [self plavySound:NO];
        }
        indexFirst = nil;
    }else{
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        cell.alpha = 0.5;
        indexFirst = indexPath;
    }

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //    CGFloat height = 260.0f;
    CGFloat width = (CGRectGetWidth(collectionView.frame) - 80) /8 ;
    CGFloat height =(CGRectGetHeight(collectionView.frame)-40)/4;
    
    return CGSizeMake(width, height);
    
    
}

-(void)plavySound:(BOOL)good{
    NSString *path = [[NSBundle mainBundle] pathForResource:(good?@"good":@"bad" ) ofType:@"wav"];
    if (path) {
        //注册声音到系统
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],good?&shake_sound_good_id:&shake_sound_bad_id);
        AudioServicesPlaySystemSound((good?shake_sound_good_id:shake_sound_bad_id));
        //        AudioServicesPlaySystemSound(shake_sound_male_id);//如果无法再下面播放，可以尝试在此播放
    }
    
   // AudioServicesPlaySystemSound((good?shake_sound_good_id:shake_sound_bad_id));   //播放注册的声音，（此句代码，可以在本类中的任意位置调用，不限于本方法中）
    
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
