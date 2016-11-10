//
//  ZYCDHViewController.m
//  chinese
//
//  Created by zuojianshijue on 15/12/8.
//  Copyright © 2015年 zhujohnle. All rights reserved.
//

#import "ZYCDHViewController.h"
#import "CollectionViewCell.h"
#import "DataModeOB.h"
#import "SGPopSelectView.h"
#import "BPHZSubViewController.h"
static NSString * const CellReuseIdentify = @"CellReuseIdentify";
@interface ZYCDHViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    int scrollTag;
    UIScrollView *scrollContent ;
    NSArray *arrPy;
    NSArray *arrPyContent;
    NSString *buSelect;
    NSArray *arrBS;
    NSArray *arrBSContent;
    NSArray *arrQB;
    NSArray *arrQBContent;
    NSString *qbSelect;//起笔选择
    NSArray *arrPyZM;
    NSMutableArray *arrBSBH;
    NSMutableArray *arrSYBH;
    NSMutableArray *arrQBBH;
    NSInteger popTag;
}
@property (strong, nonatomic) IBOutlet UIImageView *bkImg;
@property (strong, nonatomic) IBOutlet UIImageView *kBkImg;
@property (strong, nonatomic) IBOutlet UIImageView *wightImg;
@property (nonatomic, strong) NSArray *selections;
@property (nonatomic, strong) SGPopSelectView *popView;
@end

@implementation ZYCDHViewController


-(void)getData{
   
}
-(void)initWithArray{
    qbSelect = @"1";
     arrPyZM = [[NSArray alloc] initWithObjects:@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"y",@"z", nil];
    
    DataModeOB *modeOB = [[DataModeOB alloc] init];
    arrPy = [modeOB queryWithPYHead:@"a" withTableName:@"orderpy"];
    arrBS = [modeOB queryWithPSBH:nil withTableName:@"bsbh"];
    arrQB = [[NSArray alloc] initWithObjects:@"横起笔",@"竖起笔",@"撇起笔",@"点起笔",@"折起笔", nil];
    arrBSBH = [[NSMutableArray alloc] initWithCapacity:0];
    arrSYBH = [[NSMutableArray alloc] initWithCapacity:0];
    arrQBBH = [[NSMutableArray alloc] initWithCapacity:0];
    [arrBSBH addObject:@"全部"];
    for (int i = 1; i< 18; i++) {
        NSString *strNumb = [NSString stringWithFormat:@"%d",i];
        [arrBSBH addObject:strNumb];
    }
    [arrSYBH addObject:@"全部"];
    for (int i = 1; i< 27; i++) {
        NSString *strNumb = [NSString stringWithFormat:@"%d",i];
        [arrSYBH addObject:strNumb];
    }
    
    [arrQBBH addObject:@"全部"];
    for (int i = 1; i< 27; i++) {
        NSString *strNumb = [NSString stringWithFormat:@"%d",i];
        [arrQBBH addObject:strNumb];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithArray];
    self.strTitle = @"字源词典";
    UITapGestureRecognizer *gnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePop:)];
    //[self.view addGestureRecognizer:gnizer];
    // Do any additional setup after loading the view.
    UIImage *img = [UIImage imageNamed:@"bg_main_activity.9"];
    img = [img stretchableImageWithLeftCapWidth:2 topCapHeight:2];
    _bkImg.image = img;
    
