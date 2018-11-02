//
//  RankModel.h
//  亲搭
//
//  Created by KFZXSHANGJQ on 2018/11/2.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankModel : NSObject
@property(strong,nonatomic) NSString *name;// 名字
@property(strong,nonatomic) NSString *headerImg;// 头像
@property(strong,nonatomic) NSString *headerBg;// 背景图
@property(strong,nonatomic) NSString *rankNum;// 名次
@property(strong,nonatomic) NSString *location;// 地址
@property(strong,nonatomic) NSString *sex;// 性别
@property(strong,nonatomic) NSString *sumInfo;// 获赞个数

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
