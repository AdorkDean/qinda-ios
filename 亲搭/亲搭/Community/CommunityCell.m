//
//  CommunityCell.m
//  亲搭
//
//  Created by KFZXSHANGJQ on 2018/10/25.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import "CommunityCell.h"
#import "CommunityModel.h"
@interface CommunityCell ()
{
    BOOL _heart;
    long _count;
}

@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *senderInfoLabel;

@property (weak, nonatomic) IBOutlet UIView *imgsView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *heartBtn;
@property (weak, nonatomic) IBOutlet UIButton *commonBtn;

@property (weak, nonatomic) IBOutlet UIView *receiveView;
@property (strong, nonatomic) NSMutableArray *imgArr;
@property (weak, nonatomic) IBOutlet UILabel *receiveLabel;

@property (strong, nonatomic) NSString *nameStr;

@end
@implementation CommunityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    CGFloat headerWidth = _headerImg.frame.size.width;
    _headerImg.layer.cornerRadius = headerWidth/2.0;
    _receiveView.layer.cornerRadius = 5;
    
    self.backgroundColor = DFTColor(244, 244, 244);
}
// model 赋值
- (void)setComModel:(CommunityModel *)comModel{
    _comModel = comModel;
    _imgArr = [NSMutableArray array];
    _headerImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",comModel.headerImg]];
    _nameLabel.text = comModel.name;
    _senderInfoLabel.text = comModel.senderInfo;
    _timeLabel.text = comModel.time;
    if ([comModel.heart isEqualToString:@"1"]) {
        _heart = YES;
    } else {
        _heart = NO;
    }
    NSString *heartBgImgName = _heart ? @"heartbeat_highlighted" : @"heart_hole";
    [_heartBtn setBackgroundImage:[UIImage imageNamed:heartBgImgName] forState:UIControlStateNormal];
    // 重构 _senderInfoLabel.frame
    CGRect senderLabelFrame = _senderInfoLabel.frame;
    senderLabelFrame.size.height = [self textHeightFromeMode:comModel.senderInfo labelWidth:WIDTH*3/5.0];
    _senderInfoLabel.frame = senderLabelFrame;
    
    // 设置 _imgsView.frame
    CGFloat imgsHeight = 0;
    // 确定 _imgsView 高度
    _imgArr = comModel.imgArr;
    CGFloat imgWidth = (WIDTH*3/5.0-20)/3.0;
    
    if (_imgArr.count == 0) {
        imgsHeight = 0;
    } else if ((_imgArr.count > 0) && (_imgArr.count <= 3)){
        imgsHeight = imgWidth+20;// 上下间距为 10
    } else if ((_imgArr.count > 3) && (_imgArr.count <= 6)){
        imgsHeight = imgWidth*2+30;
    } else {
        imgsHeight = imgWidth*3+40;
    }
    _imgsView.frame = CGRectMake(CGRectGetMinX(_senderInfoLabel.frame), CGRectGetMaxY(_senderInfoLabel.frame), WIDTH*3/5.0, imgsHeight);
    // 添加图片
    if (_imgArr.count != 0) {
        for (int i=0; i<_imgArr.count; i++) {
            if (i < 3) {
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake((imgWidth+10)*i, 10, imgWidth, imgWidth)];
                imgView.image = [UIImage imageNamed:_imgArr[i]];
                [_imgsView addSubview:imgView];
            } else if (i>=3 && i<6){
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake((imgWidth+10)*(i-3), imgWidth+20, imgWidth, imgWidth)];
                imgView.image = [UIImage imageNamed:_imgArr[i]];
                [_imgsView addSubview:imgView];
            } else {
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake((imgWidth+10)*(i-6), imgWidth*2+30, imgWidth, imgWidth)];
                imgView.image = [UIImage imageNamed:_imgArr[i]];
                [_imgsView addSubview:imgView];
            }
        }
    }
    
    // 设置 _timeLabel _commonBtn _heartBtn 的 frame
    _timeLabel.frame = CGRectMake(CGRectGetMinX(_imgsView.frame), CGRectGetMaxY(_imgsView.frame)+10, WIDTH/2.0, 21);
    _commonBtn.frame = CGRectMake(WIDTH-50, CGRectGetMaxY(_imgsView.frame)+10, 20, 20);
    _heartBtn.frame = CGRectMake(WIDTH-90, CGRectGetMaxY(_imgsView.frame)+10, 20, 20);
    
    // 绘制点赞 label
    [self drowReceiveViewWith:comModel.nameArr];
}

