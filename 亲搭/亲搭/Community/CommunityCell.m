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
}
@property (weak, nonatomic) IBOutlet UIButton *heartBtn;


@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *senderInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *receiveView;

@property (weak, nonatomic) IBOutlet UIView *imgsView;
@property (strong, nonatomic) NSMutableArray *imgArr;
@property (weak, nonatomic) IBOutlet UILabel *receiveLabel;
@end
@implementation CommunityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    CGFloat headerWidth = _headerImg.frame.size.width;
    _headerImg.layer.cornerRadius = headerWidth/2.0;
    
    self.backgroundColor = DFTColor(244, 244, 244);
}
- (void)setComModel:(CommunityModel *)comModel{
    _comModel = comModel;
    _imgArr = [NSMutableArray array];
    _headerImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",comModel.headerImg]];
    _nameLabel.text = comModel.name;
    _senderInfoLabel.text = comModel.senderInfo;
    _timeLabel.text = comModel.time;
    
    
    // 图片区域
    _imgArr = comModel.imgArr;
    CGFloat imgWidth = (_imgsView.frame.size.width-20)/3.0;
    CGRect imgsFrame = _imgsView.frame;
    
    if (_imgArr.count == 0) {
        imgsFrame.size.height = 0;
    } else if ((_imgArr.count > 0) && (_imgArr.count <= 3)){
        imgsFrame.size.height = imgWidth;
    } else if ((_imgArr.count > 3) && (_imgArr.count <= 6)){
        imgsFrame.size.height = imgWidth*2+20;
    } else {
        imgsFrame.size.height = imgWidth*3+50;
    }
    _imgsView.frame = imgsFrame;
    
    if (_imgArr.count == 0) {
        
    } else {
        for (int i=0; i<_imgArr.count; i++) {
            if (i < 3) {
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake((imgWidth+10)*i, 5, imgWidth, imgWidth)];
                imgView.image = [UIImage imageNamed:_imgArr[i]];
                [_imgsView addSubview:imgView];
            } else if (i>=3 && i<6){
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake((imgWidth+10)*(i-3), imgWidth+15, imgWidth, imgWidth)];
                imgView.image = [UIImage imageNamed:_imgArr[i]];
                [_imgsView addSubview:imgView];
            } else {
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake((imgWidth+10)*(i-6), imgWidth*2+35, imgWidth, imgWidth)];
                imgView.image = [UIImage imageNamed:_imgArr[i]];
                [_imgsView addSubview:imgView];
            }
        }
    }
    
    [self drowReceiveViewWith:comModel.nameArr];
}

- (void)drowReceiveViewWith:(NSMutableArray *)nameArr{
    NSString *nameStr = @"";
    for (int i=0; i<nameArr.count; i++) {
        NSString *temStr = [NSString stringWithFormat:@"%@、",nameArr[i]];
        nameStr = [NSString stringWithFormat:@"%@%@",nameStr,temStr];
    }
    NSString *nextStr = [NSString stringWithFormat:@"等 %ld 人觉得很赞。",nameArr.count];
    
    NSString *receiveStr = [NSString stringWithFormat:@"%@%@",nameStr,nextStr];
    _receiveLabel.text = receiveStr;
    
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:receiveStr];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:nameStr].location, [[noteStr string] rangeOfString:nameStr].length);
    //需要设置的位置
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:redRange];
    //设置颜色
    [_receiveLabel setAttributedText:noteStr];
    
    CGFloat receiveViewHeight = [self textHeightFromeMode:receiveStr labelWidth:_imgsView.frame.size.width-20];
    
    CGRect receiveFrame = _receiveView.frame;
    receiveFrame.size.height = receiveViewHeight+10;
    _receiveView.frame = receiveFrame;
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
    if (_heartClick) {
        _heartClick(_heart);
    }
}
- (IBAction)commonAction:(id)sender {
    if (_commonClick) {
        _commonClick();
    }
}


@end
