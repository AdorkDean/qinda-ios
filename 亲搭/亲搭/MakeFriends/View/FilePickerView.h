//
//  FilePickerView.h
//  亲搭
//
//  Created by  辉 庄 on 2018/11/4.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FilePickerViewDelegate <NSObject>

- (void)getSelectData:(NSString *)data type:(NSInteger)type;

@end

@interface FilePickerView : UIView
@property (nonatomic, weak) id<FilePickerViewDelegate> delegate;
@property(strong,nonatomic) NSMutableArray *dataArray;
@property(assign,nonatomic) NSInteger type;
@property(strong,nonatomic) NSString *title;
+ (FilePickerView *)instanceDatePickerView;

@end