- (void)drowReceiveViewWith:(NSMutableArray *)nameArr{
    _nameStr = @"";
    for (int i=0; i<nameArr.count; i++) {
        NSString *temStr = [NSString stringWithFormat:@"%@、",nameArr[i]];
        _nameStr = [NSString stringWithFormat:@"%@%@",_nameStr,temStr];
    }
    NSString *nextStr = [NSString stringWithFormat:@"等 %ld 人觉得很赞。",nameArr.count];
    _count = nameArr.count;
    NSString *receiveStr = [NSString stringWithFormat:@"%@%@",_nameStr,nextStr];
    _receiveLabel.text = receiveStr;
    _receiveLabel.textColor = [UIColor blueColor];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:receiveStr];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:nextStr].location, [[noteStr string] rangeOfString:nextStr].length);
    //需要设置的位置
    [noteStr addAttribute:NSForegroundColorAttributeName value:TextGrayColor range:redRange];
    //设置颜色
    [_receiveLabel setAttributedText:noteStr];
    
    CGFloat receiveViewHeight = [self textHeightFromeMode:receiveStr labelWidth:WIDTH*3/5.0+30];
    // 设置 frame
    _receiveView.frame = CGRectMake(CGRectGetMinX(_timeLabel.frame), CGRectGetMaxY(_timeLabel.frame)+9, WIDTH*3/5.0+40, receiveViewHeight+10);
    _receiveLabel.frame = CGRectMake(5, 5, WIDTH*3/5.0+30, receiveViewHeight);
}

// 返回 label 高度
- (CGFloat)textHeightFromeMode:(NSString *)text labelWidth:(CGFloat)labelWidth{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(labelWidth, 500) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} context:nil];
    
    return rect.size.height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)heartAction:(id)sender {
    _heart = !_heart;
    NSString *heartBgImgName = _heart ? @"heartbeat_highlighted" : @"heart_hole";
    [_heartBtn setBackgroundImage:[UIImage imageNamed:heartBgImgName] forState:UIControlStateNormal];
    NSString *tempName = @"";
    NSString *tempNext = @"";
    if (_heart) {
        tempName = [NSString stringWithFormat:@"%@%@、",_nameStr,@"本机用户"];
        tempNext = [NSString stringWithFormat:@"等 %ld 人觉得很赞。", _count+1];
    } else {
        tempName = [NSString stringWithFormat:@"%@",_nameStr];
        tempNext = [NSString stringWithFormat:@"等 %ld 人觉得很赞。", _count];
    }
    NSString *receiveStr = [NSString stringWithFormat:@"%@%@",tempName,tempNext];
    _receiveLabel.text = receiveStr;
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:receiveStr];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:tempNext].location, [[noteStr string] rangeOfString:tempNext].length);
    //需要设置的位置
    [noteStr addAttribute:NSForegroundColorAttributeName value:TextGrayColor range:redRange];
    
    CGFloat receiveViewHeight = [self textHeightFromeMode:receiveStr labelWidth:WIDTH*3/5.0+30];
    // 设置 frame
    _receiveView.frame = CGRectMake(CGRectGetMinX(_timeLabel.frame), CGRectGetMaxY(_timeLabel.frame)+9, WIDTH*3/5.0+40, receiveViewHeight+10);
    _receiveLabel.frame = CGRectMake(5, 5, WIDTH*3/5.0+30, receiveViewHeight);

    //设置颜色
    [_receiveLabel setAttributedText:noteStr];
    if (_heartClick) {
        _heartClick(_heart,receiveViewHeight,_comModel.nameArr);
    }
}
- (IBAction)commonAction:(id)sender {
    if (_commonClick) {
        _commonClick();
    }
}


@end
