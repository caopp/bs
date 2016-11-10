//
//  HZQYViewController.h
//  chinese
//
//  Created by zuojianshijue on 15/12/7.
//  Copyright © 2015年 zhujohnle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
typedef enum _HZCSTYPE {
    HZQYTYPE = 0,
    QWWZTYPE = 1,
    ZZFFTYPE = 2,
    HZYBTYPE = 3
} HZCSTYPE;
@interface HZQYViewController : BaseViewController
@property(nonatomic,assign)HZCSTYPE hztype;
@end
