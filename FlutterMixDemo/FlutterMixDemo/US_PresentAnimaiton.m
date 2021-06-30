//
//  US_PresentAnimaiton.m
//
//  Created by chenzhuqing on 2019/1/24.
//  Copyright © 2019年 Baoqin Huang. All rights reserved.
//

#import "US_PresentAnimaiton.h"

@interface US_PresentAnimaiton ()
@property (nonatomic,assign) CGSize viewSize;
@property (nonatomic,assign) USAniamtionType  animationType;

@end

@implementation US_PresentAnimaiton

- (instancetype)initWithAnimationType:(USAniamtionType)animationType targetViewSize:(CGSize) size{
    self = [super init];
    if (self) {
        self.viewSize=size;
        self.animationType = animationType;
        if (animationType== Aniamtion3DTransform) {
            self.animatTime=0.4;
        }else{
            self.animatTime=0.3;
        }
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.animatTime;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (toVC.isBeingPresented) {
        if (self.animationType == Aniamtion3DTransform) {
            [self present3DAnimainWithTransitionContext:transitionContext];
        }else if (self.animationType ==AniamtionSheetType){
            [self presentSheetTypeWithTransitionContext:transitionContext];
        }else if (self.animationType == AniamtionAlertType){
            [self presentAlertTypeWithTransitionContext:transitionContext];
        }
    }
    if (fromVC.isBeingDismissed) {
        if (self.animationType == Aniamtion3DTransform) {
            [self dismiss3DAnimainWithTransitionContext:transitionContext];
        }else if (self.animationType ==AniamtionSheetType){
            [self dismissSheetTypeWithTransitionContext:transitionContext];
        }else if (self.animationType== AniamtionAlertType){
            [self dismissAlertTypeWithTransitionContext:transitionContext];
        }
    
    }
}
#pragma mark - <Show 3D Animation>
- (void)present3DAnimainWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    fromVC.view.hidden = YES;
    //这里有个重要的概念containerView，如果要对视图做转场动画，视图就必须要加入containerView中才能进行，可以理解containerView管理着所有做转场动画的视图
    UIView *containerView = [transitionContext containerView];
    //将截图视图和vc2的view都加入ContainerView中
    [containerView addSubview:tempView];
    [containerView addSubview:toVC.view];
    //设置vc2的frame，因为这里vc2present出来不是全屏，且初始的时候在底部，如果不设置frame的话默认就是整个屏幕咯，这里containerView的frame就是整个屏幕
    toVC.view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, self.viewSize.height);
    //开始动画吧，使用产生弹簧效果的动画AP
    toVC.view.layer.zPosition=500;
    tempView.layer.zPosition=400;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        //首先我们让vc2向上移动
        toVC.view.transform = CGAffineTransformMakeTranslation(0, -self.viewSize.height);
        //然后让截图视图缩小一点即可
        //        tempView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
        rotationAndPerspectiveTransform.m34 = 1.0 / -300;
        tempView.layer.shadowOpacity = 0.01;
        tempView.layer.transform = CATransform3DRotate(rotationAndPerspectiveTransform, 8.0f * M_PI / 180.0f, 1.0f, 0.0f, 0.0f);
    } completion:^(BOOL finished) {

        [UIView animateWithDuration:0.3 animations:^{
            tempView.layer.affineTransform = CGAffineTransformMakeScale(0.93, 0.93);

        }];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        //转场失败后的处理
        if ([transitionContext transitionWasCancelled]) {
            //失败后，我们要把vc1显示出来
            fromVC.view.hidden = NO;
            //然后移除截图视图，因为下次触发present会重新截图
            [tempView removeFromSuperview];
        }
    }];
}

- (void)dismiss3DAnimainWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //参照present动画的逻辑，present成功后，containerView的最后一个子视图就是截图视图，我们将其取出准备动画
    UIView *tempView = [transitionContext containerView].subviews[0];
    //动画吧
    fromVC.view.layer.zPosition=500;
    tempView.layer.zPosition=400;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        //因为present的时候都是使用的transform，这里的动画只需要将transform恢复就可以了
        fromVC.view.transform = CGAffineTransformIdentity;
        //        tempView.transform = CGAffineTransformIdentity;
        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
        rotationAndPerspectiveTransform.m34 = 1.0 / 300;
        tempView.layer.shadowOpacity = 0.01;
        tempView.layer.transform = CATransform3DRotate(rotationAndPerspectiveTransform, -10.0f * M_PI / 180.0f, 1.0f, 0.0f, 0.0f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            tempView.layer.affineTransform = CGAffineTransformMakeScale(1,1);
        } completion:^(BOOL finished) {
            if ([transitionContext transitionWasCancelled]) {
                //失败了标记失败
                [transitionContext completeTransition:NO];
            }else{
                //如果成功了，我们需要标记成功，同时让vc1显示出来，然后移除截图视图，
                [transitionContext completeTransition:YES];
                toVC.view.hidden = NO;
                [tempView removeFromSuperview];
            }
        }];
    }];
}

