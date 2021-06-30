//
//  US_PresentAnimaiton.h
//
//  Created by chenzhuqing on 2019/1/24.
//  Copyright © 2019年 Baoqin Huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    AniamtionSheetType,
    Aniamtion3DTransform,
    AniamtionAlertType,
} USAniamtionType;

NS_ASSUME_NONNULL_BEGIN
typedef void(^PresentAnimationBlock)(void);
@interface US_PresentAnimaiton : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic,assign) CGFloat animatTime;
@property (nonatomic,strong) PresentAnimationBlock clicBlock;
- (instancetype)initWithAnimationType:(USAniamtionType)animationType targetViewSize:(CGSize) size;

@end

NS_ASSUME_NONNULL_END
