//
//  LRSMaskView.m
//  LRSMaskView
//
//  Created by sama 刘 on 2021/8/11.
//

#import "LRSMaskView.h"

@implementation LRSMaskView

+ (instancetype)mask {
    LRSMaskView *mask = [[LRSMaskView alloc] init];
    mask.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    return mask;
}

@end
