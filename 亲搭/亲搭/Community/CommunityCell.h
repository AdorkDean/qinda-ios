//
//  CommunityCell.h
//  亲搭
//
//  Created by KFZXSHANGJQ on 2018/10/25.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunityCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *senderInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *receiveView;
@property (weak, nonatomic) IBOutlet UIView *imgsView;
@property (strong, nonatomic) NSMutableArray *imgArr;

@property(strong,nonatomic)void(^heartClick)(BOOL click);
@property(strong,nonatomic)void(^commonClick)();
@end
