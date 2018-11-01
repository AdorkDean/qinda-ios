//
//  ReceiveMarriageCell.m
//  亲搭
//
//  Created by KFZXSHANGJQ on 2018/11/1.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import "ReceiveMarriageCell.h"
@interface ReceiveMarriageCell()
@property (weak, nonatomic) IBOutlet UIView *containView;

@property (weak, nonatomic) IBOutlet UIView *headImgView;
@property (weak, nonatomic) IBOutlet UIView *nameLabel;
@end

@implementation ReceiveMarriageCell

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

@end
