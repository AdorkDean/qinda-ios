//
//  HXLostPassWordVC.m
//  亲搭
//
//  Created by KFZXSHANGJQ on 2018/10/19.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import "HXLostPassWordVC.h"

@interface HXLostPassWordVC ()<UITextFieldDelegate>
{
    NSInteger _count;
}
@property(nonatomic,strong)UIScrollView *containScrollView;

@property(nonatomic,strong)UITextField *phoneTextFiled;// 电话输入框
@property(nonatomic,strong)UITextField *checkCodeTextFiled;// 验证码输入框
@property(nonatomic,strong)UITextField *setPassWordTextFiledOne;// 邀请码输入框
@property(nonatomic,strong)UITextField *setPassWordTextFiledTwo;// 设置密码输入框

@property(nonatomic,strong)UIButton *codeBtn;// 获取验证码按钮
@end

@implementation HXLostPassWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = DFTColor(234, 234, 234);
    self.navigationItem.title = @"找回密码";
    // 设置返回按钮
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

    // 绘图
    [self creatView];
}


- (void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)creatView{
    _codeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, (WIDTH-20)/4, 35)];
    _codeBtn.backgroundColor = DFTColor(230, 230, 230);
    [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _codeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    _codeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _codeBtn.layer.borderColor = DFTColor(230, 230, 230).CGColor;
    _codeBtn.layer.borderWidth = 1;
    _codeBtn.layer.cornerRadius = 5;
    [_codeBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [_codeBtn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    
    // 输入区域
    _phoneTextFiled = [self frame:CGRectMake(10, 64, WIDTH-20, 50) placeholder:@"输入您的手机号" leftText:@"手机号" rightView:_codeBtn];

    _checkCodeTextFiled = [self frame:CGRectMake(10, CGRectGetMaxY(_phoneTextFiled.frame)-1, WIDTH-20, 50) placeholder:@"输入您的验证码" leftText:@"验证码" rightView:nil];
    
    _setPassWordTextFiledOne = [self frame:CGRectMake(10, CGRectGetMaxY(_checkCodeTextFiled.frame)-1, WIDTH-20, 50) placeholder:@"输入您的新密码" leftText:@"设置密码" rightView:nil];
    
    _setPassWordTextFiledTwo = [self frame:CGRectMake(10, CGRectGetMaxY(_setPassWordTextFiledOne.frame)-1, WIDTH-20, 50) placeholder:@"输入您的新密码" leftText:@"设置密码" rightView:nil];

    [self.view addSubview:_phoneTextFiled];
    [self.view addSubview:_checkCodeTextFiled];
    [self.view addSubview:_setPassWordTextFiledOne];
    [self.view addSubview:_setPassWordTextFiledTwo];
    // 提交按钮
    CGFloat loginBtnWidth = (WIDTH-60)/2.0;
    UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(_setPassWordTextFiledTwo.frame)+10, loginBtnWidth*2, 40)];
    submitBtn.layer.borderColor = MainColor.CGColor;
    submitBtn.layer.borderWidth = 1;
    submitBtn.layer.cornerRadius = 5;
    submitBtn.backgroundColor = MainColor;
    [submitBtn setTitle: @"提交" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [submitBtn setTitleColor:DFTColor(255, 255, 255) forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    

}
#pragma 自定义 TextFiled
- (UITextField *)frame:(CGRect)frame placeholder:(NSString *)placeholder leftText:(NSString *)leftText rightView:(UIView *)rightView{
    
    UILabel *view = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, frame.size.width/3.5-10, 50)];
    view.text = leftText;
    view.adjustsFontSizeToFitWidth = YES;
    
    UITextField *textFiled = [[UITextField alloc]initWithFrame:frame];
//    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:placeholder attributes:
//                                      @{NSForegroundColorAttributeName:[UIColor redColor]}];
//    textFiled.attributedPlaceholder = attrString;
    textFiled.placeholder = placeholder;
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width/3.2, 50)];
    [leftView addSubview:view];
    textFiled.leftView = leftView;
    
    textFiled.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    textFiled.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textFiled.delegate = self;
    
    UIView *codeView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width/3.2, 50)];
    rightView.center = codeView.center;
    textFiled.rightView = codeView;
    [codeView addSubview: rightView];
    textFiled.rightViewMode = UITextFieldViewModeAlways;
    textFiled.layer.borderColor = DFTColor(230, 230, 230).CGColor;
    textFiled.layer.borderWidth = 1;
    textFiled.layer.cornerRadius = 2;
    textFiled.backgroundColor = [UIColor whiteColor];
    return textFiled;
}
#pragma 获取验证码方法
- (void)getCode{
    // 判断手机号是否正确
    if ((_phoneTextFiled.text.length == 0)||(_phoneTextFiled.text.length < 11)) {
        [MBProgressHUD showError:@"手机号码错误!"];
        
    }else{
        // 执行方法
        [self performSelector:@selector(countClick) withObject:nil];
        // 存贮手机号
        NSString *phone = [NSString stringWithFormat:@"%@",_phoneTextFiled.text];
        // 发送验证码
    }
    
    // 发送获取验证码请求 设置定时器计时
    NSLog(@"_codeBtn");
    
    
}
-(void)countClick
{
    _codeBtn.enabled =NO;
    _count = 60;
    [_codeBtn setTitle:@"60秒后重新发送" forState:UIControlStateDisabled];
    _codeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    // 定时器
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
}
-(void)timerFired:(NSTimer *)timer
{
    if (_count !=1) {
        _count -=1;
        [_codeBtn setTitle:[NSString stringWithFormat:@"%ld秒后重新发送",(long)_count] forState:UIControlStateDisabled];
        _codeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    else
    {
        [timer invalidate];// 关闭定时器
        _codeBtn.enabled = YES;
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _codeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
}


#pragma 提交方法
- (void)submitAction{
    if ((_phoneTextFiled.text.length == 0)||(_phoneTextFiled.text.length < 11)) {
        [MBProgressHUD showError:@"手机号码错误!"];
    }else if (![_setPassWordTextFiledOne.text isEqualToString:_setPassWordTextFiledTwo.text]){
        [MBProgressHUD showError:@"两次输入密码不一致!"];
    }
    NSLog(@"\n手机号=%@\n验证码=%@\n邀请码=%@\n密码=%@",_phoneTextFiled.text,_checkCodeTextFiled.text,_setPassWordTextFiledOne.text,_setPassWordTextFiledTwo.text);
}
@end
