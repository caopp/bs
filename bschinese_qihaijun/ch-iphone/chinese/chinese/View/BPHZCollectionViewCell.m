//
//  BPHZCollectionViewCell.m
//  chinese
//
//  Created by zuojianshijue on 16/1/10.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//

#import "BPHZCollectionViewCell.h"

@implementation BPHZCollectionViewCell

-(void)awakeFromNib{

}
- (IBAction)moreBtn:(id)sender {
    [_delegate showMore:self.tag];
}
- (IBAction)redBtnClick:(id)sender {
    [_delegate showRed:self.tag];
}
- (IBAction)greenBtnClick:(id)sender {
    [_delegate showGreen:self.tag];
}
-(void)loadFirstCount:(NSString *)first withSecond:(NSString *)second{
    NSString *str = [NSString stringWithFormat:@"%@-%@",first,second];
    [_moreButton setTitle:str forState:UIControlStateNormal];
}
@end
