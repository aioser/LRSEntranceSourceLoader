//
//  LRPresentedViewProtocol.h
//  LangRen
//
//  Created by 刘俊臣 on 2020/10/26.
//  Copyright © 2020 langrengame.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LRPresentedAnimationCompletation)(BOOL success);

@protocol LRSPresentedViewProtocol <NSObject>

/// 背景遮罩
@property (nonatomic, strong, readonly, nonnull) UIView *backgroundMaskView;

/// 内部视图
@property (nonatomic, strong, readonly, nonnull) UIView *contentView;

/// superview.addSubview:#<View># 后，动画完成的回调
@property (nonatomic, copy, nullable) LRPresentedAnimationCompletation showCompletation;

/// View removeFromSuperview 后，动画完成的回调
@property (nonatomic, copy, nullable) LRPresentedAnimationCompletation dismissCompletation;

- (void)removeFromSuperviewWithAnimation:(BOOL)animating;
@end
