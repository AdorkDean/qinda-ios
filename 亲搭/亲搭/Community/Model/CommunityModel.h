//
//  CommunityModel.h
//  亲搭
//
//  Created by KFZXSHANGJQ on 2018/10/30.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunityModel : NSObject
@property (strong, nonatomic) NSString *headerImg;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *senderInfo;
@property (strong, nonatomic) NSString *time;
@property (assign, nonatomic) NSString *heart;
@property (strong, nonatomic) NSMutableArray *imgArr;
@property (strong, nonatomic) NSMutableArray *nameArr;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
