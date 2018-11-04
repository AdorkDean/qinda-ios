//
//  FilePickerView.m
//  亲搭
//
//  Created by  辉 庄 on 2018/11/4.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import "FilePickerView.h"
@interface FilePickerView()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftLineImg;
@property (weak, nonatomic) IBOutlet UIImageView *leftCenterImg;
@property (weak, nonatomic) IBOutlet UIImageView *rightLineImg;
@property (weak, nonatomic) IBOutlet UIImageView *rightCenterImg;
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;

@property (nonatomic, strong) NSString *selectDate;

@end
#define TextColor DFTColor(16, 161, 288)
@implementation FilePickerView
+ (FilePickerView *)instanceDatePickerView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"FilePickerView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    _backView.frame = CGRectMake(WIDTH/8.0, HEIGHT/8.0, WIDTH*6/8.0, 200);
    _backView.layer.cornerRadius = 3;
    CGFloat fWidth = _backView.frame.size.width;
    CGFloat fHeight = _backView.frame.size.height;
    NSString *_title = @"学历";
    CGFloat titleWidth = [HXGetLabelWidthOrHeight getWidthWithText:_title height:20 font:17];
    _titleLabel.frame = CGRectMake((fWidth-titleWidth)/2.0, 15, titleWidth, 20);
    _titleLabel.textColor = TextColor;
    _titleLabel.text = _title;
    
    _leftLineImg.frame = CGRectMake(fWidth/6.0, fHeight/4.0, 3, fHeight/2.0);
    _leftCenterImg.frame = CGRectMake(0, 0, 10, 10);
    _leftCenterImg.center = _leftLineImg.center;
    
    _pickView.frame = CGRectMake(CGRectGetMaxX(_leftLineImg.frame)+10, fHeight/4.0, fWidth*2/3.0-20, fHeight/2.0);
    _pickView.backgroundColor = [UIColor yellowColor];
    
    _rightLineImg.frame = CGRectMake(CGRectGetMaxX(_pickView.frame)+10, fHeight/4.0, 3, fHeight/2.0);
    _rightCenterImg.frame = CGRectMake(0, 0, 10, 10);
    _rightCenterImg.center = _rightLineImg.center;
    
    _sureBtn.frame = CGRectMake(fWidth/6.0, CGRectGetMaxY(_leftLineImg.frame)+15, fWidth*2/6.0-5, 30);
    _sureBtn.layer.borderWidth = 1;
    _sureBtn.layer.borderColor = BorderColor;
    _sureBtn.layer.cornerRadius = 3;
    _sureBtn.tintColor = TextColor;
    
    _cancleBtn.frame = CGRectMake(CGRectGetMaxX(_sureBtn.frame)+10, CGRectGetMaxY(_leftLineImg.frame)+15, fWidth*2/6.0-5, 30);
    _cancleBtn.layer.borderWidth = 1;
    _cancleBtn.layer.borderColor = BorderColor;
    _cancleBtn.layer.cornerRadius = 3;
    _cancleBtn.tintColor = TextColor;
    // Drawing code
}

- (IBAction)sureAction:(id)sender {
    [self removeFromSuperview];
}
- (IBAction)cancleAction:(id)sender {
 
    //delegate
    [self.delegate getSelectData:self.selectDate];
    [self sureAction:nil];
}
@end
