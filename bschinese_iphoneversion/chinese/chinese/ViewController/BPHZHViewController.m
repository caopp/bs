//
//  BPHZHViewController.m
//  chinese
//
//  Created by zuojianshijue on 15/12/8.
//  Copyright © 2015年 zhujohnle. All rights reserved.
//

#import "BPHZHViewController.h"
#import "BPHZCollectionViewCell.h"
#import "BPHZSubViewController.h"
#import "DataModeOB.h"
#define HZCOUNT  7000
#define MODECOUNT 500
@interface BPHZHViewController ()<BPDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation BPHZHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!_totalCount) {
        _totalCount = HZCOUNT;
    }
    if (!_modeCount) {
        _modeCount = MODECOUNT;
    }
    if (!_firstCount) {
        _firstCount = 0;
    }
    self.strTitle = @"爆破汉字";
    UIImage *img = [UIImage imageNamed:@"bg_main_activity.9"];
    img = [img stretchableImageWithLeftCapWidth:2 topCapHeight:2];
    _bphzImg.image = img;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.collectionView reloadData];
}

#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return (_modeCount==50)?_totalCount/_modeCount + 1:_totalCount/_modeCount + 2;
    
    
}

- (BPHZCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BPHZCollectionViewCell *cell;
    if (indexPath.row == _totalCount/_modeCount ) {
        static NSString * const reuseIdentifier = @"BPHZAlertCollectionViewCell";
         cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
          cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bpcy_lev_remotebg"]];
    }
    else if(indexPath.row == _totalCount/_modeCount +1){
        static NSString * const reuseIdentifier = @"BPHZModeCollectionViewCell";
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.totolCount.text = [NSString stringWithFormat:@"%d",_totalCount];
        NSString *first = [NSString stringWithFormat:@"%d",1+_firstCount];
        NSString *second = [NSString stringWithFormat:@"%d",_totalCount+_firstCount];
        NSString *countRed = [self showNumb:first withBettwen:second withSz:@"0"];
        [cell.redButton setTitle:countRed forState:UIControlStateNormal];
        
        NSString *countgreen = [self showNumb:first withBettwen:second withSz:@"1"];
        [cell.greenButton setTitle:countgreen forState:UIControlStateNormal];
        // cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bphz_item_statistic_bg"]];
    }else{
        static NSString * const reuseIdentifier = @"BPHZCollectionViewCell";
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        cell.tag = indexPath.row;
        // Configure the cell
        NSString *first = [NSString stringWithFormat:@"%d",indexPath.row *_modeCount+1+_firstCount];
        NSString *second = [NSString stringWithFormat:@"%d",indexPath.row *_modeCount+_modeCount+_firstCount];
        [cell loadFirstCount:first withSecond:second];
        NSString *countRed = [self showNumb:first withBettwen:second withSz:@"0"];
        [cell.redButton setTitle:countRed forState:UIControlStateNormal];
        
        NSString *countgreen = [self showNumb:first withBettwen:second withSz:@"1"];
        [cell.greenButton setTitle:countgreen forState:UIControlStateNormal];
        
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bphz_levitem_bg"]];
    }
    

    return cell;
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= _totalCount/_modeCount ) {
        return;
    }
    if (_modeCount==50) {
        if (indexPath.row <_totalCount/_modeCount) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            BPHZSubViewController *bphzSubVC = [storyboard instantiateViewControllerWithIdentifier:@"BPHZSubViewController"];
            bphzSubVC.modeFirst = indexPath.row;
            bphzSubVC.firstCount = _firstCount;
            [self presentViewController:bphzSubVC animated:YES completion:^{}];
        }
    }else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        BPHZHViewController *bphzVC = [storyboard instantiateViewControllerWithIdentifier:@"BPHZHViewController"];
        bphzVC.totalCount = _modeCount;
        bphzVC.modeCount = _modeCount/10;
        bphzVC.firstCount = indexPath.row *_modeCount;
        [self presentViewController:bphzVC animated:YES completion:^{}];
      

    }
   
   
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 10, 5, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return _modeCount==50?30:10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.001f;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //    CGFloat height = 260.0f;
    CGFloat width =(CGRectGetWidth(collectionView.frame)-80)/4
    ;
    CGFloat height =(CGRectGetHeight(collectionView.frame)-80)/4;
    
    return CGSizeMake(width, height);
    
    
}
-(void)showMore:(NSInteger)btn{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    BPHZSubViewController *bphzSubVC = [storyboard instantiateViewControllerWithIdentifier:@"BPHZSubViewController"];
//    bphzSubVC.modeFirst = btn;
//    [self presentViewController:bphzSubVC animated:YES completion:^{}];
    if (_modeCount==50) {
        if (btn <_totalCount/_modeCount) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            BPHZSubViewController *bphzSubVC = [storyboard instantiateViewControllerWithIdentifier:@"BPHZSubViewController"];
            bphzSubVC.modeFirst = btn;
            bphzSubVC.firstCount = _firstCount;
            [self presentViewController:bphzSubVC animated:YES completion:^{}];
        }
    }else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        BPHZHViewController *bphzVC = [storyboard instantiateViewControllerWithIdentifier:@"BPHZHViewController"];
        bphzVC.totalCount = _modeCount;
        bphzVC.modeCount = _modeCount/10;
        bphzVC.firstCount = btn *_modeCount;
        [self presentViewController:bphzVC animated:YES completion:^{}];
        
        
    }
}

