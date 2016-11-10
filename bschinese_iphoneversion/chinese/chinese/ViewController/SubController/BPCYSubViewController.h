//
//  BPCYSubViewController.h
//  chinese
//
//  Created by zuojianshijue on 16/1/16.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//

#import "BaseViewController.h"

@interface BPCYSubViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UILabel *fontLabel;
@property (strong, nonatomic) IBOutlet UILabel *pyLabel;
@property (strong, nonatomic) IBOutlet UIButton *numbButton;
@property (strong, nonatomic) IBOutlet UIImageView *cydhImgV;
@property (strong, nonatomic) IBOutlet UIImageView *bgImgV;
@property (strong, nonatomic) IBOutlet UITextView *cysyText;
@property(assign,nonatomic) NSInteger modeFirst;
@property(assign,nonatomic)NSInteger firstCount;
@property (strong, nonatomic) IBOutlet UIImageView *bpVoice;

@property(strong,nonatomic)NSArray *arrNumb;;
@end
