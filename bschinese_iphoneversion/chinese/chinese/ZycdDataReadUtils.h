//
//  ZycdDataReadUtils.h
//  chinese
//
//  Created by zhujohnle on 15/12/13.
//  Copyright © 2015年 zhujohnle. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZycdDataReadUtils : NSObject

//从orderpy 数据中读取所有声母对应的拼音
//如select ＊ from orderpy where head =  'a'
+(NSMutableArray *) getPyFromOrderPyTableByPinyinHead :(NSString *) mSql;
//如select ＊ from py where py = 'bisou'
+(NSMutableArray *) getPyDitalFromPyTableByPinyinSample :(NSString *) mSql;

//如 select * from zbh where begin = 3 order by bihua 根据偏旁的比划数查询

+(NSMutableArray *) getZbhDitalBaseBihuaBegan:(NSString *)mSql;

//如 select * from bsbh where bihua = '3'

+(NSMutableArray *) getBuShouFromBsbBaseBihua:(NSString *)mSql;
//select * from bushou where bu  ='白'
+(NSMutableArray *) getHanZiditalByBushou:(NSString *)mSql;

//select * from zidian where zitou= \'的'  or refid=\'1011012'获取汉子的详情

+(NSMutableArray *) getWordDitalByZiOrId:(NSString *)mSql;

//select pyj from unipy where  根据拼音 查这个拼音的明细 ǎ 找a3 

+(NSMutableArray *) getPinyinFayin:(NSString *)mSql;


@end
