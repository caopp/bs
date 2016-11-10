//
//  DataModeOB.h
//  chinese
//
//  Created by zuojianshijue on 15/11/28.
//  Copyright © 2015年 zhujohnle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDBManager.h"
#import "bushouOB.h"
#import "zy_categoryOB.h"
#import "gameOB.h"
#import "zidianOB.h"
#import "chengyuOB.h"
#import "orderpyOB.h"
#import "pinyinOB.h"
#import "bsbhOB.h"
#import "bushouOB.h"
#import "zbhOB.h"
#import "szOB.h"

@interface DataModeOB : NSObject{
     //FMDatabase * _db;
}
@property (nonatomic, strong) FMDatabase *db;
//查找基本字源
- (NSArray *)queryWithType:(NSString *)type withTableName:(NSString*)tableName;
//查找游戏
- (NSArray *)queryWithStep:(NSString *)step withTableName:(NSString*)tableName;
//查找 爆破
- (NSArray *)queryWithRefid:(NSString *)refid withTableName:(NSString*)tableName;
//查找 爆破Py
- (NSArray *)queryWithPYRefid:(NSString *)refid withTableName:(NSString*)tableName;
//查找 爆破CY
- (NSArray *)queryWithcybh:(NSString *)cybh withTableName:(NSString*)tableName;
//查找 py 目录
- (NSArray *)queryWithPYHead:(NSString *)firstPY withTableName:(NSString*)tableName;
- (NSArray *)queryWithPY:(NSString *)py withTableName:(NSString*)tableName;

//查找 py 目录
- (NSArray *)queryWithPSBH:(NSString *)bihua withTableName:(NSString*)tableName;
//查找 bs  内容
- (NSArray *)queryWithPSBu:(NSString *)bu withSbh:(NSString *)sbh withTableName:(NSString*)tableName;
//查找 QB 目录
- (NSArray *)queryWithQBBH:(NSString *)qb withBH:(NSString *)bihua withTableName:(NSString*)tableName;
//学习记录
-(int)getIntwithSz:(NSString *)shengzi withFirst:(NSString *)first withSecond:(NSString * )second;
//插入学习记录 爆破汉字  Hz
-(BOOL)insertHZWithRefid:(NSString *)refid withShenzi:(NSString *)shengzi withtableName:(NSString *)tableName;
//删除学习记录
-(BOOL)clearSz:(NSString *)shengzi withFirst:(NSString *)first withSecond:(NSString *)second;
-(NSArray *)querywithSZWithrefid:(NSString *)refid;
-(BOOL)updateHZWithRefid:(NSString *)refid withShenzi:(NSString *)shengzi withtableName:(NSString *)tableName;
-(NSArray *)querywithSZWithShengzi:(NSString *)shengzi withMode:(NSInteger)mode withCount:(NSInteger)count;
- (NSArray *)queryWithZi:(NSString *)zi withTableName:(NSString*)tableName;
@end
