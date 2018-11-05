
//
//  FilterVC.m
//  亲搭
//
//  Created by KFZXSHANGJQ on 2018/11/2.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import "FilterVC.h"
#import "FilePickerView.h"


@interface FilterVC ()<UIScrollViewDelegate,FilePickerViewDelegate>

@property(nonatomic,strong)UIScrollView *containScrollView;

@property(strong,nonatomic)UILabel *ageLabel;
@property(strong,nonatomic)UILabel *heightLabel;
@property(strong,nonatomic)UILabel *academicLabel;
@property(strong,nonatomic)UILabel *incomeLabel;
@property(strong,nonatomic)UILabel *locationLabel;
@property(strong,nonatomic)FilePickerView *pickerView;
@end

@implementation FilterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"会员筛选";
    UIButton *leftBtnView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
#ifdef __IPHONE_9_0
    if ([leftBtnView respondsToSelector:@selector(widthAnchor)]) {
        [leftBtnView.widthAnchor constraintEqualToConstant:22].active = YES;
    }
    if ([leftBtnView respondsToSelector:@selector(heightAnchor)]) {
        [leftBtnView.heightAnchor constraintEqualToConstant:22].active = YES;
    }
#endif
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
    _pickerView = [FilePickerView instanceDatePickerView];
    _pickerView.frame = self.view.bounds;
    _pickerView.backgroundColor = HXColorA(0, 0, 0, 0.2);
    _pickerView.delegate = self;
    [self.view addSubview:_pickerView];
    if (sender.tag == 3400) {
        _pickerView.type = 3400;
        _pickerView.title = @"年龄选择";
        _pickerView.dataArray = [NSMutableArray arrayWithObjects:@"不限",@"18岁-27岁",@"28岁-37岁",@"38岁-47岁",@"48岁-57岁",nil];
    } else if (sender.tag == 3401) {
        _pickerView.type = 3401;
        _pickerView.title = @"身高选择";
        _pickerView.dataArray = [NSMutableArray arrayWithObjects:@"不限",@"145cm-154cm",@"145cm-154cm",@"155cm-164cm",@"165cm-174cm",@"175cm-184cm",@"185cm-194cm",@"195cm以上",nil];
    } else if (sender.tag == 3402) {
        _pickerView.type = 3402;
        _pickerView.title = @"学历选择";
        _pickerView.dataArray = [NSMutableArray arrayWithObjects:@"不限",@"博士",@"硕士",@"本科",@"大专",@"高中及以下",nil];
    } else if (sender.tag == 3403) {
        _pickerView.type = 3403;
        _pickerView.title = @"月收入选择";
        _pickerView.dataArray = [NSMutableArray arrayWithObjects:@"不限",@"3000-5000",@"5000-8000",@"8000-10000",@"10000-20000",@"20000以上",nil];
    } else if (sender.tag == 3404) {
        _pickerView.type = 3404;
        _pickerView.title = @"所在地选择";
        _pickerView.dataArray = [NSMutableArray arrayWithObjects:@"不限",@"北京",@"上海",@"广州",@"深圳",@"重庆",@"武汉",@"天津",nil];
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
    __weak typeof(self) weakself = self;
    
    if (weakself.commitValueBlock) {
        //将自己的值传出去，完成传值
        weakself.commitValueBlock(post_dict);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 5;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getSelectData:(NSString *)data type:(NSInteger)type{
    switch (type) {
        case 3400:
            _ageLabel.text = data;
            break;
        case 3401:
            _heightLabel.text = data;
            break;
        case 3402:
            _academicLabel.text = data;
            break;
        case 3403:
            _incomeLabel.text = data;
            break;
        case 3404:
            _locationLabel.text = data;
            break;
        default:
            break;
    }
    NSLog(@"data = %@ =%ld",data,type);
}
@end
