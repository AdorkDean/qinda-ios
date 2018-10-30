//
//  HXTabBarController.m
//  DianFuTong
//
//  Created by KFZXSHANGJQ on 2018/10/11.
//
//

#import "HXTabBarController.h"

#import "HXNavigationVC.h"

#import "MakeFriendsVC.h"
#import "CommunityVC.h"
#import "NewFindVC.h"
#import "MyVC.h"
#define DFTColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface HXTabBarController ()

@end

@implementation HXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabBarViewController];
}


#pragma mark  对下面tabBar进行设计
-(void)setTabBarViewController
{
    MakeFriendsVC *mainVC = [[MakeFriendsVC alloc]init];
    [self addChildViewController:mainVC title:@"交友" image:@"tabbar-friend" selectImage:@"tabbar-friend-click"];
    
    CommunityVC *hotVC = [[CommunityVC alloc]init];
    [self addChildViewController:hotVC title:@"社区" image:@"tabbar-community" selectImage:@"tabbar-community-click"];
    
    NewFindVC *markVC = [[NewFindVC alloc]init];
    [self addChildViewController:markVC title:@"发现" image:@"tabbar-find" selectImage:@"tabbar-find-click"];
    
    MyVC *meVC = [[MyVC alloc]init];
    [self addChildViewController:meVC title:@"我的" image:@"tabbar-my" selectImage:@"tabbar-my-click"];
}

-(void)addChildViewController:(UIViewController *)childViewController title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{
    childViewController.title = title;
    childViewController.view.backgroundColor = DFTColor(arc4random()%256, arc4random()%256, arc4random()%256);
    childViewController.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childViewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [childViewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:DFTColor(123, 123, 123)} forState:UIControlStateNormal];
    [childViewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:
                                                                 //DFTColor(16, 152, 116)
                                                             [UIColor redColor]
                                                             } forState:UIControlStateSelected];
    HXNavigationVC *nav=[[HXNavigationVC alloc]initWithRootViewController:childViewController];
    
    [nav.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont systemFontOfSize:23]}];
    
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