#pragma mark - <From Bottom>
- (void)presentSheetTypeWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
//    tempView.frame = fromVC.view.frame;
//    fromVC.view.hidden = YES;
    //这里有个重要的概念containerView，如果要对视图做转场动画，视图就必须要加入containerView中才能进行，可以理解containerView管理着所有做转场动画的视图
    UIView * mask=[[UIView alloc] init];
    mask.frame=fromVC.view.frame;
    mask.backgroundColor=[UIColor blackColor];
    mask.alpha=0.0;
    mask.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [mask addGestureRecognizer:tap];
    UIView *containerView = [transitionContext containerView];
    //将截图视图和vc2的view都加入ContainerView中
//    [containerView addSubview:tempView];
    [containerView addSubview:mask];
    [containerView addSubview:toVC.view];
    //设置vc2的frame，因为这里vc2present出来不是全屏，且初始的时候在底部，如果不设置frame的话默认就是整个屏幕咯，这里containerView的frame就是整个屏幕
    toVC.view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, self.viewSize.height);
    //开始动画吧，使用产生弹簧效果的动画API
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.transform = CGAffineTransformMakeTranslation(0, -self.viewSize.height);
         mask.alpha=0.4;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        //转场失败后的处理
        if ([transitionContext transitionWasCancelled]) {
            //失败后，我们要把vc1显示出来
            fromVC.view.hidden = NO;
            //然后移除截图视图，因为下次触发present会重新截图
//            [tempView removeFromSuperview];
            [mask removeFromSuperview];
        }
    }];
}

- (void)dismissSheetTypeWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //动画吧
    UIView *mask = [transitionContext containerView].subviews[0];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        //因为present的时候都是使用的transform，这里的动画只需要将transform恢复就可以了
        fromVC.view.transform = CGAffineTransformIdentity;
        mask.alpha=0.0;
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            //失败了标记失败
            [transitionContext completeTransition:NO];
        }else{
            //如果成功了，我们需要标记成功，同时让vc1显示出来，然后移除截图视图，
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
            [mask removeFromSuperview];
        }
    }];
}
#pragma mark - <Show alert type animation>
- (void)presentAlertTypeWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //这里有个重要的概念containerView，如果要对视图做转场动画，视图就必须要加入containerView中才能进行，可以理解containerView管理着所有做转场动画的视图
    UIView *containerView = [transitionContext containerView];
    //将截图视图和vc2的view都加入ContainerView中
    [containerView addSubview:toVC.view];
    //设置vc2的frame，因为这里vc2present出来不是全屏，且初始的时候在底部，如果不设置frame的话默认就是整个屏幕咯，这里containerView的frame就是整个屏幕
    CGFloat screenw=[UIScreen mainScreen].bounds.size.width;
    CGFloat screenH=[UIScreen mainScreen].bounds.size.height;
    toVC.view.frame = CGRectMake((screenw-self.viewSize.width)/2.0, (screenH-self.viewSize.height)/2.0, self.viewSize.width, self.viewSize.height);
    toVC.view.transform=CGAffineTransformScale(CGAffineTransformIdentity, 0.3, 0.3);
    //开始动画吧，使用产生弹簧效果的动画API
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.transform=CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        //转场失败后的处理
        if ([transitionContext transitionWasCancelled]) {
            //失败后，我们要把vc1显示出来
            fromVC.view.hidden = NO;
            //然后移除截图视图，因为下次触发present会重新截图
        }
    }];
}

- (void)dismissAlertTypeWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //参照present动画的逻辑，present成功后，containerView的最后一个子视图就是截图视图，我们将其取出准备动画
    //动画吧
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        //因为present的时候都是使用的transform，这里的动画只需要将transform恢复就可以了
        fromVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
        fromVC.view.alpha=0.0;
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            //失败了标记失败
            [transitionContext completeTransition:NO];
        }else{
            //如果成功了，我们需要标记成功，同时让vc1显示出来，然后移除截图视图，
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
        }
    }];
}

- (void)tapClick:(UIGestureRecognizer *) recognizer{
    if (self.clicBlock) {
        self.clicBlock();
    }
}
@end
