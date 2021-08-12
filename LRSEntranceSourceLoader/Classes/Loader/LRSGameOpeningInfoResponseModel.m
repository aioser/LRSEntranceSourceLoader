//
//  LRSGameOpeningInfoResponseModel.m
//  LRSGameOpeningInfoResponseModel
//
//  Created by sama 刘 on 2021/8/12.
//

#import "LRSGameOpeningInfoResponseModel.h"
#import <BlocksKit/NSArray+BlocksKit.h>
#import "LRSEntranceSourceLoader.h"

typedef NS_ENUM(NSInteger, LRSGameRoomType) {
    SimpleGameRoom = 0,
    StandardCupidGameRoom = 1,
    StandardIdiotGameRoom = 2,
    StandardBomerGameRoom = 3,
    StandardWolfKingGameRoom = 4,
    SimpleWolfEscapeGameRoom = 5,
    SimpleZooGameRoom = 6,
    SimpleFiveGoldBattle = 12
};

@implementation LRSGameOpeningInfoResponseModel

- (void)configurePlaceHolderSource {
    GameOpeningInfoRootModelConfigure *simpleGames = self.result.simpleGames;
    GameOpeningInfoRootModelConfigure *recreationGames = self.result.recreationGames;
    GameOpeningInfoRootModelConfigure *standardGames = self.result.standardGames;
    [LRSGameOpeningInfoResponseModel checkCoverImage:simpleGames local:@"home_simple"];
    [LRSGameOpeningInfoResponseModel checkCoverImage:standardGames local:@"home_standard"];
    [LRSGameOpeningInfoResponseModel checkCoverImage:recreationGames local:@"home_entertainment"];
}

+ (void)checkCoverImage:(GameOpeningInfoRootModelConfigure *)source local:(NSString *)localName {
    if (![LRSEntranceSourceLoader compareVersion:source.coverUrl]) {
        source.coverUrl = localName;
    }
}

+ (void)checkGamePatternConfigs:(GameOpeningInfoRootModelConfigure *)source {
    __block NSDictionary *boardMapper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        boardMapper = @{
            @(SimpleGameRoom): @"simple",
            
            @(StandardCupidGameRoom): @"cupid",
            @(StandardBomerGameRoom): @"bomber",
            @(StandardIdiotGameRoom): @"idiot",
            @(StandardWolfKingGameRoom): @"guard",
            
            @(SimpleWolfEscapeGameRoom): @"wolfrun",
            @(SimpleZooGameRoom): @"zoo",
            @(SimpleFiveGoldBattle): @"newyearfight",
        };
    });
    [source.gamePatternConfigs bk_each:^(LRSGameOpeningInfoRes *openInfo) {
        NSString *name = boardMapper[@(openInfo.gameRoomType)];
        [openInfo checkVersionForKey:@"evenPic" placeholderValue:[NSString stringWithFormat:@"board_%@_1", name]];
        [openInfo checkVersionForKey:@"oddPic" placeholderValue:[NSString stringWithFormat:@"board_%@_2", name]];
        
        [openInfo checkVersionForKey:@"evenMask" placeholderValue:[NSString stringWithFormat:@"board_%@_1_make", name]];
        [openInfo checkVersionForKey:@"oddMask" placeholderValue:[NSString stringWithFormat:@"board_%@_2_mask", name]];
        
        [openInfo checkVersionForKey:@"followIcon" placeholderValue:[NSString stringWithFormat:@"ic_follow_%@", name]];
        
        [openInfo checkVersionForKey:@"rulePicOne" placeholderValue:[NSString stringWithFormat:@"pic_guide_%@_1", name]];
        [openInfo checkVersionForKey:@"rulePicTwo" placeholderValue:[NSString stringWithFormat:@"pic_guide_%@_2", name]];
        [openInfo checkVersionForKey:@"rulePicThree" placeholderValue:[NSString stringWithFormat:@"pic_guide_%@_3", name]];
        
        if ([name isEqualToString:@"simple"]) {
            [openInfo checkVersionForKey:@"tutorialPic" placeholderValue:@"help_simple_text"];
        } else {
            if ([@[@"cupid", @"bomber", @"idiot", @"guard"] containsObject:name]) {
                [openInfo checkVersionForKey:@"tutorialPic" placeholderValue:@"help_ordinary_text"];
            } else {
                [openInfo checkVersionForKey:@"tutorialPic" placeholderValue:[NSString stringWithFormat:@"help_%@_text", name]];
            }
        }
    }];
}

@end

@implementation GameOpeningInfoRootModel

@end

@implementation GameOpeningInfoRootModelConfigure


@end
