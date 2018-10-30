//
//  MakeFriendsCell.h
//  亲搭
//
//  Created by KFZXSHANGJQ on 2018/10/24.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakeFriendsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property(strong,nonatomic)void(^heartClick)(BOOL click);
@property(strong,nonatomic)void(^commonClick)();
@end
