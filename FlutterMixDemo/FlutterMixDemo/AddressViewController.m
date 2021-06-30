//
//  AddressViewController.m
//  FlutterMixDemo
//
//  Created by 陈竹青 on 2021/6/29.
//

#import "AddressViewController.h"
#import "US_PresentAnimaiton.h"
#import "AppDelegate.h"
#define kIphoneX1 \
({\
    BOOL INTERFACE_IS_IPHONEX = NO;\
    if (@available(iOS 11.0, *)) {\
        if([[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0) {\
            INTERFACE_IS_IPHONEX = YES;\
        }\
}\
    INTERFACE_IS_IPHONEX;\
})
#define kIphoneX2 [UIScreen mainScreen].bounds.size.height >= 812
#define kIphoneX (kIphoneX1?kIphoneX1:kIphoneX2)
// 状态栏高度
#define kStatusBarHeight            (kIphoneX ? 44.f : 20.f)
#define kTabBarHeight               ((kStatusBarHeight) > (20) ? (83) : (49))

@interface AddressViewController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) US_PresentAnimaiton * animation;
@end

@implementation AddressViewController

#pragma mark - <Life cycle>
- (instancetype)init {
    self = [super init];
    if (self) {
        _animation = [[US_PresentAnimaiton alloc] initWithAnimationType:AniamtionSheetType targetViewSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-0,[UIScreen mainScreen].bounds.size.height*0.8)];
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate=self;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= UIColor.whiteColor;
    // Do any additional setup after loading the view.
    
    FlutterEngine * flutterEngine = ((AppDelegate *)UIApplication.sharedApplication.delegate).flutterEngine;
    FlutterViewController * flutterVC = [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
    [flutterVC pushRoute:@"/AddressSelect"];
    [self addChildViewController:flutterVC];
    [self.view addSubview:flutterVC.view];
    flutterVC.view.frame = self.view.frame;
    [flutterVC didMoveToParentViewController:self];
//    flutterVC.view.backgroundColor =[UIColor whiteColor];
//    flutterVC.title = @"我是第二个页面";
//    [self.navigationController pushViewController:flutterVC animated:YES];
}


#pragma mark - <UIViewControllerTransitioningDelegate>
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return _animation;
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return  _animation;
}


@end
