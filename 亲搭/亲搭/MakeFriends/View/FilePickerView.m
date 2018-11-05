//
//  FilePickerView.m
//  亲搭
//
//  Created by  辉 庄 on 2018/11/4.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import "FilePickerView.h"
@interface FilePickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSInteger _selectRow;
}
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftLineImg;
@property (weak, nonatomic) IBOutlet UIImageView *leftCenterImg;
@property (weak, nonatomic) IBOutlet UIImageView *rightLineImg;
@property (weak, nonatomic) IBOutlet UIImageView *rightCenterImg;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;

@property (nonatomic, strong) NSString *selectData;

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

    _leftLineImg.frame = CGRectMake(fWidth/6.0, fHeight/4.0, 3, fHeight/2.0);
    _leftCenterImg.frame = CGRectMake(0, 0, 10, 10);
    _leftCenterImg.center = _leftLineImg.center;
    
    CGFloat titleWidth = [HXGetLabelWidthOrHeight getWidthWithText:_title height:20 font:17];
    _titleLabel.frame = CGRectMake((fWidth-titleWidth)/2.0, CGRectGetMinY(_leftLineImg.frame), titleWidth, 20);
    _titleLabel.textColor = TextColor;
    _titleLabel.text = _title;
    
    _pickerView.frame = CGRectMake(CGRectGetMaxX(_leftLineImg.frame)+10, fHeight/4.0, fWidth*2/3.0-20, fHeight/2.0);
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    
    _rightLineImg.frame = CGRectMake(CGRectGetMaxX(_pickerView.frame)+10, fHeight/4.0, 3, fHeight/2.0);
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
    
    if (_dataArray.count != 0) {
        _selectData = _dataArray[0];
    }
    // Drawing code
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    return [_dataArray count];
}
//返回指定列，行的高度，就是自定义行的高度

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 20.0f;
    
}

//返回指定列的宽度

- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    if (component==0) {//iOS6边框占10+10
        
        return  self.backView.frame.size.width/3;
        
    } else if(component==1){
        
        return  self.backView.frame.size.width/3;
        
    }
    
    return  self.backView.frame.size.width/3;
    
}



// 自定义指定列的每行的视图，即指定列的每行的视图行为一致

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (!view){
        view = [[UIView alloc]init];
    }
    
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.backView.frame.size.width/3, 20)];
    
    text.textAlignment = NSTextAlignmentCenter;
    if (row == _selectRow) {
        text.textColor = TextColor;
    } else {
        text.textColor = TextGrayColor;
    }
    text.text = [_dataArray objectAtIndex:row];
    text.adjustsFontSizeToFitWidth = YES;
    
    [view addSubview:text];
    
    //隐藏上下直线
    
    [self.pickerView.subviews objectAtIndex:1].backgroundColor = [UIColor clearColor];
    
    [self.pickerView.subviews objectAtIndex:2].backgroundColor = [UIColor clearColor];
    
    return view;
    
}

//显示的标题

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *str = [_dataArray objectAtIndex:row];
    
    return str;
    
}

//显示的标题字体、颜色等属性

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *str = [_dataArray objectAtIndex:row];
    
    NSMutableAttributedString *AttributedString = [[NSMutableAttributedString alloc]initWithString:str];
    
    [AttributedString addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName:TextColor} range:NSMakeRange(0, [AttributedString  length])];
    
    return AttributedString;
    
}

//被选择的行

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    _selectRow = row;
    _selectData = [_dataArray objectAtIndex:row];
    NSLog(@"HANG%@",[_dataArray objectAtIndex:row]);
    
    //刷新picker，看上面的代理
    [_pickerView reloadComponent:component];
}

- (IBAction)sureAction:(id)sender {
    
    //delegate
    [self.delegate getSelectData:self.selectData type:_type];

    [self cancleAction:nil];
    NSLog(@"self.selectData=%@",self.selectData);
}
- (IBAction)cancleAction:(id)sender {
    [self removeFromSuperview];
}
@end
