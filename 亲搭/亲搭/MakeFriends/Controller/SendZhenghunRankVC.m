//
//  SendZhenghunRankVC.m
//  亲搭
//
//  Created by KFZXSHANGJQ on 2018/11/1.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import "SendZhenghunRankVC.h"
#import "RankCell.h"
@interface SendZhenghunRankVC ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic) UITableView *tableView;
@end

@implementation SendZhenghunRankVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"排行榜";
    UIButton *leftBtnView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [leftBtnView setBackgroundImage:[UIImage imageNamed:@"left-back"] forState:UIControlStateNormal];
    [leftBtnView addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtnView];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    self.view.backgroundColor = DFTColor(240, 240, 240);
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-(WIDTH/6.0+50)) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.view.backgroundColor = DFTColor(240, 240, 240);
    _tableView.backgroundColor = DFTColor(240, 240, 240);
    [self.view addSubview:_tableView];
    
    
    [self creatUI];
    
}

- (void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)creatUI{
    // 底部
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-(WIDTH/6.0+30), WIDTH, (WIDTH/6.0+30))];
    footerView.backgroundColor = DFTColor(250, 250, 250);
    // 更新提示
    UILabel *footLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    footLabel.text = @"排行榜每日 23：00 点进行更新";
    footLabel.textColor = TextGrayColor;
    footLabel.textAlignment = NSTextAlignmentCenter;
    footLabel.font = [UIFont systemFontOfSize:15];
    [footerView addSubview:footLabel];
    // 用户排名
    CGFloat imgWidth = WIDTH/6.0;
    UIView *userView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, WIDTH, imgWidth+10)];
    userView.backgroundColor = MainColor;
    
    UILabel *userLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, (imgWidth+10)/2.0-15, 30, 30)];
    userLabel.textColor = [UIColor whiteColor];
    userLabel.text = @"我";
    [userView addSubview:userLabel];
    // 用户头像
    UIImageView *userImgView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userLabel.frame)+20, 0, imgWidth, imgWidth)];
    userImgView.image = [UIImage imageNamed:@"header"];
    userImgView.layer.cornerRadius = imgWidth/2.0;
    [userView addSubview:userImgView];
    // 排名信息
    UILabel *rankLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userImgView.frame)+20, (imgWidth)/2.0-15, WIDTH-CGRectGetMaxX(userImgView.frame)-20, 30)];
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
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return WIDTH/6.0+20;
}

@end
