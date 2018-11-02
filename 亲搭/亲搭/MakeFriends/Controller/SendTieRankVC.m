//
//  SendTieRankVC.m
//  亲搭
//
//  Created by KFZXSHANGJQ on 2018/11/2.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import "SendTieRankVC.h"
#import "RankModel.h"
#import "RankCell.h"
@interface SendTieRankVC ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic) UITableView *tableView;
@property(strong,nonatomic) NSMutableArray *dataArr;
@end

@implementation SendTieRankVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"排行榜";
    UIButton *leftBtnView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [leftBtnView setBackgroundImage:[UIImage imageNamed:@"left-back"] forState:UIControlStateNormal];
    [leftBtnView addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtnView];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    self.view.backgroundColor = DFTColor(240, 240, 240);
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-(WIDTH/6.0+30)) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.view.backgroundColor = DFTColor(240, 240, 240);
    _tableView.backgroundColor = DFTColor(240, 240, 240);
    [self.view addSubview:_tableView];
    _dataArr = [NSMutableArray array];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *locationArr = @[@"北京",@"河北",@"河南",@"西安",@"云南"];
    for (int i = 0; i<5; i++) {
        dict = @{ @"name":[NSString stringWithFormat:@"小不点_%d",i+1],
                  @"headerImg":@"header",
                  @"headerBg":@"rank_bg",
                  @"rankNum":[NSString stringWithFormat:@"%d",i+1],
                  @"location":locationArr[i],
                  @"sex": i%2==0 ? @"man" : @"woman",
                  @"sumInfo":[NSString stringWithFormat:@"发帖 %d 次",500-i]
                  }.mutableCopy;
        RankModel *model = [[RankModel alloc]initWithDictionary:dict];
        
        [_dataArr addObject:model];
        
        NSLog(@"data=====%@",_dataArr);
    }
    
    
    [self creatUI];
    
}

- (void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)creatUI{
    CGFloat imgWidth = WIDTH/6.0;
    
    // 头部视图
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, (WIDTH-20)/1.8)];
    headerView.backgroundColor = DFTColor(240, 240, 240);
    // 头像背景图
    RankModel *model = _dataArr[0];
    UIImageView *headerBgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, WIDTH-20, (WIDTH-20)/1.8)];
    headerBgImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",model.headerBg]];
    [headerView addSubview:headerBgImgView];
    // 文字 label 宽度
    CGFloat labelWidth = [HXGetLabelWidthOrHeight getWidthWithText:@"占领了封面" height:25 font:14];
    // 头像图
    UIImageView *headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake((WIDTH-55-labelWidth)/2.0-2, 5, 30, 30)];
    headerImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",model.headerImg]];
    headerImgView.layer.borderWidth = 2;
    headerImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    headerImgView.layer.masksToBounds = YES;
    headerImgView.layer.cornerRadius = 15;
    [headerBgImgView addSubview:headerImgView];
    // 文字
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headerImgView.frame)+5, 5, labelWidth, 30)];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.text = @"占领了封面";
    headerLabel.font = [UIFont systemFontOfSize:14];
    [headerBgImgView addSubview:headerLabel];
    
    _tableView.tableHeaderView = headerView;
    
    // 底部 固定
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-(WIDTH/6.0+30), WIDTH, (WIDTH/6.0+30))];
    footerView.backgroundColor = DFTColor(250, 250, 250);
    // 更新提示
    UILabel *footLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    footLabel.text = @"排行榜每日 23：00 点进行更新";
    footLabel.textColor = TextGrayColor;
    footLabel.textAlignment = NSTextAlignmentCenter;
    footLabel.font = [UIFont systemFontOfSize:13];
    [footerView addSubview:footLabel];
    // 用户排名
    UIView *userView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, imgWidth+10)];
    userView.backgroundColor = MainColor;
    
    UILabel *userLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, (imgWidth+10)/2.0-15, 30, 30)];
    userLabel.textColor = [UIColor whiteColor];
    userLabel.text = @"我";
    [userView addSubview:userLabel];
    // 用户头像
    UIImageView *userImgView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userLabel.frame)+5, 5, imgWidth, imgWidth)];
    userImgView.image = [UIImage imageNamed:@"header"];
    userImgView.layer.masksToBounds = YES;
    userImgView.layer.cornerRadius = imgWidth/2.0;
    [userView addSubview:userImgView];
    // 排名信息
    UILabel *rankLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userImgView.frame)+20, (imgWidth+10)/2.0-15, WIDTH-CGRectGetMaxX(userImgView.frame)-20, 30)];
    rankLabel.textColor = [UIColor whiteColor];
    rankLabel.text = @"排名千里之外！";
    [userView addSubview:rankLabel];
    
    
    [footerView addSubview:userView];
    [self.view addSubview:footerView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RankCellIdentified"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"RankCell" owner:self options:nil]firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    RankModel *model = _dataArr[indexPath.row];
    cell.model = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return WIDTH/6.0+20;
}


@end
