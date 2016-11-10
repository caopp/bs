//
//  DataModeOB.m
//  chinese
//
//  Created by zuojianshijue on 15/11/28.
//  Copyright © 2015年 zhujohnle. All rights reserved.
//

#import "DataModeOB.h"

#define kUserTableName @""

@implementation DataModeOB
- (id) init {
    self = [super init];
    if (self) {
        //========== 首先查看有没有建立message的数据库，如果未建立，则建立数据库=========
        _db = [SDBManager defaultDBManager].dataBase;
        
    }
    return self;
}
- (void) createDataBase{}

- (void) deleteUserWithId:(NSString *) uid{
    
}



- (NSArray *)queryWithSql:(NSString *)sql withTableName:(NSString*)tableName{
    
    NSArray *arrData = [[NSArray alloc] init];
    
    FMResultSet *rs = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@", tableName]];
    while ([rs next]) {
        bushouOB* session = [[bushouOB alloc] init];
        int columnIndex = 0;
       session.xuhao = [rs stringForColumnIndex:columnIndex]; columnIndex++;
       session.zi = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.bu = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.sbh = [rs stringForColumnIndex:columnIndex]; columnIndex++;
    }
    
    [rs close];
    return arrData;
    
}


//查找基本字源
- (NSArray *)queryWithType:(NSString *)type withTableName:(NSString*)tableName{
    
    NSMutableArray *arrData = [[NSMutableArray alloc] init];
    
    FMResultSet *rs = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ where type = %@", tableName,type]];
    while ([rs next]) {
        zy_categoryOB* session = [[zy_categoryOB alloc] init];
        int columnIndex = 0;
        session._id = [rs intForColumnIndex:columnIndex]; columnIndex++;
        session.type = [rs intForColumnIndex:columnIndex]; columnIndex++;
        session.icon_path = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.web_path_id = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.title = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.titie_backgroud = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        [arrData addObject:session];
    }
    
    [rs close];
    return arrData;
    
}
//查找游戏
- (NSArray *)queryWithStep:(NSString *)step withTableName:(NSString*)tableName{
    
    NSMutableArray *arrData = [[NSMutableArray alloc] init];
    
    FMResultSet *rs = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ where step = %@", tableName,step]];
    while ([rs next]) {
        gameOB* session = [[gameOB alloc] init];
        int columnIndex = 0;
        session._id = [rs intForColumnIndex:columnIndex]; columnIndex++;
        session.step = [rs intForColumnIndex:columnIndex]; columnIndex++;
        session.type = [rs intForColumnIndex:columnIndex]; columnIndex++;
        session.icon_path = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        
        [arrData addObject:session];
    }
    
    [rs close];
    return arrData;
    
}
//查找 爆破HZ
- (NSArray *)queryWithRefid:(NSString *)refid withTableName:(NSString*)tableName{
    
    NSMutableArray *arrData = [[NSMutableArray alloc] init];
    
    FMResultSet *rs = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ where refid = %@", tableName,refid]];
    while ([rs next]) {
        zidianOB* session = [[zidianOB alloc] init];
        int columnIndex = 0;
        session.refid = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.zitou = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.pinyin = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.ytzi = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.shiyi = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.yanbian = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.cy = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.cysy = [rs stringForColumnIndex:columnIndex];columnIndex++;
        [arrData addObject:session];
    }
    
    [rs close];
    return arrData;
    
}
//查找 爆破HZ
- (NSArray *)queryWithZi:(NSString *)zi withTableName:(NSString*)tableName{
    
    NSMutableArray *arrData = [[NSMutableArray alloc] init];
    
    FMResultSet *rs = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ where zitou = '%@'", tableName,zi]];
    while ([rs next]) {
        zidianOB* session = [[zidianOB alloc] init];
        int columnIndex = 0;
        session.refid = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.zitou = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.pinyin = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.ytzi = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.shiyi = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.yanbian = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.cy = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.cysy = [rs stringForColumnIndex:columnIndex];columnIndex++;
        [arrData addObject:session];
    }
    
    [rs close];
    return arrData;
    
}

