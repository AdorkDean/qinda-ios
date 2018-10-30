//
//  HXLeadScorllVC.m
//  DianFuTong
//
//  Created by hxlove on 2018/10/9.
//
//

#import "HXLeadScorllVC.h"
#import "HXNavigationVC.h"
//宽高设定
#define WIDTH   [UIScreen mainScreen].bounds.size.width
#define HEIGHT  [UIScreen mainScreen].bounds.size.height

#define DFTColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]


@interface HXLeadScorllVC ()<UIScrollViewDelegate>

//scrollView 的运用
@property(nonatomic,strong) UIPageControl *hxPageControl;

@end

@implementation HXLeadScorllVC

-(instancetype)initWithImgNameArr:(NSMutableArray *)imgNameArr{
    [super viewDidLoad];
    if (!_imgNameArr) {
        _imgNameArr = imgNameArr;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    //添加image到scrolView
    for (int index = 0; index < _imgNameArr.count; index++) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(index*WIDTH, 0, WIDTH, HEIGHT)];
        NSString *string = [NSString stringWithFormat:@"%@",_imgNameArr[index]];
        //让图片充满整个屏幕
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.image = [UIImage imageNamed:string];
        [self.hxScrollView addSubview:imageView];
    }
    
    self.pageControl.numberOfPages = _imgNameArr.count;
    
    [self.view addSubview:_hxScrollView];
//    [self.view addSubview:_hxPageControl];
}

#pragma mark scrollView的实现
-(UIScrollView *)hxScrollView
{
    if (!_hxScrollView) {
        _hxScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT+64)];
        //如果想要某个方向上不能滚动，那么这个方向上对应的数值传0就可以
        _hxScrollView.contentSize = CGSizeMake(_imgNameArr.count*WIDTH, 0);
        //前后不反弹，要与bounds区分开很像
        _hxScrollView.bounces = NO;
        _hxScrollView.pagingEnabled = YES;
        _hxScrollView.showsHorizontalScrollIndicator = NO;
        _hxScrollView.delegate = self;
    }
    return _hxScrollView;
}

#pragma mark UIPageController 分页点点的实现
-(UIPageControl *)pageControl
{
    if (!_hxPageControl) {
        //高度可以设置为0，子空间可以超出父控件的范围（宽和高可以为0，不用设置交互也可以，因为无面积点击）
        _hxPageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, HEIGHT-30, WIDTH, 30)];
        _hxPageControl.currentPageIndicatorTintColor = DFTColor(16, 152, 116);
        _hxPageControl.userInteractionEnabled = NO;
        _hxPageControl.pageIndicatorTintColor = DFTColor(189, 189, 189);
    }
    return _hxPageControl;
}

#pragma mark 求偏移量四舍五入的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //偏移量求值 (int)(page+0.5)(只适用1位小数)
    double page = self.hxScrollView.contentOffset.x/self.hxScrollView.frame.size.width;
    //width;
    self.pageControl.currentPage = (int)(page+0.5);
}

/**
 使用方法
 
 1.引入 HXLeadScorllVC.h 文件
 #import "HXLeadScorllVC.h"
 
 2.创建 图片数组
 NSMutableArray *imgNameArr = [NSMutableArray array];
 imgNameArr = @[@"yindao1",@"yindao2",@"yindao3",@"yindao1",@"yindao2",@"yindao3"].mutableCopy;
 
 3.创建引导图控制器
 HXLeadScorllVC *hxSVC =
 [[HXLeadScorllVC alloc]initWithImgNameArr:imgNameArr];
 
 3.1（在引导图控制器主页面上额外附加 辅助View，比如：按钮 Button，选加，可有可无）
 UIButton  *jumpButton = [[UIButton alloc]init];
 jumpButton.frame = CGRectMake(WIDTH*(imgNameArr.count-1)+WIDTH - 80,50, 60, 30);
 [jumpButton.layer setBorderWidth:2];
 [jumpButton.layer setBorderColor:DFTColor(16, 152, 116).CGColor];
 [jumpButton setTitle:@"跳过" forState:UIControlStateNormal];
 [jumpButton setTitleColor:DFTColor(16, 152, 116) forState:UIControlStateNormal];
 [jumpButton addTarget:self action:@selector(clickNewController) forControlEvents:UIControlEventTouchUpInside];
 
 在引导图控制器主页面上额外附加 按钮
 [hxSVC.view addSubview:jumpButton];
 
 3.2（在引导图上额外附加 辅助View，比如：按钮 Button，选加，可有可无）
 UIButton *registerButton = [[UIButton alloc]init];
 registerButton.frame = CGRectMake(WIDTH*(imgNameArr.count-1)+WIDTH*0.5-93,HEIGHT-60, 186, 42.5);
 [registerButton setTitle:@"立即注册" forState:(UIControlStateNormal)];
 [registerButton setTitleColor:DFTColor(16, 152, 116) forState:(UIControlStateNormal)];
 [registerButton.layer setMasksToBounds:YES];
 [registerButton.layer setBorderWidth:2];
 [registerButton.layer setBorderColor:DFTColor(16, 152, 116).CGColor];
 [registerButton addTarget:self action:@selector(registerBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
 
 在滑动引导图上额外附加 按钮
 [hxSVC.hxScrollView addSubview:registerButton];

 // 设置根视图控制器为 引导图控制器
 self.window.rootViewController = hxSVC;
 
 */
@end
