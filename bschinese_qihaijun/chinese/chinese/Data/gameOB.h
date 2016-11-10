//
//  gameOB.h
//  chinese
//
//  Created by zuojianshijue on 16/1/19.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface gameOB : NSObject
@property(nonatomic,assign)int _id;
@property(nonatomic,assign)int step;
@property(nonatomic,assign)int type;
@property(nonatomic,strong)NSString *icon_path;
@property(nonatomic,assign)BOOL isHidden;
@end
