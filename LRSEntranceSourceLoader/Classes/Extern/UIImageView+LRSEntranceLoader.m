//
//  UIImageView+LRSEntranceLoader.m
//  LRSEntranceLoader
//
//  Created by sama 刘 on 2021/8/12.
//

#import "UIImageView+LRSEntranceLoader.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (LRSEntranceLoader)

static UIImage *LRSEntranceLoaderImageNamed_(NSString * named) {
    return [UIImage imageNamed:named inBundle:LRSEntranceLoaderSource_() compatibleWithTraitCollection:nil];
}

static NSBundle *LRSEntranceLoaderSource_(void) {
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"LRSEntranceSourceLoader")];
    NSURL *url = [bundle URLForResource:@"LRSEntranceSourceLoader" withExtension:@"bundle"];
    return [NSBundle bundleWithURL:url];
}

- (void)lr_entrance_set_imageWithImageInfo:(NSString *)imageInfo
                          placeholderImage:(UIImage *)placeholderImage {
    UIImage *image = LRSEntranceLoaderImageNamed_(imageInfo);
    if (image) {
        self.image = image;
    } else {
        [self sd_setImageWithURL:[NSURL URLWithString:imageInfo] placeholderImage:placeholderImage];
    }
}

@end
