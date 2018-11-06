
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
@property(strong,nonatomic)UIImageView *zhenghunImgView;
@property(strong,nonatomic)UIImageView *heartImgView;
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
    [self drowPictureView];
    [self drawFooterView];
}
- (void)drowPictureView{
    UIView *pictureView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, WIDTH-20, (WIDTH-20)/3.64+6)];
    pictureView.layer.cornerRadius = 3;
    pictureView.backgroundColor = [UIColor whiteColor];
    [_containScrollView addSubview:pictureView];
    // 头像
    UIImageView *headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(3, 3, (WIDTH-20)/3.64, (WIDTH-20)/3.64)];
    headerImgView.image = [UIImage imageNamed:@"rank_bg"];
    headerImgView.layer.masksToBounds = YES;
    headerImgView.layer.cornerRadius = 5;
    [pictureView addSubview:headerImgView];
    // ... 按钮
    CGFloat itemWidth = (WIDTH-(WIDTH-20)/3.64-73)/4.0;
    UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-60, 10, 30, 15)];
    [moreBtn setImage:[UIImage imageNamed:@"Shape"] forState:UIControlStateNormal];
    [pictureView addSubview:moreBtn];
    
//    UIImageView *moreImgView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-80-60, 10, 50, 20)];
//    moreImgView.image = [UIImage imageNamed:@"Shape"];
//    [pictureView addSubview:moreImgView];
    

    
    NSMutableArray *itemImgNameArr = @[@"rank_bg",@"rank_bg",@"rank_bg",@"rank_bg",@"rank_bg",@"rank_bg"].mutableCopy;
    // 绘制item小图片滚动区域
    UIScrollView *itemScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headerImgView.frame), (WIDTH-20)/3.64-itemWidth, WIDTH-20-CGRectGetMaxX(headerImgView.frame), itemWidth+6)];
    itemScrollView.contentSize = CGSizeMake((itemWidth+10)*itemImgNameArr.count+10, itemWidth+6);
    itemScrollView.delegate = self;
    itemScrollView.showsHorizontalScrollIndicator = NO;
    [pictureView addSubview:itemScrollView];
//    itemScrollView.backgroundColor = [UIColor redColor];
    // 添加item小图片
    for (int i = 0; i < itemImgNameArr.count; i++) {
        UIImageView *itemImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10+(itemWidth+10)*i, 3, itemWidth, itemWidth)];
        itemImgView.image = [UIImage imageNamed:itemImgNameArr[i]];
        itemImgView.layer.masksToBounds = YES;
        itemImgView.layer.cornerRadius = 5;
        [itemScrollView addSubview:itemImgView];
    }
    
}
- (void)drawFooterView{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-HEIGHT/14.2, WIDTH, HEIGHT/14.2)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    // 征婚按钮
    UIView *zhenghunView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/2.0-1, HEIGHT/14.2)];
    // 文字宽度
    CGFloat leftWith = [HXGetLabelWidthOrHeight getWidthWithText:@"征婚" height:HEIGHT/14.2 font:17];
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, leftWith+30, HEIGHT/14.2)];
    // 图片
    _zhenghunImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (HEIGHT/14.2-25)/2.0, 25, 25)];
    _zhenghunImgView.image = [UIImage imageNamed:@"zhenghun_selected"];
    [leftView addSubview:_zhenghunImgView];
    // 文字
    _zhenghunLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_zhenghunImgView.frame)+5, 0, leftWith, HEIGHT/14.2)];
    _zhenghunLabel.text = @"征婚";
    _zhenghunLabel.textColor = MainColor;
    [leftView addSubview:_zhenghunLabel];
    // 中心对其
    leftView.center = zhenghunView.center;
    [zhenghunView addSubview:leftView];
    // 征婚点击手势
    UITapGestureRecognizer *zhanghunTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectFooterBtn:)];
    zhenghunView.tag = 3500;
    [zhenghunView addGestureRecognizer:zhanghunTap];
    
    // 分割线
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(zhenghunView.frame), 0, 2, HEIGHT/14.2)];
    line.backgroundColor = DFTColor(240, 240, 240);
    
    // 心动按钮
    UIView *heartHeightView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(line.frame), 0, WIDTH/2.0-1, HEIGHT/14.2)];
    // 文字宽度
    CGFloat rightWith = [HXGetLabelWidthOrHeight getWidthWithText:@"心动" height:HEIGHT/14.2 font:17];
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake((WIDTH/2.0-31-rightWith)/2.0, 0, rightWith+30, HEIGHT/14.2)];
    // 心动图片
    _heartImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (HEIGHT/14.2-25)/2.0, 25, 25)];
    _heartImgView.image = [UIImage imageNamed:@"heartbeat_normal"];
    [rightView addSubview:_heartImgView];
    // 文字
    _heartHeightLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_heartImgView.frame)+5, 0, rightWith, HEIGHT/14.2)];
    _heartHeightLabel.text = @"心动";
    _heartHeightLabel.textColor = TextGrayColor;
    [rightView addSubview:_heartHeightLabel];
    [heartHeightView addSubview:rightView];
    // 心动点击手势
    UITapGestureRecognizer *heartTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectFooterBtn:)];
    heartHeightView.tag = 3501;
    [heartHeightView addGestureRecognizer:heartTap];
    
    [footerView addSubview:zhenghunView];
    [footerView addSubview:line];
    [footerView addSubview:heartHeightView];
    
    [self.view addSubview:footerView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)selectFooterBtn:(UITapGestureRecognizer *)tap{
    if (tap.view.tag == 3500) {
        _zhenghunImgView.image = [UIImage imageNamed:@"zhenghun_selected"];
        _zhenghunLabel.textColor = MainColor;
        _heartImgView.image = [UIImage imageNamed:@"heartbeat_normal"];
        _heartHeightLabel.textColor = TextGrayColor;
    } else {
        _zhenghunImgView.image = [UIImage imageNamed:@"zhenghun_no_selected"];
        _zhenghunLabel.textColor = TextGrayColor;
        _heartImgView.image = [UIImage imageNamed:@"heartbeat_highlighted"];
        _heartHeightLabel.textColor = MainColor;
    }
}


@end