-(void)showRed:(NSInteger)btn{
    
    DataModeOB *modeOB = [[DataModeOB alloc] init];
    NSArray *arr =[modeOB querywithSZWithShengzi:@"0" withMode:120000 +_firstCount +btn*_modeCount +1 withCount:_modeCount];
    if (arr.count) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        BPHZSubViewController *bphzSubVC = [storyboard instantiateViewControllerWithIdentifier:@"BPHZSubViewController"];
        bphzSubVC.modeFirst = btn;
        bphzSubVC.arrNumb = arr;
        [self presentViewController:bphzSubVC animated:YES completion:^{}];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"本组无学习记录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    
}
-(void)showGreen:(NSInteger)btn{
    DataModeOB *modeOB = [[DataModeOB alloc] init];
    NSArray *arr =[modeOB querywithSZWithShengzi:@"1" withMode:120000 +_firstCount + btn*_modeCount +1 withCount:_modeCount];
    if (arr.count) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        BPHZSubViewController *bphzSubVC = [storyboard instantiateViewControllerWithIdentifier:@"BPHZSubViewController"];
        bphzSubVC.modeFirst = btn;
        bphzSubVC.arrNumb = arr;
        [self presentViewController:bphzSubVC animated:YES completion:^{}];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"本组无学习记录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
}
-(NSString *)showNumb:(NSString *)first withBettwen:(NSString *)bettwen withSz:(NSString *)sz{
    first = [NSString stringWithFormat:@"%d",[first intValue]+120000];
    bettwen = [NSString stringWithFormat:@"%d",[bettwen intValue]+120000];
    DataModeOB *modeOB = [[DataModeOB alloc] init];
    int count = [modeOB getIntwithSz:sz withFirst:first withSecond:bettwen];
    return [NSString stringWithFormat:@"%d",count];
   // arrData = [modeOB queryWithRefid:[NSString stringWithFormat:@"%d",_numbId] withTableName:@"zidian"];

    return nil;
}
- (IBAction)clearCode:(id)sender {
   NSString * first = [NSString stringWithFormat:@"%d",_firstCount+120000];
   NSString * bettwen = [NSString stringWithFormat:@"%d",_totalCount+_firstCount+120000];
    DataModeOB *modeOB = [[DataModeOB alloc] init];
    BOOL bo = [modeOB clearSz:@"" withFirst:first withSecond:bettwen];
    if (bo) {
        [self.collectionView reloadData];
    }
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
