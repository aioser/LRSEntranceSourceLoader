//
//  LRPresentedAnimationView.h
//  LangRen
//
//  Created by 刘俊臣 on 2020/10/26.
//  Copyright © 2020 langrengame.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRSPresentedViewProtocol.h"

#define kLRSPresentedAnimationViewDefaultWidth (315 * kDeviceScale)

NS_ASSUME_NONNULL_BEGIN

@interface LRSPresentedAnimationView : UIView<LRSPresentedViewProtocol>

@end

NS_ASSUME_NONNULL_END
