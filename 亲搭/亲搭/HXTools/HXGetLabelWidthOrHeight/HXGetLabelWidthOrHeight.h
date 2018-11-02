//
//  HXGetLabelWidthOrHeight.h
//  亲搭
//
//  Created by KFZXSHANGJQ on 2018/11/2.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXGetLabelWidthOrHeight : NSObject
+ (CGFloat)getLabelHeightWithText:(NSString *)text width:(CGFloat)width font: (CGFloat)font;
+ (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font;
@end