//    UIImage *imgC = [UIImage imageNamed:@"bp_pagebg.9"];
//    //imgC = [imgC stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//    _kBkImg.image = imgC;
    
    UIImage *backgroudImage = [UIImage imageNamed:@"dictionary_divider_back"];
    
    backgroudImage = [backgroudImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeTile];
    _wightImg.image = backgroudImage;
    _wightImg.userInteractionEnabled = YES;
    
    UIImageView *tapZD = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-40)/3, 10, (self.view.frame.size.width-40)/3, 30)];
    tapZD.image = [UIImage imageNamed:@"indivitor_back"];
    tapZD.userInteractionEnabled = YES;
    tapZD.backgroundColor = [UIColor blackColor];
    
    
    UIImageView *top = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, self.view.frame.size.width-20, self.view.frame.size.height-20-20-65)];
    UIImage *imgTop = [UIImage imageNamed:@"dictionary_indivitor_background"];
    imgTop = [imgTop stretchableImageWithLeftCapWidth:11 topCapHeight:11];
    top.image = imgTop;
    [_wightImg addSubview:top];

    UIImageView *bottom = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-65-10, self.view.frame.size.width-20, 15)];
    bottom.image = [UIImage imageNamed:@"dictionary_viewpager_bottom"];
    [_wightImg addSubview:bottom];
    [_wightImg addSubview:tapZD];
    NSArray *arrTitle  = [[NSArray alloc] initWithObjects:@"拼音",@"部首",@"起笔", nil];
    for (int i = 0 ;i <3;i++){
        UIButton *btn =[[UIButton alloc] initWithFrame:CGRectMake(tapZD.frame.size.width /3*i + 10 , 5, (tapZD.frame.size.width - 60)/3, 25)];
        [btn setBackgroundImage:[UIImage imageNamed:@"indivator_default"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"indivator_selected"] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        [btn setTitle:[arrTitle objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (i==0) {
            btn.selected = YES;
        }
        btn.tag = 1000+i;
        [btn addTarget:self action:@selector(changeTab:) forControlEvents:UIControlEventTouchUpInside];
        [tapZD addSubview:btn];
    }
    scrollContent = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 50, self.view.frame.size.width-30, self.view.frame.size.height-20 -30 -65-10)];
    scrollContent.delegate = self;
    scrollContent.backgroundColor = [UIColor colorWithRed:0.88 green:0.84 blue:0.78 alpha:1];
    [_wightImg addSubview:scrollContent];
    scrollContent.contentSize = CGSizeMake((self.view.frame.size.width-30)*3, self.view.frame.size.height-20 -30 -20-100-65-30);
    scrollContent.pagingEnabled = YES;
    for (int i = 0; i < 3; i++) {
        UIView *view = [self viewCreate:i];
        [scrollContent addSubview:view];
    }
   // self.selections = @[@"Shake It Off",@"All About that Bass",@"Animals",@"Take Me To Church",@"Out Of The Woods",@"Centuries",@"I'm Not the Only One",@"Burnin' It Down"];
    self.popView = [[SGPopSelectView alloc] init];
    //self.popView.selections = self.selections;
    __weak typeof(self) weakSelf = self;
    self.popView.selectedHandle = ^(NSInteger selectedIndex){
        [weakSelf hidePop:nil];
        [weakSelf changeData:selectedIndex];
        NSLog(@"selected index %ld, content is %@", selectedIndex, weakSelf.selections[selectedIndex]);
    };
    
}
-(void)changeData:(NSInteger)selectedIndex{
    
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:popTag];
    NSString *str = [self.selections objectAtIndex:selectedIndex];
    [btn setTitle:str forState:UIControlStateNormal];
    
    switch (popTag) {
        case 88:{
            DataModeOB *modeOB = [[DataModeOB alloc] init];
            arrPy = [modeOB queryWithPYHead:str withTableName:@"orderpy"];
            UICollectionView *collection =(UICollectionView *)[ self.view viewWithTag:96];
            [collection reloadData];
        }
            break;
        case 89:{
            if ([str isEqualToString:@"全部"]) {
                str = nil;
            }
            DataModeOB *modeOB = [[DataModeOB alloc] init];
            arrBS = [modeOB queryWithPSBH:str withTableName:@"bsbh"];
            UITableView *table =(UITableView *)[ self.view viewWithTag:98];
            [table reloadData];
        }
            
            break;
        case 90:{
            if ([str isEqualToString:@"全部"]) {
                str = nil;
            }
            DataModeOB *modeOB = [[DataModeOB alloc] init];
            arrBSContent = [modeOB queryWithPSBu:buSelect withSbh:str withTableName:@"bushou"];
            UICollectionView *collect94 = (UICollectionView *)[self.view viewWithTag:94];
            [collect94 reloadData];
        }
            break;
        case 91:{
            if ([str isEqualToString:@"全部"]) {
                str = nil;
            }
            DataModeOB *modeOB = [[DataModeOB alloc] init];
            arrQBContent = [modeOB queryWithQBBH:qbSelect withBH:str withTableName:@"zbh"];
            UICollectionView *collect93 = (UICollectionView *)[self.view viewWithTag:93];
            [collect93 reloadData];
        }
            break;
        default:
            break;
    }
}

