//
//  LRSEntranceSourceLoadViewConfigure.h
//  LRSEntranceSourceLoadViewConfigure
//
//  Created by sama 刘 on 2021/8/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LRSEntranceSourceLoaderResult)(BOOL success, NSError * _Nullable error);

@interface LRSEntranceSourceLoadViewConfigure : NSObject
@property (nonatomic) CGFloat originProgress;
@property (nonatomic) CGFloat minDuration;
@property (nonatomic, weak) UIView *superView;
@property (nonatomic, strong) NSArray <NSString *> *sourceURLs;
@property (nonatomic, copy) LRSEntranceSourceLoaderResult result;
@end

NS_ASSUME_NONNULL_END
