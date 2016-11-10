//
//  BPHZSubViewController.h
//  chinese
//
//  Created by zuojianshijue on 16/1/16.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//

#import "BaseViewController.h"

@interface BPHZSubViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UILabel *fontLabel;
@property (strong, nonatomic) IBOutlet UILabel *pyLabel;
@property (strong, nonatomic) IBOutlet UIImageView *bhImgV;
@property (strong, nonatomic) IBOutlet UITextView *bhTextV;
@property (strong, nonatomic) IBOutlet UITextView *contentTextV;
@property (strong, nonatomic) IBOutlet UIImageView *fontImgV;
@property (strong, nonatomic) IBOutlet UIImageView *xxImgV;
@property (strong, nonatomic) IBOutlet UIButton *numbBtn;
@property (strong, nonatomic) IBOutlet UIButton *redbtn;
@property (strong, nonatomic) IBOutlet UIButton *greenbtn;
@property (strong, nonatomic) IBOutlet UIImageView *laba;
@property(assign,nonatomic) NSInteger modeFirst;
@property(assign,nonatomic) NSInteger firstCount;
@property(strong,nonatomic)NSArray *arrNumb;
@property(assign,nonatomic)int numbId;//序号
@end
