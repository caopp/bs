//
//  JBZYSubViewController.m
//  chinese
//
//  Created by zuojianshijue on 16/1/2.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//

#import "JBZYSubViewController.h"
#import "JBZYCollectionViewCell.h"
#import "WebViewController.h"
#import "DataModeOB.h"
@interface JBZYSubViewController (){
    NSArray *arrData;
}
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation JBZYSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.strTitle = @"基本字源";
    self.collectionView.layer.cornerRadius = 8.0f;
    self.collectionView.layer.masksToBounds = YES;
    self.collectionView.layer.borderWidth= 10;
    self.collectionView.layer.borderColor = [UIColor orangeColor].CGColor;
   self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor
    
    [self getData];
}
-(void)backView{
    [self dismissViewControllerAnimated:YES
                             completion:^{}];
}

#pragma get data
-(void)getData{
    DataModeOB *modeOB = [[DataModeOB alloc] init];
    arrData = [modeOB queryWithType:[NSString stringWithFormat:@"%d",_type] withTableName:@"zy_category"];
}
#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return arrData.count;
    
    
}

- (JBZYCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    zy_categoryOB *zy_category = [arrData objectAtIndex:indexPath.row];
    NSArray *arr = [zy_category.icon_path  componentsSeparatedByString:@"/"];
    NSString *imgName = [arr lastObject];
    static NSString * const reuseIdentifier = @"JBZYCollectionViewCell";
    JBZYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imageLogo.image = [UIImage imageNamed:imgName];
    cell.titleLabel.text = zy_category.title;
    // Configure the cell
    int i = arc4random()%8;
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"background_%d",i]]];
    cell.backgroundView =imageV;
    
    return cell;
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    zy_categoryOB *zy_category = [arrData objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WebViewController *hzcsVC = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    hzcsVC.strUrl = [NSString stringWithFormat:@"http://www.yuwen100.cn/yuwen100/hzzy/ios/jbzy-iPhone/%@/index.html",zy_category.web_path_id];
    
    [self presentViewController:hzcsVC animated:YES completion:^{}];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //    CGFloat height = 260.0f;
    CGFloat width = (CGRectGetWidth(collectionView.frame) - 70) /7 ;
    CGFloat height =(CGRectGetHeight(collectionView.frame)-20)/2;
    
    return CGSizeMake(width, height);
    
    
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//
//{
//    
//    UICollectionReusableView *reusableview = nil;
//    
//    if (kind == UICollectionElementKindSectionHeader){
//        
//        CSPGoodsSectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
//        
//        reusableview = headerView;
//        
//    }
//    
//    return reusableview;
//}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(JBZYCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
   // [cell startAnimation];
    
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
