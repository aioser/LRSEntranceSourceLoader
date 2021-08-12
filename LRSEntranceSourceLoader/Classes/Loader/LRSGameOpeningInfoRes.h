//
//  LRSGameOpeningInfoRes.h
//  LRSGameOpeningInfoRes
//
//  Created by sama 刘 on 2021/8/12.
//

#import <JSONModel/JSONModel.h>

typedef NS_ENUM(NSInteger, LRSRoomEngineType) {
    LRSRoomEngineTypeUnkown = -1,
    LRSRoomEngineTypeNative = 0,
    LRSRoomEngineTypeCocos = 1,
};


NS_ASSUME_NONNULL_BEGIN

@protocol LRSGameOpeningInfoRes <NSObject>

@end

@interface LRSGameOpeningInfoRes : JSONModel

@property (nonatomic, strong) NSString *content;

/// 教程pic
@property (nonatomic, strong) NSString *tutorialPic;

/// 新手帮助123pic
@property (nonatomic, strong) NSString *rulePicOne;
@property (nonatomic, strong) NSString *rulePicTwo;
@property (nonatomic, strong) NSString *rulePicThree;


/// 游戏模式选择单双数图片和遮罩
@property (nonatomic, strong) NSString *evenMask;
@property (nonatomic, strong) NSString *oddMask;
@property (nonatomic, strong) NSString *evenPic;
@property (nonatomic, strong) NSString *oddPic;

@property (nonatomic, assign) LRSRoomEngineType frameType; // 0: 原生游戏  1: COCOS GAME
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger gameRoomType;
@property (nonatomic, assign) BOOL opening;
@property (nonatomic, assign) BOOL limit;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, strong) NSString *followIcon;

@property (nonatomic) NSInteger roomType; // 0: 简单, 1: 进阶, 2: 娱乐
@property (nonatomic, strong) NSString<Ignore> *pk;
@property (nonatomic, strong) NSString<Ignore> *modeName;

- (void)checkVersionForKey:(NSString *)keyPath placeholderValue:(NSString *)placeholder;
@end


NS_ASSUME_NONNULL_END
