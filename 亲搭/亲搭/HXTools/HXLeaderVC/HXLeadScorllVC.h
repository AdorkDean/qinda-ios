//
//  HXLeadScorllVC.h
//  DianFuTong
//
//  Created by hxlove on 2018/10/9.
//
//

#import <UIKit/UIKit.h>

@interface HXLeadScorllVC : UIViewController


// 对外暴露
// 引导图 名称数组
@property(nonatomic,strong) NSMutableArray *imgNameArr;

@property(nonatomic,strong) UIScrollView *hxScrollView;
- (instancetype)initWithImgNameArr:(NSMutableArray *)imgNameArr;
@end
