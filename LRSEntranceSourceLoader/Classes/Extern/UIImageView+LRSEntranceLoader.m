//
//  UIImageView+LRSEntranceLoader.m
//  LRSEntranceLoader
//
//  Created by sama 刘 on 2021/8/12.
//

#import "UIImageView+LRSEntranceLoader.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+LRSEntranceLoader.h"

@implementation UIImageView (LRSEntranceLoader)

- (void)lr_entrance_set_imageWithImageInfo:(NSString *)imageInfo
                          placeholderImage:(UIImage *)placeholderImage {
    UIImage *image = [UIImage entrance_imageNamed:imageInfo];
    if (image) {
        self.image = image;
    } else {
        [self sd_setImageWithURL:[NSURL URLWithString:imageInfo] placeholderImage:placeholderImage];
    }
}

@end
