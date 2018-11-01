//
//  ReceiveMarriageVC.m
//  亲搭
//
//  Created by KFZXSHANGJQ on 2018/11/1.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import "ReceiveMarriageVC.h"
#import "ReceiveMarriageCell.h"
@interface ReceiveMarriageVC ()

@end

@implementation ReceiveMarriageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"对我征婚";
    UIButton *leftBtnView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [leftBtnView setBackgroundImage:[UIImage imageNamed:@"left-back"] forState:UIControlStateNormal];
    [leftBtnView addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtnView];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.view.backgroundColor = DFTColor(240, 240, 240);
    
    [self drowUI];
}

- (void)drowUI{
    
}

- (void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 1) {
        return 0;
    }
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReceiveMarriageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReceiveMarriageCellIdentified"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ReceiveMarriageCell" owner:self options:nil]firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return WIDTH/5.0+20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *containView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    containView.backgroundColor = DFTColor(240, 240, 240);
    
    if (section == 0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 0, WIDTH-20, 50)];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 3;
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, WIDTH-40, 30)];
        [view addSubview:titleLabel];
        titleLabel.text = @"已通过征婚请求";
        titleLabel.textColor = [UIColor redColor];
        
        [containView addSubview:view];
    } else if (section == 1) {

    } else {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 0, WIDTH-20, 50)];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 3;
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, WIDTH-40, 30)];
        [view addSubview:titleLabel];
        titleLabel.text = @"未通过征婚请求";
        titleLabel.textColor = TextGrayColor;
        
        [containView addSubview:view];
    }
    
    return containView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 8;
    } else {
        return 51;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点点点");
}
@end
