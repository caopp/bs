//
//  BPHZCollectionViewCell.h
//  chinese
//
//  Created by zuojianshijue on 16/1/10.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BPDelegate <NSObject>
@optional
-(void)showMore:(NSInteger)btn;
-(void)showRed:(NSInteger)btn;
-(void)showGreen:(NSInteger)btn;
@end
@interface BPHZCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIButton *moreButton;
@property (strong, nonatomic) IBOutlet UIButton *redButton;
@property (strong, nonatomic) IBOutlet UIButton *greenButton;
@property(nonatomic,assign)id<BPDelegate>delegate;
@property (strong, nonatomic) IBOutlet UILabel *totolCount;

-(void)loadFirstCount:(NSString *)first withSecond:(NSString *)second;
@end
