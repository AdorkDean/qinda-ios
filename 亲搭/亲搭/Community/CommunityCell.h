//
//  CommunityCell.h
//  亲搭
//
//  Created by KFZXSHANGJQ on 2018/10/25.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityModel.h"
@interface CommunityCell : UITableViewCell

@property(strong,nonatomic)CommunityModel*comModel;
@property(strong,nonatomic)void(^heartClick)(BOOL click);
@property(strong,nonatomic)void(^commonClick)();
@end
