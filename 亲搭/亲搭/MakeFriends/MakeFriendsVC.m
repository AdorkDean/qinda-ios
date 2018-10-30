//
//  MakeFriendsVC.m
//  亲搭
///
//  Created by KFZXSHANGJQ on 2018/10/11.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import "MakeFriendsVC.h"
#import "MakeFriendsCell.h"

@interface MakeFriendsVC ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)UILabel *todyMarriage;
@property(strong,nonatomic)UILabel *myMarriage;
@property(strong,nonatomic)UILabel *receiveMarriage;
@property(strong,nonatomic)UILabel *marriageRank;

@property(strong,nonatomic)UIImageView *marrySortImg;
@property(strong,nonatomic)UIImageView *distanceSortImg;
@property(strong,nonatomic)UILabel *marryLabel;
@property(strong,nonatomic)UILabel *distanceLabel;

@property(strong,nonatomic)UIImageView *btnImg;
@property(strong,nonatomic)UILabel *btnLabel;
@end

@implementation MakeFriendsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.view.backgroundColor = DFTColor(240, 240, 240);
    _tableView.backgroundColor = DFTColor(240, 240, 240);
    [self.view addSubview:_tableView];
    
    
    [self creatUI];
}

- (void)creatUI{
    CGFloat itemWidth = (WIDTH-20)/4.0;
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, itemWidth*4, itemWidth+120)];
    headView.backgroundColor = DFTColor(244, 244, 244);
    // 副标题
    _todyMarriage = [self creatSubTieleLabel];
    _myMarriage = [self creatSubTieleLabel];
    _receiveMarriage = [self creatSubTieleLabel];
    _marriageRank = [self creatSubTieleLabel];
    
    // 头部四个按钮
    UIView *todyMarriageView = [self craetBtnWidthFrame:CGRectMake(10, 0, itemWidth, itemWidth) action:@selector(todyMarriageAction) icon:@"todyMarriage" title:@"今日征婚" subTitleLabel:_todyMarriage];
    [headView addSubview:todyMarriageView];
    
    UIView *myMarriageView = [self craetBtnWidthFrame:CGRectMake(CGRectGetMaxX(todyMarriageView.frame), 0, itemWidth, itemWidth) action:@selector(myMarriageAction) icon:@"myMarriage" title:@"我的征婚" subTitleLabel:_myMarriage];
    [headView addSubview:myMarriageView];
    
    UIView *receiveMarriageView = [self craetBtnWidthFrame:CGRectMake(CGRectGetMaxX(myMarriageView.frame), 0, itemWidth, itemWidth) action:@selector(receiveMarriageAction) icon:@"receiveMarriage" title:@"对我征婚" subTitleLabel:_receiveMarriage];
    [headView addSubview:receiveMarriageView];
    
    UIView *marriageRankView = [self craetBtnWidthFrame:CGRectMake(CGRectGetMaxX(receiveMarriageView.frame), 0, itemWidth, itemWidth) action:@selector(marriageAction) icon:@"marriageRank" title:@"排行榜" subTitleLabel:_marriageRank];
    [headView addSubview:marriageRankView];
    
    _todyMarriage.text = @"(1/3次)";
    _myMarriage.text = @"2次征婚";
    _receiveMarriage.text = @"1人对我征婚";
    _marriageRank.text = @"查看排行";

    // 头视图中部广播
    UIView *broadcastView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(marriageRankView.frame)+10, itemWidth*4, 50)];
    broadcastView.backgroundColor = [UIColor whiteColor];
    broadcastView.layer.borderWidth = 1;
    broadcastView.layer.borderColor = BorderColor;
    broadcastView.layer.cornerRadius = 2;
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [broadcastView addSubview:leftView];
    
    UIImageView *broadcastImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    broadcastImg.image = [UIImage imageNamed:@"broadcast"];
    [broadcastView addSubview:broadcastImg];
    broadcastImg.center = leftView.center;

    [headView addSubview:broadcastView];
    
    // 头视图 底部筛选区域
    UIView *filterView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(broadcastView.frame)+10, itemWidth*4, 50)];
    UIView *fileterleftView = [self creatTopNavigationViewWidthFrame:CGRectMake(0, 0, itemWidth*2, 50)];
    
    [filterView addSubview:fileterleftView];
    
    UIView *fileterRightView = [[UIView alloc]initWithFrame:CGRectMake(itemWidth*2, 0, itemWidth*2, 50)];
    fileterRightView.backgroundColor = [UIColor whiteColor];
    UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(itemWidth+10, 0, itemWidth-10, 50)];

    _btnImg = [[UIImageView alloc]initWithFrame:CGRectMake(itemWidth/5.0-5, (50-itemWidth/4.375)/2.0, itemWidth/4.375, itemWidth/4.375)];
    _btnImg.image = [UIImage imageNamed:@"sift"];
    [btnView addSubview:_btnImg];
    
    _btnLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_btnImg.frame), 0, itemWidth/1.6-5, 50)];
    _btnLabel.text = @"筛选";
    _btnLabel.textColor = TextGrayColor;
    [btnView addSubview:_btnLabel];
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, itemWidth-10, 50)];
    [rightBtn addTarget:self action:@selector(siftAction) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:rightBtn];

    [fileterRightView addSubview:btnView];
    
    [filterView addSubview:fileterRightView];
    
    [headView addSubview:filterView];
    
    _tableView.tableHeaderView = headView;
}
#pragma 自定义头部按钮视图
- (UIView *)craetBtnWidthFrame:(CGRect)frame action:(nullable SEL)action icon:(NSString *)icon title:(NSString *)title subTitleLabel:(UILabel *)subTitleLabel{
    CGFloat btnWidth = frame.size.width;
    CGFloat btnHeight = frame.size.height;
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    // 小图标
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake((btnWidth-btnWidth/3.4)/2.0, (btnHeight/2.0-btnWidth/3.4)-5, btnWidth/3.4, btnWidth/3.4)];
    imgView.image = [UIImage imageNamed:icon];
    // 主标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imgView.frame)+5, btnWidth-20, btnHeight/4)];
    titleLabel.text = title;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:btnWidth*6/33];
    titleLabel.textColor = DFTColor(156, 156, 156);
    [view addSubview:imgView];
    [view addSubview:titleLabel];
    [view addSubview:subTitleLabel];
    
    UITapGestureRecognizer *itemTap=[[UITapGestureRecognizer alloc]initWithTarget:self action: action];
    [view addGestureRecognizer:itemTap];
    view.userInteractionEnabled = YES;
    
    
    view.layer.borderColor = BorderColor;
    view.layer.borderWidth = 0.5;

    return view;
}

