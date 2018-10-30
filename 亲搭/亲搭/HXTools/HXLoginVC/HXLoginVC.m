//
//  HXLoginVC.m
//  亲搭
//
//  Created by KFZXSHANGJQ on 2018/10/12.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import "HXLoginVC.h"
#import "HXLostPassWordVC.h"
#import "HXRegisterVC.h"
#import "HXTabBarController.h"
//宽高设定
#define WIDTH   [UIScreen mainScreen].bounds.size.width
#define HEIGHT  [UIScreen mainScreen].bounds.size.height

//#define DFTColor(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1]
@interface HXLoginVC ()<UITextFieldDelegate>
{
    NSInteger _count;
    NSInteger _loginType;
}
@property(nonatomic,strong)UIImageView *headerImgView;
@property(nonatomic,strong)UISegmentedControl *segControl;


@property(nonatomic,strong)UILabel *phoneLabel;
@property(nonatomic,strong)UILabel *acctLabel;

@property(nonatomic,strong)UIView *phoneLine;
@property(nonatomic,strong)UIView *acctLine;

@property(nonatomic,strong)UIView *phoneLoginView;
@property(nonatomic,strong)UIView *acctLoginView;

@property(nonatomic,strong)UITextField *phoneTextFiled;
@property(nonatomic,strong)UITextField *checkCodeTextFiled;
@property(nonatomic,strong)UIButton *codeBtn;

@property(nonatomic,strong)UITextField *acctTextFiled;
@property(nonatomic,strong)UITextField *passWordTextFiled;


@end

@implementation HXLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"登录";
    UIButton *leftBtnView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [leftBtnView setBackgroundImage:[UIImage imageNamed:@"left-back"] forState:UIControlStateNormal];
    [leftBtnView addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtnView];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    // 添加视图
    [self setUpView];
}

