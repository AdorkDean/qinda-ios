//
//  CommunityModel.m
//  亲搭
//
//  Created by KFZXSHANGJQ on 2018/10/30.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import "CommunityModel.h"

@implementation CommunityModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}
@end
