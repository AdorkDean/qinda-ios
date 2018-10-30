//
//  HXRegisterVC.m
//  亲搭
//
//  Created by KFZXSHANGJQ on 2018/10/22.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import "HXRegisterVC.h"

@interface HXRegisterVC ()<UITextFieldDelegate,UIScrollViewDelegate>
{
    NSInteger _sexType;
    NSInteger _isAlone;
    NSInteger _count;
}
@property(nonatomic,strong)UIScrollView *containScrollView;

@property(nonatomic,strong)UITextField *phoneTextFiled;// 电话输入框
@property(nonatomic,strong)UITextField *checkCodeTextFiled;// 验证码输入框
@property(nonatomic,strong)UITextField *inviteCodeTextFiled;// 邀请码输入框
@property(nonatomic,strong)UITextField *setPassWordTextFiled;// 设置密码输入框
@property(nonatomic,strong)UITextField *nameTextFiled;// 昵称输入框

@property(nonatomic,strong)UIButton *codeBtn;// 获取验证码按钮
@property(nonatomic,strong)UIImageView *sexTypeImg;// 性别 √ 图片
@property(nonatomic,strong)UIImageView *aloneImg;// 单身 √ 图片

@end

@implementation HXRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = DFTColor(234, 234, 234);
    self.navigationItem.title = @"注册";
    // 设置返回按钮
    UIButton *leftBtnView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [leftBtnView setBackgroundImage:[UIImage imageNamed:@"left-back"] forState:UIControlStateNormal];
    [leftBtnView addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtnView];
    self.navigationItem.leftBarButtonItem = leftBtn;
    // 设置内容滚动区域
    _containScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 0, WIDTH-20, HEIGHT)];
    _containScrollView.backgroundColor = DFTColor(234, 234, 234);
    _containScrollView.delegate = self;
    _containScrollView.contentSize = CGSizeMake(WIDTH-20, HEIGHT);
    _containScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_containScrollView];
    
    _sexType = 1;// 默认性别 男
    _isAlone = 1;// 默认单身
    
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
    _phoneTextFiled = [self frame:CGRectMake(0, 0, WIDTH-10, 50) placeholder:@"请输入手机号" leftText:@"手机号" rightView:_codeBtn];
    
    _checkCodeTextFiled = [self frame:CGRectMake(0, CGRectGetMaxY(_phoneTextFiled.frame)-1, WIDTH-10, 50) placeholder:@"输入验证码" leftText:@"验证码" rightView:nil];
    
    _inviteCodeTextFiled = [self frame:CGRectMake(0, CGRectGetMaxY(_checkCodeTextFiled.frame)-1, WIDTH-10, 50) placeholder:@"必须填" leftText:@"邀请码" rightView:nil];
    
    _setPassWordTextFiled = [self frame:CGRectMake(0, CGRectGetMaxY(_inviteCodeTextFiled.frame)-1, WIDTH-10, 50) placeholder:@"输入密码" leftText:@"设置密码" rightView:nil];
    
    _nameTextFiled = [self frame:CGRectMake(0, CGRectGetMaxY(_setPassWordTextFiled.frame)-1, WIDTH-10, 50) placeholder:@"输入昵称" leftText:@"昵称" rightView:nil];
    
    [_containScrollView addSubview:_phoneTextFiled];
    [_containScrollView addSubview:_checkCodeTextFiled];
    [_containScrollView addSubview:_inviteCodeTextFiled];
    [_containScrollView addSubview:_setPassWordTextFiled];
    [_containScrollView addSubview:_nameTextFiled];
    
    // 单选区域
    UIView *sexTypeView = [self creatSelectViewWithTitle:@"性别" itemArr:@[@"男",@"女"] marginLeft:0 marginTop: CGRectGetMaxY(_nameTextFiled.frame)+10 containViewWidth:WIDTH-21 action:@selector(changeSexType:) selectImgType:@"sex"];
    [_containScrollView addSubview:sexTypeView];
    
    UIView *aloneView = [self creatSelectViewWithTitle:@"是否单身" itemArr:@[@"是",@"否"] marginLeft:0 marginTop: CGRectGetMaxY(sexTypeView.frame)+10 containViewWidth:WIDTH-21 action:@selector(changeAlone:) selectImgType:@"alone"];
    [_containScrollView addSubview:aloneView];
    
    // 登录按钮
    CGFloat loginBtnWidth = (WIDTH-50)/2.0;
    UIButton *registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(26, CGRectGetMaxY(aloneView.frame)+10, loginBtnWidth*2-22, 40)];
    registerBtn.layer.borderColor = MainColor.CGColor;
    registerBtn.layer.borderWidth = 1;
    registerBtn.layer.cornerRadius = 5;
    registerBtn.backgroundColor = MainColor;
    [registerBtn setTitle: @"注册" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    //    [loginBtn setTitle:@"登录" forState:UIControlStateHighlighted];
    [registerBtn setTitleColor:DFTColor(255, 255, 255) forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [_containScrollView addSubview:registerBtn];
    
    
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

#pragma 自定义 单选视图
- (UIView *)creatSelectViewWithTitle:(NSString *)title itemArr:(NSArray *)itemArr marginLeft:(CGFloat)marginLeft marginTop:(CGFloat)marginTop containViewWidth:(CGFloat)containViewWidth action:(nullable SEL)action selectImgType:(NSString *)selectImgType{
    UIView *selectView = [[UIView alloc]initWithFrame:CGRectMake(marginLeft, marginTop, containViewWidth, 50*itemArr.count+40)];
    selectView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, containViewWidth-20, 39)];
    titleLabel.text = title;
    titleLabel.textColor = DFTColor(170, 170, 170);
    [selectView addSubview:titleLabel];
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), containViewWidth, 1)];
    bottomLine.backgroundColor = DFTColor(230, 230, 230);
    [selectView addSubview:bottomLine];
    
    for (int i = 0; i < itemArr.count; i++) {
        UILabel *item = [[UILabel alloc]initWithFrame:CGRectMake(10, 40+50*i, containViewWidth-20, 50)];
        item.text = itemArr[i];
        item.userInteractionEnabled = YES;
        if ([selectImgType isEqualToString:@"sex"]) {
            UITapGestureRecognizer *itemTap_sex=[[UITapGestureRecognizer alloc]initWithTarget:self action: action];
            [item addGestureRecognizer:itemTap_sex];
            [selectView addSubview:item];
            item.tag = 1000+i;
            if (i == 0) {
                _sexTypeImg = [[UIImageView alloc]initWithFrame:CGRectMake(containViewWidth-35, 18, 15, 14)];
                _sexTypeImg.image = [UIImage imageNamed:@"ok"];
                [item addSubview:_sexTypeImg];
            }
        } else {
            UITapGestureRecognizer *itemTap=[[UITapGestureRecognizer alloc]initWithTarget:self action: action];
            [item addGestureRecognizer:itemTap];
            [selectView addSubview:item];
            item.tag = 2000+i;
            if (i == 0) {
                _aloneImg = [[UIImageView alloc]initWithFrame:CGRectMake(containViewWidth-35, 18, 15, 14)];
                _aloneImg.image = [UIImage imageNamed:@"ok"];
                [item addSubview:_aloneImg];
            }
        }
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 89+50*i, containViewWidth, 1)];
        line.backgroundColor = DFTColor(230, 230, 230);
        [selectView addSubview:line];
    }
    return selectView;
}
// 性别 回调
- (void)changeSexType:(UITapGestureRecognizer *)gesture{
    
    [_sexTypeImg removeFromSuperview];
    [gesture.view addSubview:_sexTypeImg];
    if (gesture.view.tag == 1000) {
        _sexType = 1;
        NSLog(@"男%ld",_sexType);
    }else{
        _sexType = 0;
        NSLog(@"女%ld",_sexType);
    }
}
// 是否 单身 回调
- (void)changeAlone:(UITapGestureRecognizer *)gesture{
    
    [_aloneImg removeFromSuperview];
    [gesture.view addSubview:_aloneImg];
    if (gesture.view.tag == 2000) {
        _isAlone = 1;
        NSLog(@"单身%ld",_isAlone);
    }else{
        _isAlone = 0;
        NSLog(@"非单身%ld",_isAlone);
    }
}
#pragma 注册方法
- (void)registerAction{
    if ((_phoneTextFiled.text.length == 0)||(_phoneTextFiled.text.length < 11)) {
        [MBProgressHUD showError:@"手机号码错误!"];
    }
    NSString *alonetemp = @"单身";
    NSString *sex = @"男";
    if (_isAlone == 0) {
        alonetemp = @"非单身";
    }
    if (_sexType == 0) {
        sex = @"女";
    }
    NSLog(@"手机号=%@\n验证码=%@\n邀请码=%@\n密码=%@\n昵称=%@\n性别=%@\n单身=%@\n",_phoneTextFiled.text,_checkCodeTextFiled.text,_inviteCodeTextFiled.text,_setPassWordTextFiled.text,_nameTextFiled.text,sex,alonetemp);
}
@end