- (void)setUpView{
    CGFloat headerHeight = (HEIGHT-44)/4.0;
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, WIDTH, headerHeight)];
    [self.view addSubview:headerView];
    
    _headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake((WIDTH-80)/2.0, (headerHeight-40)/2.0, 80, 80)];
    _headerImgView.image = [UIImage imageNamed:@"login.jpg"];
    [headerView addSubview:_headerImgView];
    
    UIView *pageBtnView = [[UIView alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(headerView.frame), WIDTH-50, 40)];
    
    CGFloat loginBtnWidth = (WIDTH-50)/2.0;
    
    _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, loginBtnWidth, 39)];
    _phoneLabel.text = @"手机快捷登陆";
    _phoneLabel.textAlignment = NSTextAlignmentCenter;
    _phoneLabel.textColor = MainColor;
    _phoneLine = [[UIView alloc]initWithFrame:CGRectMake(0, 39, loginBtnWidth, 2)];
    _phoneLine.backgroundColor = MainColor;
    _phoneLabel.tag = 1001;
    
    _acctLabel = [[UILabel alloc]initWithFrame:CGRectMake(loginBtnWidth, 0, loginBtnWidth, 39)];
    _acctLabel.text = @"账号密码登陆";
    _acctLabel.textAlignment = NSTextAlignmentCenter;
    _acctLabel.textColor = [UIColor lightGrayColor];
    _acctLine = [[UIView alloc]initWithFrame:CGRectMake(loginBtnWidth, 39, loginBtnWidth, 2)];
    _acctLine.backgroundColor = [UIColor lightGrayColor];
    _acctLabel.tag = 1002;
    
    [pageBtnView addSubview:_phoneLabel];
    [pageBtnView addSubview:_acctLabel];
    [pageBtnView addSubview:_phoneLine];
    [pageBtnView addSubview:_acctLine];
    [self.view addSubview:pageBtnView];
    
    UITapGestureRecognizer *phoneTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changePage:)];
    UITapGestureRecognizer *acctTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changePage:)];
    
    // 添加点击手势
    [_phoneLabel addGestureRecognizer:phoneTap];
    [_acctLabel addGestureRecognizer:acctTap];
    // 打开用户交互
    _phoneLabel.userInteractionEnabled = YES;
    _acctLabel.userInteractionEnabled = YES;
    
    _phoneLoginView = [[UIView alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(pageBtnView.frame), WIDTH-50, 100)];
    _acctLoginView = [[UIView alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(pageBtnView.frame), WIDTH-50, 100)];
    
    [self.view insertSubview:_phoneLoginView atIndex:0];
    _loginType = 1;
    
    UIImageView *phoneImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,20, 30)];
    phoneImgView.image = [UIImage imageNamed:@"phone.png"];
    UIImageView *codeImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 17)];
    codeImgView.image = [UIImage imageNamed:@"checkCode.png"];
    UIImageView *acctImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0 , 0, 20, 28)];
    acctImgView.image = [UIImage imageNamed:@"acct.png"];
    UIImageView *passWordImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 28)];
    passWordImgView.image = [UIImage imageNamed:@"passWord.png"];
    
    // 手机号登录-手机号 TextFiled
    _phoneTextFiled = [self frame:CGRectMake(0, 0, _phoneLoginView.frame.size.width, _phoneLoginView.frame.size.height/2) placeholder:@"请输入手机号" leftView:phoneImgView];
    _phoneTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    // 手机号登录-验证码 TextFiled
    _checkCodeTextFiled = [self frame:CGRectMake(0, CGRectGetMaxY(_phoneTextFiled.frame), _phoneLoginView.frame.size.width, _phoneLoginView.frame.size.height/2) placeholder:@"请输入验证码" leftView:codeImgView];
    _codeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _phoneLoginView.frame.size.width/3.5, 35)];
    _codeBtn.backgroundColor = DFTColor(230, 230, 230);
    [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _codeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    _codeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _codeBtn.layer.borderColor = DFTColor(230, 230, 230).CGColor;
    _codeBtn.layer.borderWidth = 1;
    _codeBtn.layer.cornerRadius = 5;
    [_codeBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [_codeBtn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    UIView *codeView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _phoneLoginView.frame.size.width/3.5, 50)];
    _codeBtn.center = codeView.center;
    [codeView addSubview: _codeBtn];
    _checkCodeTextFiled.rightView = codeView;

    
    _checkCodeTextFiled.rightViewMode = UITextFieldViewModeAlways;
    // 将 TextFiled 添加到手机号登录 View 上
    [_phoneLoginView addSubview:_phoneTextFiled];
    [_phoneLoginView addSubview:_checkCodeTextFiled];
    
    // 账号登录-账号 TextFiled
    _acctTextFiled = [self frame:CGRectMake(0, 0, _acctLoginView.frame.size.width, _acctLoginView.frame.size.height/2) placeholder:@"用户名" leftView: acctImgView];
    // 账号登录-密码 TextFiled
    _passWordTextFiled = [self frame:CGRectMake(0, CGRectGetMaxY(_acctTextFiled.frame), _acctLoginView.frame.size.width, _acctLoginView.frame.size.height/2) placeholder:@"密码" leftView:passWordImgView];
    _passWordTextFiled.secureTextEntry = YES;
    // 将 TextFiled 添加到账号登录 View 上
    [_acctLoginView addSubview:_acctTextFiled];
    [_acctLoginView addSubview:_passWordTextFiled];
    
    // 登录按钮
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(26, CGRectGetMaxY(_phoneLoginView.frame)+30, loginBtnWidth*2-2, 40)];
    loginBtn.layer.borderColor = MainColor.CGColor;
    loginBtn.layer.borderWidth = 1;
    loginBtn.layer.cornerRadius = 5;
    loginBtn.backgroundColor = MainColor;
    [loginBtn setTitle: @"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:22];
//    [loginBtn setTitle:@"登录" forState:UIControlStateHighlighted];
    [loginBtn setTitleColor:DFTColor(255, 255, 255) forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIButton *registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(loginBtn.frame)+15, 100, 30)];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:DFTColor(170, 170, 170) forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    UIButton *lostPassWordBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-120, CGRectGetMaxY(loginBtn.frame)+15, 100, 30)];
    [lostPassWordBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [lostPassWordBtn setTitleColor:DFTColor(170, 170, 170) forState:UIControlStateNormal];
    [lostPassWordBtn addTarget:self action:@selector(lostPassWordAction) forControlEvents:UIControlEventTouchUpInside];
    lostPassWordBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [self.view addSubview:registerBtn];
    [self.view addSubview:lostPassWordBtn];
    
    UIImageView *loginLine = [[UIImageView alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(registerBtn.frame)+40, WIDTH-50, 1)];
    loginLine.image = [UIImage imageNamed:@"heartline"];
    [self.view addSubview:loginLine];
    
    UIImageView *loginHeart = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (WIDTH-50)/16.3, (WIDTH-50)/16.3)];
    loginHeart.image = [UIImage imageNamed:@"heart"];
    loginHeart.center = loginLine.center;
    [self.view addSubview:loginHeart];
    
    UIButton *qqBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(loginHeart.frame)+40, 25, 30)];
    [qqBtn setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    [qqBtn addTarget:self action:@selector(qqLoginAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *weixinBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-90, CGRectGetMaxY(loginHeart.frame)+43, 30, 25)];
    [weixinBtn setImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
    [weixinBtn addTarget:self action:@selector(weixinLoginAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:qqBtn];
    [self.view addSubview:weixinBtn];
    
}
#pragma 初始化自定义输入框
- (UITextField *)frame:(CGRect)frame placeholder:(NSString *)placeholder leftView:(UIView *)leftView{
    
    UITextField *textFiled = [[UITextField alloc]initWithFrame:frame];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:placeholder attributes:
                                      @{NSForegroundColorAttributeName:[UIColor redColor]
                                        }];
    textFiled.attributedPlaceholder = attrString;
    textFiled.placeholder = placeholder;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 50)];
    textFiled.leftView = view;
    leftView.center = view.center;
    [view addSubview:leftView];
    textFiled.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    textFiled.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textFiled.delegate = self;

    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 49, frame.size.width, 1)];
    bottomLine.backgroundColor = MainColor;
    [textFiled addSubview:bottomLine];
    
    return textFiled;
}
// 手机-账号登录方式切换
- (void)changePage:(UITapGestureRecognizer *)gesture{

    if (gesture.view.tag == 1001) {
        _loginType = 1;
        _phoneLabel.textColor = MainColor;
        _phoneLine.backgroundColor = MainColor;
        _acctLabel.textColor = [UIColor lightGrayColor];
        _acctLine.backgroundColor = [UIColor lightGrayColor];
        
        [_acctLoginView removeFromSuperview];
        [self.view insertSubview:_phoneLoginView atIndex:0];
        
    } else {
        _loginType = 2;
        _phoneLabel.textColor = [UIColor lightGrayColor];
        _phoneLine.backgroundColor = [UIColor lightGrayColor];
        
        _acctLabel.textColor = MainColor;
        _acctLine.backgroundColor = MainColor;
        [_phoneLoginView removeFromSuperview];
        [self.view insertSubview:_acctLoginView atIndex:0];
        
    }
    
//    NSLog(@"aasads%ld",gesture.view.tag);
}
- (void)getCode{
    // 判断手机号是否正确
    if ((_phoneTextFiled.text.length == 0)||(_phoneTextFiled.text.length < 11)) {
        [MBProgressHUD showError:@"手机号码错误!"];
        
    }else{
        // 执行方法
        [self performSelector:@selector(countClick) withObject:nil];
        // 存贮手机号
//        NSString *phone = [NSString stringWithFormat:@"%@",_phoneTextFiled.text];
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
- (void)loginAction{
    if (_loginType == 1) {
        NSLog(@"手机登录登录");
    } else {
        NSLog(@"账号登录登录");
    }
    
    [self loginSucceed];
}
- (void)registerAction{
    HXRegisterVC *registerVC = [[HXRegisterVC alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
    NSLog(@"注册注册");
}
- (void)lostPassWordAction{
    HXLostPassWordVC *lostVC = [[HXLostPassWordVC alloc]init];
    [self.navigationController pushViewController:lostVC animated:YES];
    NSLog(@"忘记密码？");
}
- (void)qqLoginAction{
    NSLog(@"qq登录");
    
    
    [self loginSucceed];
}
- (void)weixinLoginAction{
    NSLog(@"微信登录");
    
    
    [self loginSucceed];
}
- (void)leftAction{
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loginSucceed{
    // 登陆成功回调
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    HXTabBarController *tab = [[HXTabBarController alloc]init];
    window.rootViewController = tab;
}
@end
