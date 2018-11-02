
//
//  FilterVC.m
//  亲搭
//
//  Created by KFZXSHANGJQ on 2018/11/2.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import "FilterVC.h"

@interface FilterVC ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *containScrollView;

@property(strong,nonatomic)UILabel *ageLabel;
@property(strong,nonatomic)UILabel *heightLabel;
@property(strong,nonatomic)UILabel *academicLabel;
@property(strong,nonatomic)UILabel *incomeLabel;
@property(strong,nonatomic)UILabel *locationLabel;

@end

@implementation FilterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"会员筛选";
    UIButton *leftBtnView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [leftBtnView setBackgroundImage:[UIImage imageNamed:@"left-back"] forState:UIControlStateNormal];
    [leftBtnView addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtnView];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    self.view.backgroundColor = DFTColor(240, 240, 240);
    
    // 设置内容滚动区域
    _containScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 0, WIDTH-20, HEIGHT)];
    _containScrollView.backgroundColor = DFTColor(234, 234, 234);
    _containScrollView.delegate = self;
    _containScrollView.contentSize = CGSizeMake(WIDTH-20, HEIGHT);
    _containScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_containScrollView];
    
    [self drowUI];
}

- (void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)drowUI{
    _ageLabel = [UILabel new];
    _heightLabel = [UILabel new];
    _academicLabel = [UILabel new];
    _incomeLabel = [UILabel new];
    _locationLabel = [UILabel new];

    UIView *ageItemView = [self creatItemView:CGRectMake(0, 5, WIDTH-20, 50) title:@"年龄" leftImg:@"age_icon" action:@selector(itemAction:) tag:3400 centerLabel:_ageLabel];
    [_containScrollView addSubview:ageItemView];
    
    UIView *heightItemView = [self creatItemView:CGRectMake(0, CGRectGetMaxY(ageItemView.frame)+5, WIDTH-20, 50) title:@"身高" leftImg:@"height_icon" action:@selector(itemAction:) tag:3401 centerLabel:_heightLabel];
    [_containScrollView addSubview:heightItemView];
    
    UIView *academicItemView = [self creatItemView:CGRectMake(0, CGRectGetMaxY(heightItemView.frame)+5, WIDTH-20, 50) title:@"学历" leftImg:@"academic_icon" action:@selector(itemAction:) tag:3402 centerLabel:_academicLabel];
    [_containScrollView addSubview:academicItemView];
    
    UIView *incomeItemView = [self creatItemView:CGRectMake(0, CGRectGetMaxY(academicItemView.frame)+5, WIDTH-20, 50) title:@"月收入" leftImg:@"income_icon" action:@selector(itemAction:) tag:3403 centerLabel:_incomeLabel];
    [_containScrollView addSubview:incomeItemView];
    
    UIView *locationItemView = [self creatItemView:CGRectMake(0, CGRectGetMaxY(incomeItemView.frame)+5, WIDTH-20, 50) title:@"所在地" leftImg:@"location_icon" action:@selector(itemAction:) tag:3404 centerLabel:_locationLabel];
    [_containScrollView addSubview:locationItemView];
    
    
    // 提交按钮
    CGFloat loginBtnWidth = (WIDTH-50)/2.0;
    UIButton *commitBtn = [[UIButton alloc]initWithFrame:CGRectMake(26, CGRectGetMaxY(locationItemView.frame)+20, loginBtnWidth*2-22, 40)];
    commitBtn.layer.borderColor = MainColor.CGColor;
    commitBtn.layer.borderWidth = 1;
    commitBtn.layer.cornerRadius = 5;
    commitBtn.backgroundColor = MainColor;
    [commitBtn setTitle: @"提交" forState:UIControlStateNormal];
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [commitBtn setTitleColor:DFTColor(255, 255, 255) forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    [_containScrollView addSubview:commitBtn];
    
}
- (void)itemAction:(UIButton *)sender{
    NSLog(@"筛选条件%ld",sender.tag);
    if (sender.tag == 3400) {
        _ageLabel.text = @"18岁";
    } else if (sender.tag == 3401) {
        _heightLabel.text = @"175cm";
    } else if (sender.tag == 3402) {
        _academicLabel.text = @"本科";
    } else if (sender.tag == 3403) {
        _incomeLabel.text = @"10-20k";
    } else if (sender.tag == 3404) {
        _locationLabel.text = @"北京";
    }
}
- (void)commitAction{
    NSMutableDictionary *post_dict = [NSMutableDictionary dictionary];
    [post_dict setValue:_ageLabel.text forKey:@"age"];
    [post_dict setValue:_heightLabel.text forKey:@"height"];
    [post_dict setValue:_academicLabel.text forKey:@"academic"];
    [post_dict setValue:_incomeLabel.text forKey:@"income"];
    [post_dict setValue:_locationLabel.text forKey:@"location"];
    
    NSLog(@"提交%@",post_dict);
}
- (UIView *)creatItemView:(CGRect)frame title:(NSString *)title leftImg:(NSString *)leftImg action:(_Nonnull SEL)action tag:(NSInteger)tag centerLabel:(UILabel *)centerLabel{
    CGFloat itemWidth = frame.size.width;
    CGFloat itemHeight = frame.size.height;
    UIView *itemView = [[UIView alloc]initWithFrame:frame];
    itemView.backgroundColor = [UIColor whiteColor];
    itemView.layer.cornerRadius = 3;
    
    UIImageView *leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (itemHeight-25)/2.0, 25, 25)];
    leftImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",leftImg]];
    [itemView addSubview:leftImgView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftImgView.frame)+10, itemHeight/2.0-15, (itemWidth-50)/4.0, 30)];
    titleLabel.text = title;
    [itemView addSubview:titleLabel];
    
    centerLabel.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame)+10, itemHeight/2.0-15, (itemWidth-50)*3/4.0-30, 30);
    [itemView addSubview:centerLabel];
    
    UIImageView *rightImgView = [[UIImageView alloc]initWithFrame:CGRectMake(itemWidth-20, itemHeight/2.0-10, 10, 20)];
    rightImgView.image = [UIImage imageNamed:@"right_row"];
    [itemView addSubview:rightImgView];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, frame.size.width-10, frame.size.height-10)];
    btn.backgroundColor = HXColorA(255, 255, 255, 0);
    btn.tag = tag;
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [itemView addSubview:btn];

    return itemView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
