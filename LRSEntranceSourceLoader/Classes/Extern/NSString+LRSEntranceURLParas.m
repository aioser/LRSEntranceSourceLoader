//
//  NSString+LRSEntranceURLParas.m
//  LRSEntranceURLParas
//
//  Created by sama 刘 on 2021/8/12.
//

#import "NSString+LRSEntranceURLParas.h"

@implementation NSString (LRSEntranceURLParas)

- (NSDictionary *)lrs_entrance_parameters {
    NSMutableDictionary * paramters = [NSMutableDictionary dictionary];
    
    NSURLComponents *components = [NSURLComponents componentsWithString:self];
    [components.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        paramters[obj.name] = obj.value;
    }];
    return [paramters copy];
}

- (BOOL)lrs_entrance_validURL {
    return [self containsString:@"http"] && [self containsString:@"://"];
}

@end
