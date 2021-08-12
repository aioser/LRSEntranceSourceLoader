//
//  LRSEntranceSourceLoader.m
//  LRSEntranceSourceLoader
//
//  Created by sama 刘 on 2021/8/11.
//

#import "LRSEntranceSourceLoader.h"
#import <BlocksKit/NSArray+BlocksKit.h>
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/SDWebImageManager.h>
#import "LRSEntranceSourceLoaderView.h"
#import "NSString+LRSEntranceURLParas.h"

static int64_t kLRSEntranceSourceVersion = 1000000;
typedef void(^LRSEntranceSourceLoaderProgressBlock)(CGFloat progress);

@implementation LRSEntranceSourceLoader

+ (NSArray<NSString *> *)filterRemoteConfigures:(NSArray<NSString *> *)URLs {
    return [URLs bk_select:^BOOL(NSString *obj) {
        if (![obj lrs_entrance_validURL]) {
            return false;
        }
        return ![self diskImageDataExistsWithKey_:obj] || [self compareVersion:obj];
    }];
}

+ (BOOL)compareVersion:(NSString *)url {
    NSDictionary *parameter = [url lrs_entrance_parameters];
    return [parameter[@"jmv"] longLongValue] > kLRSEntranceSourceVersion;
}

+ (void)loadEntranceSourceLoaderViewWithBuilder:(void (^)(LRSEntranceSourceLoadViewConfigure * _Nonnull))builder {
    LRSEntranceSourceLoadViewConfigure *configure = [[LRSEntranceSourceLoadViewConfigure alloc] init];
    builder(configure);
    LRSEntranceSourceLoaderView *view = [[LRSEntranceSourceLoaderView alloc] initWithFrame:(CGRectZero)];
    view.progress = configure.originProgress;
    [configure.superView ?: [UIApplication sharedApplication].delegate.window addSubview:view];
    NSDate *start = [NSDate date];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self downloadSources:configure.sourceURLs originProgress:configure.originProgress progress:^(CGFloat progress) {
            view.progress = progress;
        } complete:^(BOOL success, NSError * _Nullable error) {
            NSTimeInterval timeLose = [[NSDate date] timeIntervalSinceDate:start];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MAX(0, configure.minDuration - timeLose) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [view removeFromSuperviewWithAnimation:true];
            });
        }];
    });
}

+ (void)downloadSources:(NSArray<NSString *> *)source
         originProgress:(CGFloat)originProgress
               progress:(LRSEntranceSourceLoaderProgressBlock)progressBlock
               complete:(LRSEntranceSourceLoaderResult)end {
    [self downloadSources:source
           originProgress:originProgress
                 progress:progressBlock
                 complete:end
               retryIndex:0];
}

+ (void)downloadSources:(NSArray<NSString *> *)source
         originProgress:(CGFloat)originProgress
               progress:(LRSEntranceSourceLoaderProgressBlock)progressBlock
               complete:(LRSEntranceSourceLoaderResult)end
             retryIndex:(NSInteger)index {
    NSInteger next = index + 1;
    if (index >= 10) {
        end(false, [NSError errorWithDomain:@"com.jiamian.error.LRSEntranceSource" code:-998 userInfo:@{
            NSLocalizedDescriptionKey: @"资源下载失败次数过多，请检查网络设置"
        }]);
        return;
    }
    if (source.count <= 0) {
        end(true, nil);
    }
    __block NSInteger downloadCount = 0;
    NSMutableArray *errorSource = [NSMutableArray arrayWithCapacity:0];
    __block CGFloat progress = originProgress;
    CGFloat percent = (1 - progress) / source.count;
    for (NSString *imageURL in source) {
        if ([self diskImageDataExistsWithKey_:imageURL] || (![imageURL containsString:@"://"])) {
            progress += percent;
            downloadCount ++;
            if (downloadCount == source.count) {
                if (progressBlock) {
                    progressBlock(progress);
                }
                if (errorSource.count == 0) {
                    progress = 1;
                    if (end) {
                        end(true, nil);
                    }
                } else {
                    [self downloadSources:[errorSource copy] originProgress:progress progress:progressBlock complete:end retryIndex:next];
                }
            } else {
                if (progressBlock) {
                    progressBlock(progress);
                }
            }
        } else {
            NSLog(@"download imageURL:%@", imageURL);
            [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:imageURL] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable url) {
                if (finished) {
                    if (!error && image) {
                        [[SDWebImageManager sharedManager].imageCache storeImage:image imageData:data forKey:imageURL cacheType:(SDImageCacheTypeAll) completion:^{
                            progress += percent;
                            if (progressBlock) {
                                progressBlock(progress);
                            }
                        }];
                    } else {
                        [errorSource addObject:imageURL];
                        NSLog(@"error %@ | %@", error.localizedDescription, url);
                    }
                }
                downloadCount ++;
                if (downloadCount == source.count) {
                    if (errorSource.count == 0) {
                        progress = 1;
                        if (progressBlock) {
                            progressBlock(progress);
                        }
                        end(true, nil);
                    } else {
                        [self downloadSources:[errorSource copy] originProgress:progress progress:progressBlock complete:end retryIndex:next];
                    }
                }
            }];
        }
    }
}


+ (UIImage *)imageFromDiskCacheForKey_:(NSString *)key {
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:key];
    return image;
}

+ (BOOL)diskImageDataExistsWithKey_:(NSString *)key {
    return [[SDImageCache sharedImageCache] diskImageDataExistsWithKey:key];
}

@end