- (UILabel *)creatSubTieleLabel{
    CGFloat itemWidth = (WIDTH-20)/4.0;
    UILabel *subTieleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, itemWidth*3/4, itemWidth-20, itemWidth/4)];
    subTieleLabel.textAlignment = NSTextAlignmentCenter;
    subTieleLabel.adjustsFontSizeToFitWidth = YES;
    subTieleLabel.font = [UIFont systemFontOfSize:itemWidth*5/33];
    subTieleLabel.textColor = DFTColor(200, 200, 200);

    return subTieleLabel;
}

- (UIView *)creatTopNavigationViewWidthFrame:(CGRect)frame{
    CGFloat itemWidth = frame.size.width/2.0;
    UIView *cotainerView = [[UIView alloc]initWithFrame:frame];
    cotainerView.backgroundColor = [UIColor whiteColor];
    UIView *marryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, itemWidth, 50)];
    _marrySortImg = [[UIImageView alloc]initWithFrame:CGRectMake(itemWidth/5.8, (50-itemWidth/4.375)/2.0, itemWidth/4.375, itemWidth/4.375)];
    _marryLabel = [[UILabel alloc]initWithFrame:CGRectMake(itemWidth/5.8+(itemWidth/4.375)+5, 0, itemWidth/1.6, 50)];
    [marryView addSubview:_marrySortImg];
    [marryView addSubview:_marryLabel];
    UITapGestureRecognizer *itemMarryTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBarLabel:)];
    marryView.tag = 3000;
    [marryView addGestureRecognizer:itemMarryTap];
    [cotainerView addSubview:marryView];
    
    UIView *distanceView = [[UIView alloc]initWithFrame:CGRectMake(itemWidth, 0, itemWidth, 50)];
    _distanceSortImg = [[UIImageView alloc]initWithFrame:CGRectMake(itemWidth/5.8, (50-itemWidth/4.375)/2.0, itemWidth/4.375, itemWidth/4.375)];
    _distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(itemWidth/5.8+(itemWidth/4.375)+5, 0, itemWidth/1.6, 50)];
    [distanceView addSubview:_distanceSortImg];
    [distanceView addSubview:_distanceLabel];
    UITapGestureRecognizer *itemDistanceTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBarLabel:)];
    distanceView.tag = 3001;
    [distanceView addGestureRecognizer:itemDistanceTap];
    [cotainerView addSubview:distanceView];

    _marrySortImg.image = [UIImage imageNamed:@"marrysort_icon_click"];
    _distanceSortImg.image = [UIImage imageNamed:@"distancesort_icon"];
    _marryLabel.text = @"按匹配";
    _distanceLabel.text = @"按距离";
    _marryLabel.font = [UIFont systemFontOfSize:itemWidth/5.8];
    _distanceLabel.font = [UIFont systemFontOfSize:itemWidth/5.8];
    _marryLabel.textColor = MainColor;
    _distanceLabel.textColor = TextGrayColor;
    
    return cotainerView;
}
- (void)clickBarLabel:(UITapGestureRecognizer *)sender{
    NSUInteger itemIndex = sender.view.tag-3000;
    if (itemIndex == 0) {
        _marrySortImg.image = [UIImage imageNamed:@"marrysort_icon_click"];
        _distanceSortImg.image = [UIImage imageNamed:@"distancesort_icon"];
        _marryLabel.textColor = MainColor;
        _distanceLabel.textColor = TextGrayColor;
    } else {
        _marrySortImg.image = [UIImage imageNamed:@"marrysort_icon"];
        _distanceSortImg.image = [UIImage imageNamed:@"distancesort_icon_click"];
        _marryLabel.textColor = TextGrayColor;
        _distanceLabel.textColor = MainColor;
    }
}
- (void)todyMarriageAction{
    NSLog(@"今日征婚");
    _todyMarriage.text = @"(2/3次)";
    
}

- (void)myMarriageAction{
    
    NSLog(@"我的征婚");
}

- (void)receiveMarriageAction{
    NSLog(@"对我征婚");
}

- (void)marriageAction{
    
    NSLog(@"排行榜");
}

- (void)siftAction{
    NSLog(@"筛选筛选");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MakeFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MakeFriendsCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MakeFriendsCell" owner:self options:nil]firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }


    
    cell.heartClick = ^(BOOL heart){
        NSLog(@"💓否？%d",heart);
    };
    cell.commonClick = ^(){
        NSLog(@"评论评论");
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return WIDTH+55;
}
@end
