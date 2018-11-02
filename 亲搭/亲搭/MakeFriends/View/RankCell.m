//
//  SendZhenghunRankCell.m
//  亲搭
//
//  Created by KFZXSHANGJQ on 2018/11/1.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import "RankCell.h"
@interface RankCell()
@property (weak, nonatomic) IBOutlet UIView *containView;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rankImgView;
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *getZanLabel;
@end
@implementation RankCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = DFTColor(240, 240, 240);
    _containView.layer.cornerRadius = 3;


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(RankModel *)model{
    if (!_model) {
        _model = model;
    }
    if ([_model.rankNum isEqualToString:@"1"]) {
        _rankLabel.text = @"";
    } else {
        _rankImgView.image = [UIImage imageNamed:@""];
        _rankLabel.text = _model.rankNum;
    }
    // 头像
    _headImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_model.headerImg]];
    // 性别
    NSString *sexName = [_model.sex isEqualToString:@"man"] ? @"man_sex" : @"woman_sex";
    _sexImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",sexName]];
    // 名字
    _nameLabel.text = _model.name;
    // 地址
    _locationLabel.text = _model.location;
    // 成绩
    _getZanLabel.text = _model.sumInfo;
}
@end