-(UIView *)viewCreate:(int)tag{
    UIView *viewContent = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-30)*tag, 0, self.view.frame.size.width-20, self.view.frame.size.height-20 -30 -65-10)];
    viewContent.backgroundColor = [UIColor colorWithRed:0.88 green:0.84 blue:0.78 alpha:1];
    [_wightImg addSubview:viewContent];

    UIImageView *imageMidden = [[UIImageView alloc] initWithFrame:CGRectMake(viewContent.frame.size.width/3-(tag==2?40:0), 0, viewContent.frame.size.width/6, viewContent.frame.size.height)];
    imageMidden.image = [UIImage imageNamed:@"dictionary_divider_back"];
    [viewContent addSubview:imageMidden];
    
    UIImageView *logoMidden = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageMidden.frame.size.width-60, imageMidden.frame.size.width-60)];
    logoMidden.center = CGPointMake(imageMidden.frame.size.width/2, imageMidden.frame.size.height/2);
    logoMidden.image= [UIImage imageNamed:@"dic_divider_arrow"];
    [imageMidden addSubview:logoMidden];
    
    UIImageView *resultImg = [[UIImageView alloc] initWithFrame:CGRectMake(viewContent.frame.size.width/2-(tag==2?40:0) +10,tag==0?10:40, viewContent.frame.size.width/2 + (tag==2?40:0)-20, viewContent.frame.size.height-20-(tag==0?0:20))];
    resultImg.userInteractionEnabled = YES;
    UIImage *img = [UIImage imageNamed:@"dictionary_reslut_back.9"];
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(25,180, 7.5, 10)];
    resultImg.image = img;
    [viewContent addSubview:resultImg];
    
    
    UIImageView *titleImg = [[UIImageView alloc] initWithFrame:CGRectMake(resultImg.frame.size.width/2-48, -5, 93.6, 21)];
    titleImg.image = [UIImage imageNamed:@"001"];
    [resultImg addSubview:titleImg];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.itemSize = CGSizeMake((resultImg.frame.size.width-40)/5, (resultImg.frame.size.height -20)/5);
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 20, resultImg.frame.size.width-20, resultImg.frame.size.height - 20 -10) collectionViewLayout:layout];
    collection.layer.masksToBounds = YES;
    collection.tag = 95-tag;
    if (collection.tag ==93) {
        collection.backgroundColor = [UIColor redColor];
    }
    collection.delegate = self;
    collection.dataSource = self;
    [collection registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CellReuseIdentify];
    collection.backgroundColor = [UIColor whiteColor];
    [resultImg addSubview:collection];
    
    
    switch (tag) {
        case 0:
            [self createPYMenuWithSupView:viewContent];
            break;
        case 1:
            [self createBSMenuWithSupView:viewContent];
            break;
        case 2:
            [self createQBMenuWithSupView:viewContent];
            break;
        default:
            break;
    }
    return viewContent;
}


-(void)createPYMenuWithSupView:(UIView *)view{
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width/10, 30)];
    labelTitle.text = @"首字母:";
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.font = [UIFont systemFontOfSize:12];
    [view addSubview:labelTitle];
    
    UIButton *btnSelect = [[UIButton alloc] initWithFrame:CGRectMake(view.frame.size.width/10-20 , 0, 128, 30)];
    btnSelect.tag = 88;
    [btnSelect setTitle:@"A" forState:UIControlStateNormal];
    [btnSelect setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSelect addTarget:self action:@selector(changeSelect:) forControlEvents:UIControlEventTouchUpInside];
    [btnSelect setBackgroundImage:[UIImage imageNamed:@"spinner_back_pressed"] forState:UIControlStateNormal];
    [view addSubview:btnSelect];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.itemSize = CGSizeMake((view.frame.size.width/3-40-30)/3, (view.frame.size.height - 80 -20-50)/5);
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 35, view.frame.size.width/3-20, view.frame.size.height - 40 ) collectionViewLayout:layout];
    collection.layer.masksToBounds = YES;
    collection.tag = 96;
    collection.layer.borderColor = [UIColor  brownColor].CGColor;
    collection.layer.borderWidth  = 4.0f;
    collection.delegate = self;
    collection.dataSource = self;
    [collection registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CellReuseIdentify];
    collection.backgroundColor = [UIColor whiteColor];
    [view addSubview:collection];
}

