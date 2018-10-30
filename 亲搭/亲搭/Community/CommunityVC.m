//
//  CommunityVC.m
//  亲搭
//
//  Created by KFZXSHANGJQ on 2018/10/11.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import "CommunityVC.h"
#import "CommunityCell.h"
#import "CommunityModel.h"
@interface CommunityVC ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)NSMutableArray *dataModel;

@end

@implementation CommunityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.view.backgroundColor = DFTColor(240, 240, 240);
    _tableView.backgroundColor = DFTColor(240, 240, 240);
    _tableView.estimatedRowHeight = 85;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:_tableView];
    // 搜索按钮
    UIButton *serchBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 23, 23)];
    [serchBtn setBackgroundImage:[UIImage imageNamed:@"search_icon"] forState:UIControlStateNormal];
    [serchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    // 添加按钮
    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 23, 23)];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"add_icon"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *serchBtnItem = [[UIBarButtonItem alloc]initWithCustomView:serchBtn];
    UIBarButtonItem *addBtnItem = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItems = @[addBtnItem,serchBtnItem];
    
    
    // 模拟数据
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    _dataModel = [NSMutableArray array];
    for (int i = 0; i<5; i++) {
        if (i<2) {
            dict = @{@"headerImg":@"header",
                     @"name":@"会飞的鱼",
                     @"senderInfo":@"生死挈阔，与子成说：执子之手，与子偕老！",
                     @"time":@"25分钟前",
                     @"imgArr":@[
                             @"社区图片01",
                             @"社区图片02",
                             @"社区图片03",
                             @"社区图片01",
                             @"社区图片02",
                             @"社区图片03"
                             ].mutableCopy,
                     @"nameArr":@[
                             @"小猪佩奇",
                             @"红果果",
                             @"小浣熊",
                             @"漩涡鸣人",
                             @"路飞",
                             @"犬夜叉"
                             ].mutableCopy
                     }.mutableCopy;
            CommunityModel *model = [[CommunityModel alloc]initWithDictionary:dict];
            NSLog(@"model%d=====%@",i,model.imgArr);

            [_dataModel addObject:model];
            
            NSLog(@"data=====%@",_dataModel);
        } else if (i>=2 && i<3){
            dict = @{@"headerImg":@"header",
                     @"name":@"会跑的🐷",
                     @"senderInfo":@"生死挈阔，与子成说!",
                     @"time":@"30分钟前",
                     @"imgArr":@[
                             @"社区图片01",
                             @"社区图片02",
                             @"社区图片03"
                             ].mutableCopy,
                     @"nameArr":@[
                             @"小猪佩奇",
                             @"路飞",
                             @"犬夜叉"
                             ].mutableCopy
                     }.mutableCopy;
            
            CommunityModel *model = [[CommunityModel alloc]initWithDictionary:dict];
            NSLog(@"model%d=====%@",i,model.senderInfo);

            [_dataModel addObject:model];
            NSLog(@"data=====%@",_dataModel);
        } else {
            dict = @{@"headerImg":@"header",
                     @"name":@"会跑的🐷",
                     @"senderInfo":@"生死挈阔，与子成说!",
                     @"time":@"30分钟前",
                     @"imgArr":@[
                             @"社区图片01",
                             @"社区图片02",
                             @"社区图片03",
                             @"社区图片01",
                             @"社区图片02",
                             @"社区图片03",
                             @"社区图片01",
                             @"社区图片02",
                             @"社区图片03"
                             ].mutableCopy,
                     @"nameArr":@[
                             @"小猪佩奇",
                             @"路飞",
                             @"犬夜叉",
                             @"小猪佩奇",
                             @"路飞",
                             @"犬夜叉",
                             @"小猪佩奇",
                             @"路飞",
                             @"犬夜叉",
                             @"小猪佩奇",
                             @"路飞",
                             @"犬夜叉"
                             ].mutableCopy
                     }.mutableCopy;
            
            CommunityModel *model = [[CommunityModel alloc]initWithDictionary:dict];
            NSLog(@"model%d=====%@",i,model.senderInfo);
            
            [_dataModel addObject:model];
            NSLog(@"data=====%@",_dataModel);
        }
    }
    
    [self creatUI];
}

