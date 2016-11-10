//
//  zy_categoryOB.h
//  chinese
//
//  Created by zuojianshijue on 16/1/19.
//  Copyright © 2016年 zhujohnle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zy_categoryOB : NSObject
@property(nonatomic,assign)int _id;
@property(nonatomic,assign)int type;
@property(nonatomic,strong)NSString *icon_path;
@property(nonatomic,strong)NSString *web_path_id;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *titie_backgroud;
@end
