//
//  CommunityVC.m
//  亲搭
//
//  Created by KFZXSHANGJQ on 2018/10/11.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import "CommunityVC.h"
#import "CommunityCell.h"

@interface CommunityVC ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView *tableView;


@end

@implementation CommunityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.view.backgroundColor = DFTColor(240, 240, 240);
    _tableView.backgroundColor = [UIColor yellowColor];//DFTColor(240, 240, 240);
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
    
    
    
//    cell.heartClick = ^(BOOL heart){
//        NSLog(@"💓否？%d",heart);
//    };
//    cell.commonClick = ^(){
//        NSLog(@"评论评论");
//    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return WIDTH+55;
}



@end
