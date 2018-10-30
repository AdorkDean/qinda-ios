//
//  AppDelegate.m
//  亲搭
//
//  Created by KFZXSHANGJQ on 2018/10/11.
//  Copyright © 2018年 hxlove. All rights reserved.
//

#import "AppDelegate.h"
#import "HXLeadScorllVC.h"
#import "HXTabBarController.h"
#import "HXLoginVC.h"
#import "HXNavigationVC.h"
//宽高设定
#define WIDTH   [UIScreen mainScreen].bounds.size.width
#define HEIGHT  [UIScreen mainScreen].bounds.size.height

//#define DFTColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
@interface AppDelegate ()


@property(nonatomic,strong)HXLeadScorllVC *hxSVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /**
     *  版本的判断
     */
    [self newTexing];
    
    return YES;
}
#pragma mark 版本新特性
-(void)newTexing
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
//    2.创建 图片数组
    NSMutableArray *imgNameArr = [NSMutableArray array];
    imgNameArr = @[@"yindao1.jpg",@"yindao2.jpg"].mutableCopy;
    
//    3.创建引导图控制器
    HXLeadScorllVC *hxSVC =
    [[HXLeadScorllVC alloc]initWithImgNameArr:imgNameArr];
    
//    3.1（在引导图控制器主页面上额外附加 辅助View，比如：按钮 Button，选加，可有可无）
    UIButton  *jumpButton = [[UIButton alloc]init];
    jumpButton.frame = CGRectMake(WIDTH - 80,50, 60, 30);
    [jumpButton.layer setBorderWidth:2];
    [jumpButton.layer setBorderColor:DFTColor(16, 152, 116).CGColor];
    [jumpButton setTitle:@"跳过" forState:UIControlStateNormal];
    [jumpButton setTitleColor:DFTColor(16, 152, 116) forState:UIControlStateNormal];
    [jumpButton addTarget:self action:@selector(clickNewController) forControlEvents:UIControlEventTouchUpInside];
    
//    在引导图控制器主页面上额外附加 按钮
    [hxSVC.view addSubview:jumpButton];

//    3.2（在引导图上额外附加 辅助View，比如：按钮 Button，选加，可有可无）
    UIButton *registerButton = [[UIButton alloc]init];
    registerButton.frame = CGRectMake(WIDTH*(imgNameArr.count-1)+(WIDTH-(WIDTH/1.74))/2.0,HEIGHT/1.22, WIDTH/1.74, 42.5);
//    [registerButton setTitle:@"立即注册" forState:(UIControlStateNormal)];
//    [registerButton setTitleColor:DFTColor(16, 152, 116) forState:(UIControlStateNormal)];
//    [registerButton.layer setMasksToBounds:YES];
//    [registerButton.layer setBorderWidth:2];
//    [registerButton.layer setBorderColor:DFTColor(16, 152, 116).CGColor];
    [registerButton addTarget:self action:@selector(registerBtnAction) forControlEvents:(UIControlEventTouchUpInside)];

//    在滑动引导图上额外附加 按钮
    [hxSVC.hxScrollView addSubview:registerButton];
    
    // 设置根视图控制器为 引导图控制器
    self.window.rootViewController = hxSVC;
    self.hxSVC = hxSVC;
    //    }
    [self.window makeKeyAndVisible];
    
}

#pragma mark 点击button进入首页
-(void)clickNewController
{
    //如果跳过就设置为NO
//    UserDefaultBool(NO, @"first");
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    HXTabBarController *tab = [[HXTabBarController alloc]init];
    
    BOOL logined = false;
//    logined = true;
    if (!logined) {
        HXNavigationVC *logVC = [[HXNavigationVC alloc]initWithRootViewController:[[HXLoginVC alloc]init]];
        [self.hxSVC presentViewController:logVC animated:YES completion:nil];
    }else{
        window.rootViewController = tab;
    }
}


/*
 登陆接口
 */
- (void)registerBtnAction{
    //如果跳过就设置为NO
    //    UserDefaultBool(NO, @"first");
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    HXTabBarController *tab = [[HXTabBarController alloc]init];
    
    BOOL logined = false;
    //    logined = true;
    if (!logined) {
        HXNavigationVC *logVC = [[HXNavigationVC alloc]initWithRootViewController:[[HXLoginVC alloc]init]];
        [self.hxSVC presentViewController:logVC animated:YES completion:nil];
    }else{
        window.rootViewController = tab;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
