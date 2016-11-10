//
//  BPCYHViewController.m
//  chinese
//
//  Created by zuojianshijue on 15/12/8.
//  Copyright © 2015年 zhujohnle. All rights reserved.
//

#import "BPCYHViewController.h"
#import "BPHZCollectionViewCell.h"
#import "BPCYSubViewController.h"
#import "DataModeOB.h"
@interface BPCYHViewController ()<BPDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation BPCYHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.strTitle = @"爆破成语";
    // Do any additional setup after loading the view.
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
    
     return _totalCount/_modeCount + 2;

}

- (BPHZCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    BPHZCollectionViewCell *cell;
    if (indexPath.row == _totalCount/_modeCount ) {
        static NSString * const reuseIdentifier = @"BPCYAlertCollectionViewCell";
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bpcy_lev_remotebg"]];
    }
    else if(indexPath.row == _totalCount/_modeCount +1){
        static NSString * const reuseIdentifier = @"BPCYModeCollectionViewCell";

        cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.totolCount.text = [NSString stringWithFormat:@"%d",_totalCount];
        NSString *first = [NSString stringWithFormat:@"%d",1+_firstCount];
        NSString *second = [NSString stringWithFormat:@"%d",_totalCount+_firstCount];
        NSString *countRed = [self showNumb:first withBettwen:second withSz:@"0"];
        [cell.redButton setTitle:countRed forState:UIControlStateNormal];
        
        NSString *countgreen = [self showNumb:first withBettwen:second withSz:@"1"];
        [cell.greenButton setTitle:countgreen forState:UIControlStateNormal];
        //cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bphz_item_statistic_bg"]];
    }else{
        static NSString * const reuseIdentifier = @"BPCYCollectionViewCell";
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bpcy_lev_itembg"]];
        // Configure the cell
        NSString *first = [NSString stringWithFormat:@"%d",indexPath.row *_modeCount+_firstCount + 1];
        NSString *second = [NSString stringWithFormat:@"%d",indexPath.row *_modeCount+_firstCount + _modeCount];
        [cell loadFirstCount:first withSecond:second];
        
        NSString *countRed = [self showNumb:first withBettwen:second withSz:@"0"];
        [cell.redButton setTitle:countRed forState:UIControlStateNormal];
        
        NSString *countgreen = [self showNumb:first withBettwen:second withSz:@"1"];
        [cell.greenButton setTitle:countgreen forState:UIControlStateNormal];
        cell.delegate = self;
        cell.tag = indexPath.row;
    }
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= _totalCount/_modeCount ) {
        return;
    }
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    BPCYHViewController *bphzVC = [storyboard instantiateViewControllerWithIdentifier:@"BPCYHViewController"];
//    [self presentViewController:bphzVC animated:YES completion:^{}];
    if (_modeCount==1000) {
        BPCYHViewController *bpcyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BPCYHViewController"];
        //         BPHZHViewController *bpcyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BPHZHViewController"];
        bpcyVC.totalCount = _modeCount;
        bpcyVC.modeCount = _modeCount/10;
        bpcyVC.firstCount = indexPath.row *_modeCount;
        [self presentViewController:bpcyVC animated:YES completion:nil];
    }else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        BPCYSubViewController*bphzSubVC = [storyboard instantiateViewControllerWithIdentifier:@"BPCYSubViewController"];
        bphzSubVC.modeFirst = indexPath.row;
        bphzSubVC.firstCount = _firstCount;
        [self presentViewController:bphzSubVC animated:YES completion:^{}];
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
    return _modeCount==1000?5:30;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.001f;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //    CGFloat height = 260.0f;
    CGFloat width =(CGRectGetWidth(collectionView.frame)-80)/4
    ;
    CGFloat height =(CGRectGetHeight(collectionView.frame)-24)/4;
    
    return CGSizeMake(width, height);
    
    
}
-(void)showMore:(NSInteger)btn{
    if (_modeCount==1000) {
        BPCYHViewController *bpcyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BPCYHViewController"];
        //         BPHZHViewController *bpcyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BPHZHViewController"];
        bpcyVC.totalCount = _modeCount;
        bpcyVC.modeCount = _modeCount/10;
        bpcyVC.firstCount = btn *_modeCount;
        [self presentViewController:bpcyVC animated:YES completion:nil];
    }else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        BPCYSubViewController*bphzSubVC = [storyboard instantiateViewControllerWithIdentifier:@"BPCYSubViewController"];
        bphzSubVC.modeFirst = btn;
        bphzSubVC.firstCount = _firstCount;
        [self presentViewController:bphzSubVC animated:YES completion:^{}];
    }
}

-(void)showRed:(NSInteger)btn{
    
    DataModeOB *modeOB = [[DataModeOB alloc] init];
    NSArray *arr =[modeOB querywithSZWithShengzi:@"0" withMode:220000 +_firstCount + btn*500 +1 withCount:500];
    if (arr.count) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        BPCYSubViewController *bphzSubVC = [storyboard instantiateViewControllerWithIdentifier:@"BPCYSubViewController"];
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
    NSArray *arr =[modeOB querywithSZWithShengzi:@"1" withMode:220000 + _firstCount + btn*500 +1 withCount:500];
    if (arr.count) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        BPCYSubViewController *bphzSubVC = [storyboard instantiateViewControllerWithIdentifier:@"BPCYSubViewController"];
        bphzSubVC.modeFirst = btn;
        bphzSubVC.arrNumb = arr;
        [self presentViewController:bphzSubVC animated:YES completion:^{}];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"本组无学习记录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
}
-(NSString *)showNumb:(NSString *)first withBettwen:(NSString *)bettwen withSz:(NSString *)sz{
    
    first = [NSString stringWithFormat:@"%d",[first intValue]+220000];
    bettwen = [NSString stringWithFormat:@"%d",[bettwen intValue]+220000];
    DataModeOB *modeOB = [[DataModeOB alloc] init];
    int count = [modeOB getIntwithSz:sz withFirst:first withSecond:bettwen];
    return [NSString stringWithFormat:@"%d",count];
    // arrData = [modeOB queryWithRefid:[NSString stringWithFormat:@"%d",_numbId] withTableName:@"zidian"];
    
    return nil;
}
- (IBAction)clearCode:(id)sender {
    
    NSString * first = [NSString stringWithFormat:@"%d",_firstCount+220000];
    NSString * bettwen = [NSString stringWithFormat:@"%d",_totalCount+_firstCount+220000];
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