//查找 爆破Py
- (NSArray *)queryWithPYRefid:(NSString *)refid withTableName:(NSString*)tableName{
    
    NSMutableArray *arrData = [[NSMutableArray alloc] init];
    
    FMResultSet *rs = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ where refid = %@ order by xuhao", tableName,refid]];
    while ([rs next]) {
        pinyinOB* session = [[pinyinOB alloc] init];
        int columnIndex = 0;
        session.xuhao = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.refid = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.zi = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.pinyin = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.pyj = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.py = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.head = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.diaohao = [rs stringForColumnIndex:columnIndex];columnIndex++;
        [arrData addObject:session];
    }
    
    [rs close];
    return arrData;
    
}
//插入学习记录 爆破汉字  Hz
-(BOOL)insertHZWithRefid:(NSString *)refid withShenzi:(NSString *)shengzi withtableName:(NSString *)tableName{
     return  [_db executeUpdate:@"INSERT  INTO sz(bh,shengzi) VALUES (?,?)",refid,shengzi];
}

-(BOOL)updateHZWithRefid:(NSString *)refid withShenzi:(NSString *)shengzi withtableName:(NSString *)tableName{
    return  [_db executeUpdate:[NSString stringWithFormat:@"UPDATE sz set shengzi = %@ where bh = %@",shengzi,refid]];
}
-(int)getIntwithSz:(NSString *)shengzi withFirst:(NSString *)first withSecond:(NSString * )second {
    FMResultSet *rs = [_db executeQuery:[NSString stringWithFormat:@"select count(*) from ( select * from sz  where ( shengzi = %@ and  (bh >= %@ and bh <=%@))) ",shengzi,first,second]];
    
     while ([rs next]) {
         int columnIndex = 0;
         int count = [rs intForColumnIndex:columnIndex]; columnIndex++;
         return  count;
     }
    return 0;
}
-(BOOL)clearSz:(NSString *)shengzi withFirst:(NSString *)first withSecond:(NSString *)second{
    return  [_db executeUpdate:@"Delete from sz where  (bh >= ? and bh <=?)",first,second];
}
-(NSArray *)querywithSZWithrefid:(NSString *)refid{
    NSMutableArray *arrData = [[NSMutableArray alloc] init];
    
    FMResultSet *rs = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM sz where bh = %@",refid]];
    while ([rs next]) {
        szOB* session = [[szOB alloc] init];
        int columnIndex = 0;
        session.bh = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.shengzi = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        [arrData addObject:session];
    }
    
    [rs close];
    return arrData;

}
-(NSArray *)querywithSZWithShengzi:(NSString *)shengzi withMode:(NSInteger)mode withCount:(NSInteger)count{
    NSMutableArray *arrData = [[NSMutableArray alloc] init];
    
    FMResultSet *rs = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM sz where shengzi = %@ and bh between %ld  and %ld" ,shengzi,mode,mode+count-1]];
    while ([rs next]) {
        szOB* session = [[szOB alloc] init];
        int columnIndex = 0;
        session.bh = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.shengzi = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        [arrData addObject:session];
    }
    
    [rs close];
    return arrData;
    
}
//查找 爆破CY
- (NSArray *)queryWithcybh:(NSString *)cybh withTableName:(NSString*)tableName{
    
    NSMutableArray *arrData = [[NSMutableArray alloc] init];
    
    FMResultSet *rs = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ where cybh = %@", tableName,cybh]];
    while ([rs next]) {
        chengyuOB* session = [[chengyuOB alloc] init];
        int columnIndex = 0;
        session.cybh = [rs intForColumnIndex:columnIndex]; columnIndex++;
        session.CYCimu = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.CYFayin = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.CYShiyi = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.CYChuchu = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.CYShili = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.CYJinyi = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.CYFanyi = [rs stringForColumnIndex:columnIndex];columnIndex++;
        [arrData addObject:session];
    }
    
    [rs close];
    return arrData;
    
}
////插入学习记录 爆破汉字  Hz
//-(BOOL)insertCYWithRefid:(NSString *)cyph withtableName:(NSString *)tableName{
//    FMResultSet *rs = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ where cyph = %@", tableName,cyph]];
//    return YES;
//}
 //查找 py 目录
