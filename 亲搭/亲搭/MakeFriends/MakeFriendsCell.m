//
//  MakeFriendsCell.m
//  亲搭
//
//  Created by KFZXSHANGJQ on 2018/10/24.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import "MakeFriendsCell.h"

@interface MakeFriendsCell ()
{
    BOOL _heart;
}
@property (weak, nonatomic) IBOutlet UIButton *heartbeatBtn;

@end
@implementation MakeFriendsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = DFTColor(240, 240, 240);
    _nameLabel.font = [UIFont systemFontOfSize:(WIDTH*33/720)];
    _infoLabel.font = [UIFont systemFontOfSize:(WIDTH*22/720)];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)heartbeatAction:(id)sender {
    _heart = !_heart;
    NSString *heartBgImgName = _heart ? @"heartbeat_highlighted" : @"heartbeat_normal";
    [_heartbeatBtn setBackgroundImage:[UIImage imageNamed:heartBgImgName] forState:UIControlStateNormal];
    if (_heartClick) {
        _heartClick(_heart);
    }
}
- (IBAction)commontAction:(id)sender {
    if (_commonClick) {
        _commonClick();
    }
}
@end
