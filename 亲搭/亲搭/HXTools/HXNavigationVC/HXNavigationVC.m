//
//  HXNavigationVC.m
//  亲搭
//
//  Created by KFZXSHANGJQ on 2018/10/12.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import "HXNavigationVC.h"
#define DFTColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface HXNavigationVC ()

@end

@implementation HXNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /**
     *  设置导航栏的颜色
     */
    self.navigationBar.barTintColor = DFTColor(225, 71, 72);
    self.navigationBar.titleTextAttributes=
            @{
              NSForegroundColorAttributeName:[UIColor whiteColor],
              NSFontAttributeName:[UIFont systemFontOfSize:25]
            };
    UIButton *leftBtnView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [leftBtnView setBackgroundImage:[UIImage imageNamed:@"left-back"] forState:UIControlStateNormal];
    [leftBtnView addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtnView];
    self.navigationItem.leftBarButtonItem = leftBtn;
}


- (void)leftAction{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
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