#pragma 搜索方法
- (void)searchAction{
    NSLog(@"searchAction");

}
#pragma 添加方法
- (void)addAction{
    NSLog(@"addAction");
}
- (void)creatUI{
    CGFloat itemWidth = (WIDTH-50)/4.0;
    CGFloat itemHeight= itemWidth/1.23;
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, itemWidth*4+30, itemHeight+80)];
    headView.backgroundColor = DFTColor(244, 244, 244);

    // 热门圈子
    UIView *hotView = [[UIView alloc]initWithFrame:CGRectMake(10, 5, itemWidth*4+30, 80+itemHeight)];
    hotView.backgroundColor = [UIColor whiteColor];
    hotView.layer.borderColor = BorderColor;
    hotView.layer.borderWidth = 1;
    hotView.layer.cornerRadius = 5;
    UILabel *hotLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, itemWidth*4, 30)];
    hotLabel.font = [UIFont systemFontOfSize:13];
    hotLabel.text = @"热门圈子";
    hotLabel.textColor = TextGrayColor;
    [hotView addSubview:hotLabel];
    NSArray *titleNames = @[@"信仰",@"摄影",@"旅游",@"8090"];
    for (int i=0; i<4; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake((10+itemWidth)*i, 30, itemWidth, itemHeight)];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"hot_img%d",i]];
        imgView.tag = 3100 + i;
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, itemWidth, itemHeight)];
        bgView.backgroundColor = HXColorA(133, 12, 234, 0);
        
        UILabel *titeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, itemWidth, 25)];
        titeLabel.backgroundColor = HXColorA(255, 255, 255, 0.3);
        titeLabel.textAlignment = NSTextAlignmentCenter;
        titeLabel.text = titleNames[i];
        titeLabel.textColor = MainColor;
        titeLabel.font = [UIFont systemFontOfSize:16];
        [imgView addSubview:titeLabel];
        [imgView addSubview:bgView];
        
        titeLabel.center = bgView.center;
        imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hotImgClick:)];
        [imgView addGestureRecognizer:tap];
        [hotView addSubview:imgView];
    }
    // 查看所有圈子
    UIView *moreBtn = [[UIView alloc]initWithFrame:CGRectMake(10, itemHeight+30, itemWidth*4+20, 50)];
    moreBtn.backgroundColor = [UIColor whiteColor];
    UILabel *moreLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, itemWidth*3, 30)];
    moreLabel.text = @"查看所有圈子";
    moreLabel.textColor = TextGrayColor;
    [moreBtn addSubview:moreLabel];
    UIImageView *moreImgView = [[UIImageView alloc]initWithFrame:CGRectMake(itemWidth*4, 15, 10, 20)];
    moreImgView.image = [UIImage imageNamed:@"right_row"];
    [moreBtn addSubview:moreImgView];
    moreBtn.userInteractionEnabled = YES;
    UITapGestureRecognizer *moreTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreAction)];
    [moreBtn addGestureRecognizer:moreTap];
    [hotView addSubview:moreBtn];
    
    [headView addSubview:hotView];
    
    _tableView.tableHeaderView = headView;
}
- (void)hotImgClick:(UITapGestureRecognizer *)sender{
    NSString *imgName = @"";
    switch (sender.view.tag) {
        case 3100:
            imgName = @"信仰";
            break;
        case 3101:
            imgName = @"摄影";
            break;
        case 3102:
            imgName = @"旅游";
            break;
        case 3103:
            imgName = @"8090";
            break;
            
        default:
            break;
    }
    NSLog(@"sender=%ld=%@",sender.view.tag, imgName);
}
- (void)moreAction{
    NSLog(@"查看所有圈子");
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunityCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CommunityCell" owner:self options:nil]firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CommunityModel *model = _dataModel[indexPath.row];
    NSLog(@"_dataModel=%@\n\nmodel=%@",_dataModel, model);
    cell.comModel = model;

    cell.heartClick = ^(BOOL heart){
        NSLog(@"💓否？%d",heart);
    };
    cell.commonClick = ^(){
        NSLog(@"评论评论");
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    CommunityModel *comModel = _dataModel[indexPath.row];
    CGFloat labelWidth = WIDTH*3/5.0;
    CGFloat sendLabelHeight = [self textHeightFromeMode:comModel.senderInfo labelWidth:labelWidth];

    CGFloat imgHeight = (labelWidth-20)/3.0;
    CGFloat imgViewHeight = 0;
    if (comModel.imgArr.count == 0) {
        imgViewHeight = 0;
    } else if ((comModel.imgArr.count > 0) && (comModel.imgArr.count <= 3)){
        imgViewHeight = imgHeight+60;
    } else if ((comModel.imgArr.count > 3) && (comModel.imgArr.count <= 6)){
        imgViewHeight = imgHeight*2+50;
    } else {
        imgViewHeight = imgHeight*3+40;
    }

    NSString *nameStr = @"";
    for (int i=0; i<comModel.nameArr.count; i++) {
        NSString *temStr = [NSString stringWithFormat:@"%@、",comModel.nameArr[i]];
        nameStr = [NSString stringWithFormat:@"%@%@",nameStr,temStr];
    }
    NSString *nextStr = [NSString stringWithFormat:@"等 %ld 人觉得很赞。",comModel.nameArr.count];
    NSString *receiveStr = [NSString stringWithFormat:@"%@%@",nameStr,nextStr];
    CGFloat receiveViewHeight = [self textHeightFromeMode:receiveStr labelWidth:labelWidth];

    return 40+sendLabelHeight+imgViewHeight+40+receiveViewHeight+10;
}
// 返回 label 高度
- (CGFloat)textHeightFromeMode:(NSString *)text labelWidth:(CGFloat)labelWidth{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(labelWidth, 500) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} context:nil];
    
    return rect.size.height;
}
@end
