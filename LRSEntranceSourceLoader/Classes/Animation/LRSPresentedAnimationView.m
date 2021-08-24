//
//  LRPresentedAnimationView.m
//  LangRen
//
//  Created by 刘俊臣 on 2020/10/26.
//  Copyright © 2020 langrengame.com. All rights reserved.
//

#import "LRSPresentedAnimationView.h"
#import <LRSEntranceSourceLoader/LRSEntranceMaskView.h>

@interface LRSPresentedAnimationView()

@property (nonatomic, strong, readwrite) LRSEntranceMaskView *backgroundMaskView;
@property (nonatomic, strong, readwrite) UIView *contentView;

@end

@implementation LRSPresentedAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.backgroundMaskView];
        [self addSubview:self.contentView];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    self.backgroundMaskView.hidden = NO;
    self.contentView.layer.transform = CATransform3DMakeScale(1.2f, 1.2f, 1.2f);
    self.contentView.layer.opacity = 0.0f;
    self.frame = [UIApplication sharedApplication].delegate.window.bounds;
    self.backgroundMaskView.frame = self.bounds;
    [super willMoveToSuperview:newSuperview];

    [UIView animateWithDuration:0.3
                     animations:^{
        self.contentView.layer.transform = CATransform3DIdentity;
        self.contentView.layer.opacity = 1;
    }
                     completion:self.showCompletation];
}

- (void)removeFromSuperviewWithAnimation:(BOOL)animating {
    if (animating) {
        [UIView animateWithDuration:0.1 animations:^{
            self.contentView.layer.transform = CATransform3DMakeScale(1.04f, 1.04f, 1.04f);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.contentView.layer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
                self.backgroundMaskView.alpha = 0;
                self.alpha = 0;
            } completion:^(BOOL finished) {
                if (self.dismissCompletation) {
                    self.dismissCompletation(finished);
                }
                [self removeFromSuperview];
            }];
        }];
    } else {
        [self removeFromSuperview];
    }
}

- (LRSEntranceMaskView *)backgroundMaskView {
    if (!_backgroundMaskView) {
        _backgroundMaskView = [LRSEntranceMaskView mask];
    }
    return _backgroundMaskView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

@synthesize dismissCompletation;

@synthesize showCompletation;

@synthesize backgroundMaskView = _backgroundMaskView;

@synthesize contentView = _contentView;

@end
