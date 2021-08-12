//
//  UIImage+LRSEntranceLoader.m
//  LRSEntranceLoader
//
//  Created by sama 刘 on 2021/8/12.
//

#import "UIImage+LRSEntranceLoader.h"

@implementation UIImage (LRSEntranceLoader)

static UIImage *LRSEntranceLoaderImageNamed_(NSString * named) {
    return [UIImage imageNamed:named inBundle:LRSEntranceLoaderSource_() compatibleWithTraitCollection:nil];
}

static NSBundle *LRSEntranceLoaderSource_(void) {
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"LRSEntranceSourceLoader")];
    NSURL *url = [bundle URLForResource:@"LRSEntranceSourceLoader" withExtension:@"bundle"];
    return [NSBundle bundleWithURL:url];
}


+ (instancetype)entrance_imageNamed:(NSString *)name {
    return LRSEntranceLoaderImageNamed_(name);
}

@end