-(void)createBSMenuWithSupView:(UIView *)view{
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width/10, 30)];
    labelTitle.text = @"部首笔画:";
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [view addSubview:labelTitle];
    labelTitle.font = [UIFont systemFontOfSize:12];
    
    UIButton *btnSelect = [[UIButton alloc] initWithFrame:CGRectMake(view.frame.size.width/10-20, 0,128, 30)];
     [btnSelect setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSelect setTitle:@"全部" forState:UIControlStateNormal];
    [btnSelect setBackgroundImage:[UIImage imageNamed:@"spinner_back_pressed"] forState:UIControlStateNormal];
    btnSelect.tag = 89;
    btnSelect.titleLabel.font = [UIFont systemFontOfSize:16];
    [btnSelect addTarget:self action:@selector(changeSelect:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnSelect];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(10, 30, view.frame.size.width/3-20, view.frame.size.height - 40 ) style:UITableViewStylePlain];
    tableview.layer.masksToBounds = YES;
    tableview.layer.borderColor = [UIColor  brownColor].CGColor;
    tableview.layer.borderWidth  = 4.0f;
    tableview.tag = 98;
    tableview.delegate = self;
    tableview.dataSource = self;
    [view addSubview:tableview];
    
    UILabel *labelBH = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width/2 , 0, view.frame.size.width/6, 30)];
    labelBH.text = @"剩余笔画:";
    labelBH.textAlignment = NSTextAlignmentCenter;
    labelBH.font = [UIFont systemFontOfSize:12];
    [view addSubview:labelBH];
    
    UIButton *btnSelectBH = [[UIButton alloc] initWithFrame:CGRectMake(view.frame.size.width*2/3-40, 0, 128, 30)];
    [btnSelectBH setTitle:@"全部" forState:UIControlStateNormal];
     [btnSelectBH setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSelectBH setBackgroundImage:[UIImage imageNamed:@"spinner_back_pressed"] forState:UIControlStateNormal];
    btnSelectBH.tag = 90;
    [btnSelectBH addTarget:self action:@selector(changeSelect:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnSelectBH];
    
    
}
-(void)createQBMenuWithSupView:(UIView *)view{
    UIImageView *imageBk = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, view.frame.size.width/3 - 40-20, view.frame.size.height - 10)];
    UIImage *img = [UIImage imageNamed:@"bihua_background.9"];
    //img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(25,180, 7.5, 10)];
     img = [img stretchableImageWithLeftCapWidth:20 topCapHeight:60];
    imageBk.image = img;
    imageBk.userInteractionEnabled = YES;
    [view addSubview:imageBk];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(7, 20, view.frame.size.width/3 - 20-53, view.frame.size.height - 20-20) style:UITableViewStylePlain];
    tableview.tag = 99;
        tableview.delegate = self;
        tableview.dataSource = self;
    [imageBk addSubview:tableview];
    
    UILabel *labelBH = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width/2 +20, 0, view.frame.size.width/10, 30)];
    labelBH.text = @"文本笔画:";
    labelBH.font = [UIFont systemFontOfSize:12];
    labelBH.textAlignment = NSTextAlignmentCenter;
    [view addSubview:labelBH];
    
    UIButton *btnSelectBH = [[UIButton alloc] initWithFrame:CGRectMake(view.frame.size.width*2/3 -40, 0, 128, 30)];
    [btnSelectBH setTitle:@"全部" forState:UIControlStateNormal];
    [btnSelectBH setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSelectBH setBackgroundImage:[UIImage imageNamed:@"spinner_back_pressed"] forState:UIControlStateNormal];
    btnSelectBH.tag = 91;
    [btnSelectBH addTarget:self action:@selector(changeSelect:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnSelectBH];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == scrollContent) {
        CGPoint offset = scrollView.contentOffset;
        CGFloat width = scrollView.frame.size.width;
        int   tag = (int)(offset.x/width);
        if (scrollTag != tag) {
            scrollTag = tag;
            UIButton *btn = (UIButton *)[self.view viewWithTag:tag+1000];
            [self changeTab:btn];
        }
    }
   
    
}


-(void)changeSelect:(UIButton *)btn{
    switch (btn.tag) {
        case 88://首字母
            popTag = 88;
            self.selections = arrPyZM;
            break;
        case 89://笔画
            popTag = 89;
            self.selections = arrBSBH;
            break;
        case 90://笔画 剩余
            popTag = 90;
            self.selections = arrSYBH;
            break;
        case 91://起笔
            popTag = 91;
            self.selections = arrQBBH;
            break;
        default:
            break;
    }
    self.popView.selections = self.selections;
    CGPoint p = [(UIButton *)btn center];
    [self.popView showFromView:self.view atPoint:p animated:YES];
}

- (void)hidePop:(UIGestureRecognizer *)sender {
    [self.popView hide:YES];
}
//修改
-(void)changeTab:(UIButton *)btn{
    [self.popView hide:YES];
    for (int i = 0; i<3; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:i+1000];
        btn.selected = NO;
    }
    btn.selected = YES;
    [UIView animateWithDuration:0.5 animations:^{
        scrollTag = (int)btn.tag - 1000;
        scrollContent.contentOffset = CGPointMake(scrollContent.frame.size.width*(btn.tag-1000), 0);
    }];

}

