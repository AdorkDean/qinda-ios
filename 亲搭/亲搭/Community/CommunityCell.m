//
//  CommunityCell.m
//  亲搭
//
//  Created by KFZXSHANGJQ on 2018/10/25.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import "CommunityCell.h"

@interface CommunityCell ()
{
    BOOL _heart;
}
@property (weak, nonatomic) IBOutlet UIButton *heartBtn;

@end
@implementation CommunityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    CGFloat headerWidth = _headerImg.frame.size.width;
    _headerImg.layer.cornerRadius = headerWidth/2.0;
    _headerImg.backgroundColor = [UIColor redColor];
    
    _imgArr = @[
                @"社区图片01",
                @"社区图片02",
                @"社区图片03",
                @"社区图片01",
                @"社区图片02",
                @"社区图片03"
                ].mutableCopy;
    CGFloat imgWidth = (_imgsView.frame.size.width-20)/3.0;
    CGRect imgsFrame = _imgsView.frame;
    if (_imgArr.count == 0) {
        imgsFrame.size.height = 0;
    } else if ((_imgArr.count > 0) && (_imgArr.count <= 3)){
        imgsFrame.size.height = imgWidth;
    } else {
        imgsFrame.size.height = imgWidth*2+10;
    }
    _imgsView.frame = imgsFrame;
    _imgsView.backgroundColor = [UIColor blueColor];
    
    if (_imgArr.count == 0) {

    } else {
        for (int i=0; i<_imgArr.count; i++) {
            if (i < 3) {
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake((imgWidth+10)*i, 0, imgWidth, imgWidth)];
                imgView.image = [UIImage imageNamed:_imgArr[i]];
                [_imgsView addSubview:imgView];
            } else {
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake((imgWidth+10)*(i-3), imgWidth+10, imgWidth, imgWidth)];
                imgView.image = [UIImage imageNamed:_imgArr[i]];
                [_imgsView addSubview:imgView];
            }
        }
    }
    
    self.backgroundColor = DFTColor(244, 244, 244);
}
- (NSMutableArray *)imgArr{
    if (!_imgArr) {
        _imgArr = [NSMutableArray array];
    }
    return _imgArr;
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
