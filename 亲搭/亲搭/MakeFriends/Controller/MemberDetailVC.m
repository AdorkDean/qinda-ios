
//
//  MemberDetailVC.m
//  亲搭
//
//  Created by  辉 庄 on 2018/11/5.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import "MemberDetailVC.h"

@interface MemberDetailVC ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *containScrollView;
@property(strong,nonatomic)UILabel *zhenghunLabel;
@property(strong,nonatomic)UILabel *heartHeightLabel;
@end

@implementation MemberDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"会员详情";
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
    
    _containScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-HEIGHT/14.2)];
    _containScrollView.backgroundColor = DFTColor(240, 240, 240);
    _containScrollView.delegate = self;
    _containScrollView.contentSize = CGSizeMake(WIDTH, HEIGHT-HEIGHT/14.2);
    _containScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_containScrollView];
    
    [self drawUI];
}
- (void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)drawUI{
    [self drawFooterView];
}
- (void)drawFooterView{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-HEIGHT/14.2, WIDTH, HEIGHT/14.2)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UIView *zhenghunView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/2.0-1, HEIGHT/14.2)];
    CGFloat leftWith = [HXGetLabelWidthOrHeight getWidthWithText:@"征婚" height:22 font:17];
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, leftWith+30, 22)];
    UIImageView *leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2.5, 25, 25)];
    [leftView addSubview:leftImgView];
    _zhenghunLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, leftWith, HEIGHT/14.2)];
    _zhenghunLabel.text = @"征婚";
    _zhenghunLabel.textColor = MainColor;
    [zhenghunView addSubview:_zhenghunLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(zhenghunView.frame), 0, 2, HEIGHT/14.2)];
    line.backgroundColor = DFTColor(240, 240, 240);
    
    UIView *heartHeightView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(line.frame), 0, WIDTH/2.0-1, HEIGHT/14.2)];
    _heartHeightLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [HXGetLabelWidthOrHeight getWidthWithText:@"心动" height:22 font:17], HEIGHT/14.2)];
    _heartHeightLabel.text = @"心动";
    _heartHeightLabel.textColor = TextGrayColor;
    [heartHeightView addSubview:_heartHeightLabel];
    
    [footerView addSubview:zhenghunView];
    [footerView addSubview:line];
    [footerView addSubview:heartHeightView];
    
    [self.view addSubview:footerView];
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