- (NSArray *)queryWithPYHead:(NSString *)firstPY withTableName:(NSString*)tableName{
    
    NSMutableArray *arrData = [[NSMutableArray alloc] init];
    
    FMResultSet *rs = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ where head = '%@'", tableName,firstPY]];
    while ([rs next]) {
        orderpyOB* session = [[orderpyOB alloc] init];
        int columnIndex = 0;
        session.head = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.py = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        [arrData addObject:session];
    }
    
    [rs close];
    return arrData;
    
}

//查找 py 文字
- (NSArray *)queryWithPY:(NSString *)py withTableName:(NSString*)tableName{
    
    NSMutableArray *arrData = [[NSMutableArray alloc] init];
    
    FMResultSet *rs = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ where py = '%@'", tableName,py]];
    while ([rs next]) {
        pinyinOB* session = [[pinyinOB alloc] init];
        int columnIndex = 0;
        session.xuhao = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.refid = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.zi = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.pinyin = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.pyj = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.py = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        
        session.head = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.diaohao = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        [arrData addObject:session];
    }
    
    [rs close];
    return arrData;
    
}
//查找 py 目录
- (NSArray *)queryWithPSBH:(NSString *)bihua withTableName:(NSString*)tableName{
    
    NSMutableArray *arrData = [[NSMutableArray alloc] init];
    
    FMResultSet *rs;
    if (bihua) {
        rs = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ where bihua = '%@'", tableName,bihua]];
    }else{
        rs = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ ", tableName]];
    }
    
    while ([rs next]) {
        bsbhOB* session = [[bsbhOB alloc] init];
        int columnIndex = 0;
        session.bu = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.bushow = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.bihua = [rs stringForColumnIndex:columnIndex]; columnIndex++;

        [arrData addObject:session];
    }
    
    [rs close];
    return arrData;
    
}
//查找 bs  内容
- (NSArray *)queryWithPSBu:(NSString *)bu withSbh:(NSString *)sbh withTableName:(NSString*)tableName{
    
    NSMutableArray *arrData = [[NSMutableArray alloc] init];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ where 1=1 ",tableName]; 
    if (bu) {
       sql = [sql stringByAppendingString:[NSString stringWithFormat:@"and bu = '%@' ",bu]];
    }
    if (sbh) {
       sql = [sql stringByAppendingString:[NSString stringWithFormat:@"and sbh = '%@' ",sbh]];

    }
    FMResultSet *rs = [_db executeQuery:sql];
    
    while ([rs next]) {
        bushouOB* session = [[bushouOB alloc] init];
        int columnIndex = 0;
        session.xuhao = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.zi = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.bu = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.sbh = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        [arrData addObject:session];
    }
    
    [rs close];
    return arrData;
    
}
//查找 QB 目录
- (NSArray *)queryWithQBBH:(NSString *)qb withBH:(NSString *)bihua withTableName:(NSString*)tableName{
    
    NSMutableArray *arrData = [[NSMutableArray alloc] init];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ where begin= '%@' ",tableName,qb];
    if (bihua) {
        sql = [sql stringByAppendingString:[NSString stringWithFormat:@"and bihua = '%@' ",bihua]];
    }
    FMResultSet *rs = [_db executeQuery:sql];

    while ([rs next]) {
        zbhOB* session = [[zbhOB alloc] init];
        int columnIndex = 0;
        session.xuhao = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.zi = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.bihua = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.begin = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        session.end = [rs stringForColumnIndex:columnIndex]; columnIndex++;
        [arrData addObject:session];
    }
    
    [rs close];
    return arrData;
    
}



@end
