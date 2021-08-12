//
//  LRSGameOpeningInfoRes.m
//  LRSGameOpeningInfoRes
//
//  Created by sama 刘 on 2021/8/12.
//

#import "LRSGameOpeningInfoRes.h"
#import "LRSEntranceSourceLoader.h"

@implementation LRSGameOpeningInfoRes

- (void)checkVersionForKey:(NSString *)keyPath placeholderValue:(NSString *)placeholder {
    NSString *value = [self valueForKey:keyPath];
    if (value && ![LRSEntranceSourceLoader compareVersion:value]) {
        [self setValue:placeholder forKey:keyPath];
    }
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return [propertyName isEqualToString:@"roomType"];
}

@end
