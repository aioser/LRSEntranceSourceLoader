//
//  LRSGameOpeningInfoRes.m
//  LRSGameOpeningInfoRes
//
//  Created by sama 刘 on 2021/8/12.
//

#import "LRSGameOpeningInfoRes.h"
#import "LRSEntranceSourceLoader.h"
#import "UIImage+LRSEntranceLoader.h"

@implementation LRSGameOpeningInfoRes

- (void)checkVersionForKey:(NSString *)keyPath placeholderValue:(NSString *)placeholder {
    NSString *value = [self valueForKey:keyPath];
    if (value && ![LRSEntranceSourceLoader compareVersion:value] && [UIImage entrance_imageNamed:placeholder]) {
        [self setValue:placeholder forKey:keyPath];
    }
}

- (NSString<Ignore> *)pk {
    return [@(self.gameRoomType) stringValue];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

+ (NSString *)modeNameWithType:(NSInteger)roomType name:(NSString *)name{
    if (roomType == 0) {
        return @"简单模式";
    } else if (roomType == 1) {
        return [NSString stringWithFormat:@"进阶(%@)模式", name];
    } else if (roomType == 2 ) {
        return [NSString stringWithFormat:@"娱乐(%@)模式", name];
    } else {
        BOOL hasModeSuffix = [name respondsToSelector:@selector(hasSuffix:)] && [name hasSuffix:@"模式"];
        return [NSString stringWithFormat:@"%@%@",name,(hasModeSuffix ? @"" : @"模式")];
    }
}

- (NSString<Ignore> *)modeName {
    if (!_modeName) {
        _modeName = [LRSGameOpeningInfoRes modeNameWithType:self.roomType name:self.name];
    }
    return _modeName;
}

@end
