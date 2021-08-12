//
//  LRSEntranceSourceLoader.h
//  LRSEntranceSourceLoader
//
//  Created by sama 刘 on 2021/8/11.
//

#import <Foundation/Foundation.h>
#import "LRSEntranceSourceLoadViewConfigure.h"

NS_ASSUME_NONNULL_BEGIN
@interface LRSEntranceSourceLoader : NSObject

+ (NSArray<NSString *> *)filterRemoteConfigures:(NSArray <NSString *> *)URLs;

+ (void)loadEntranceSourceLoaderViewWithBuilder:(void(^)(LRSEntranceSourceLoadViewConfigure *configure))builder;

+ (BOOL)compareVersion:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
