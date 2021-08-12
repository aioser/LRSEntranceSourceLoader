//
//  NSString+LRSEntranceURLParas.h
//  LRSEntranceURLParas
//
//  Created by sama 刘 on 2021/8/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LRSEntranceURLParas)
- (NSDictionary * _Nullable)lrs_entrance_parameters;
- (BOOL)lrs_entrance_validURL;
@end

NS_ASSUME_NONNULL_END
