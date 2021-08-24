//
//  LRSMaskView.m
//  LRSMaskView
//
//  Created by sama 刘 on 2021/8/11.
//

#import "LRSEntranceMaskView.h"

@implementation LRSEntranceMaskView

+ (instancetype)mask {
    LRSEntranceMaskView *mask = [[LRSEntranceMaskView alloc] init];
    mask.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    return mask;
}

@end
