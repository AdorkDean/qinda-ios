//
//  MarriageRankVC.m
//  亲搭
//
//  Created by KFZXSHANGJQ on 2018/10/31.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import "MarriageRankVC.h"
#import "SendZhenghunRankVC.h"
@interface MarriageRankVC ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *containScrollView;

@end

@implementation MarriageRankVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"排行榜列表";
    UIButton *leftBtnView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [leftBtnView setBackgroundImage:[UIImage imageNamed:@"left-back"] forState:UIControlStateNormal];
    [leftBtnView addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtnView];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.view.backgroundColor = DFTColor(240, 240, 240);
    
    _containScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _containScrollView.backgroundColor = DFTColor(240, 240, 240);
    _containScrollView.delegate = self;
    _containScrollView.contentSize = CGSizeMake(WIDTH, HEIGHT);
    _containScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_containScrollView];

    [self drawUI];
}
- (void)drawUI{
    CGFloat itemWidth = WIDTH-20;
    UIView *sendZhenghunRankItem = [self creatClickItemView:CGRectMake(10, 2, itemWidth, 50) title:@"征婚排行榜" action:@selector(rankAction:) tag:3300];
    [_containScrollView addSubview:sendZhenghunRankItem];
    
    UIView *getZhenghunRankItem = [self creatClickItemView:CGRectMake(10, CGRectGetMaxY(sendZhenghunRankItem.frame)+2, itemWidth, 50) title:@"被征婚排行榜" action:@selector(rankAction:) tag:3301];
    [_containScrollView addSubview:getZhenghunRankItem];

    UIView *heartRankItem = [self creatClickItemView:CGRectMake(10, CGRectGetMaxY(getZhenghunRankItem.frame)+2, itemWidth, 50) title:@"爱心排行榜" action:@selector(rankAction:) tag:3302];
    [_containScrollView addSubview:heartRankItem];

    UIView *sendGiftRankItem = [self creatClickItemView:CGRectMake(10, CGRectGetMaxY(heartRankItem.frame)+2, itemWidth, 50) title:@"送礼排行榜" action:@selector(rankAction:) tag:3303];
    [_containScrollView addSubview:sendGiftRankItem];

    UIView *getGiftzhenghunRankItem = [self creatClickItemView:CGRectMake(10, CGRectGetMaxY(sendGiftRankItem.frame)+2, itemWidth, 50) title:@"收礼排行榜" action:@selector(rankAction:) tag:3304];
    [_containScrollView addSubview:getGiftzhenghunRankItem];

    UIView *sendTieRankItem = [self creatClickItemView:CGRectMake(10, CGRectGetMaxY(getGiftzhenghunRankItem.frame)+2, itemWidth, 50) title:@"发帖排行榜" action:@selector(rankAction:) tag:3305];
    [_containScrollView addSubview:sendTieRankItem];

    UIView *getZanRankItem = [self creatClickItemView:CGRectMake(10, CGRectGetMaxY(sendTieRankItem.frame)+2, itemWidth, 50) title:@"被赞排行榜" action:@selector(rankAction:) tag:3306];
    [_containScrollView addSubview:getZanRankItem];

}
- (void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)creatClickItemView:(CGRect)frame title:(NSString *)title action:(nullable SEL)action tag:(NSInteger)tag{
    UIView *itemView = [[UIView alloc]initWithFrame:frame];
    itemView.backgroundColor = [UIColor whiteColor];
    itemView.layer.cornerRadius=3;
    UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, frame.size.width-40, 30)];
    leftLabel.text = title;
//    leftLabel.textColor = TextGrayColor;
    [itemView addSubview:leftLabel];
    
    UIImageView *rightImgView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftLabel.frame)+10, 15, 10, 20)];
    rightImgView.image = [UIImage imageNamed:@"right_row"];
    [itemView addSubview:rightImgView];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, frame.size.width-10, frame.size.height-10)];
    btn.backgroundColor = HXColorA(255, 255, 255, 0);
    btn.tag = tag;
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [itemView addSubview:btn];
    
    return itemView;
}

- (void)rankAction:(UIButton *)sender{
    if (sender.tag == 3300) {
        SendZhenghunRankVC *sendVC = [SendZhenghunRankVC new];
        [self.navigationController pushViewController:sendVC animated:YES];
    } else if (sender.tag == 3301) {
        
    } else if (sender.tag == 3302) {
        
    } else if (sender.tag == 3303) {
        
    } else if (sender.tag == 3304) {
        
    } else if (sender.tag == 3305) {
        
    } else if (sender.tag == 3306) {
        
    }
    NSLog(@"%ld",(long)sender.tag);
}
@end