#pragma mark UITableViewDelegate&&UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==99) {
        return arrQB.count;
    }else{
        return arrBS.count;
    }

}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    if (tableView.tag == 99) {
        cell.textLabel.text = [arrQB objectAtIndex:indexPath.row];
    }else{
        bsbhOB *bsbh = [arrBS objectAtIndex:indexPath.row];
        cell.textLabel.text = bsbh.bushow;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 99) {
        qbSelect =[NSString stringWithFormat:@"%ld",indexPath.row+1];
        DataModeOB *modeOB = [[DataModeOB alloc] init];
        arrQBContent = [modeOB queryWithQBBH:qbSelect withBH:nil withTableName:@"zbh"];
        UICollectionView *collect93 = (UICollectionView *)[self.view viewWithTag:93];
        [collect93 reloadData];
    }else{
        bsbhOB *bsbh = [arrBS objectAtIndex:indexPath.row];
        buSelect = bsbh.bu;
        DataModeOB *modeOB = [[DataModeOB alloc] init];
        arrBSContent = [modeOB queryWithPSBu:bsbh.bu withSbh:nil withTableName:@"bushou"];
        UICollectionView *collect94 = (UICollectionView *)[self.view viewWithTag:94];
        [collect94 reloadData];
    }
}
#pragma  mark UICollectionViewDelegate&&UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (collectionView.tag) {
        case 96:
            return arrPy.count;
            break;
        case 95:
            return arrPyContent.count;
            break;
        case 94:
            return arrBSContent.count;
            break;
        case 93:
            return arrQBContent.count;
            break;
        default:
            return 0;
            break;
    }
  
    
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellReuseIdentify forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if (collectionView.tag == 96) {
        orderpyOB *orderpy = [arrPy objectAtIndex:indexPath.row];
        cell.textLabel.text = orderpy.py;

        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }else if(collectionView.tag == 95){
        pinyinOB *pinyin = [arrPyContent objectAtIndex:indexPath.row];
        cell.textLabel.text = pinyin.zi;//, indexPath.section, indexPath.row];
cell.textLabel.font = [UIFont systemFontOfSize:16];    }
    else if(collectionView.tag == 94){
        bushouOB *bushou = [arrBSContent objectAtIndex:indexPath.row];
        cell.textLabel.text = bushou.zi;//, indexPath.section, indexPath.row];
cell.textLabel.font = [UIFont systemFontOfSize:16];    }else if(collectionView.tag == 93){
        zbhOB *zbh = [arrQBContent objectAtIndex:indexPath.row];
        cell.textLabel.text = zbh.zi;//, indexPath.section, indexPath.row];
        //cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }
    return cell;

    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 96) {
        orderpyOB *orderpy = [arrPy objectAtIndex:indexPath.row];
        DataModeOB *modeOB = [[DataModeOB alloc] init];
        arrPyContent = [modeOB queryWithPY:orderpy.py withTableName:@"pinyin"];
        UICollectionView *collection =(UICollectionView *)[ self.view viewWithTag:95];
        [collection reloadData];
    }else{
        NSString *zi;
        switch (collectionView.tag) {
        
            case 95:{
                pinyinOB * pinyin = [arrPyContent objectAtIndex:indexPath.row];
                zi = pinyin.zi;
            }
                break;
            case 94:
            {
                bushouOB *bushou = [arrBSContent objectAtIndex:indexPath.row];
                zi = bushou.zi;
            }
                break;
            case 93:{
                zbhOB *zbh =[arrQBContent objectAtIndex:indexPath.row];
                zi = zbh.zi;
            }
                break;
            default:
                break;
        }
        DataModeOB *dataOb = [[DataModeOB alloc] init];
        NSArray *arr = [dataOb queryWithZi:zi withTableName:@"zidian"];
        if (arr.count) {
            zidianOB *zidian  =[arr objectAtIndex:0];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            BPHZSubViewController *bphzSubVC = [storyboard instantiateViewControllerWithIdentifier:@"BPHZSubViewController"];
            bphzSubVC.numbId = [zidian.refid intValue];
            //bphzSubVC.modeFirst = btn;
            //bphzSubVC.arrNumb = arr;
            [self presentViewController:bphzSubVC animated:YES completion:^{}];
        }
       
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return  CGSizeZero;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 10, 5, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.001f;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //    CGFloat height = 260.0f;
    if (collectionView.tag == 96) {
        CGFloat width =(CGRectGetWidth(collectionView.frame)-30)/3
        ;
        CGFloat height =(CGRectGetHeight(collectionView.frame)-50)/5;
        
        return CGSizeMake(width, height);
    }else{
        CGFloat width =(CGRectGetWidth(collectionView.frame)-20)/5
        ;
        CGFloat height =(CGRectGetHeight(collectionView.frame)-20)/5;
        
        return CGSizeMake(width, height);
    }
    
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.popView hide:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
