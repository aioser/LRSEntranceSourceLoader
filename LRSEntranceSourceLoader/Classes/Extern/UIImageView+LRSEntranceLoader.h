//
//  UIImageView+LRSEntranceLoader.h
//  LRSEntranceLoader
//
//  Created by sama 刘 on 2021/8/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIImageView (LRSEntranceLoader)
- (void)lr_entrance_set_imageWithImageInfo:(NSString *)imageInfo
                          placeholderImage:(UIImage * _Nullable)placeholderImage;

@end

NS_ASSUME_NONNULL_END
