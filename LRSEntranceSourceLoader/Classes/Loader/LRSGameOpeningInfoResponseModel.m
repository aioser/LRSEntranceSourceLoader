//
//  LRSGameOpeningInfoResponseModel.m
//  LRSGameOpeningInfoResponseModel
//
//  Created by sama 刘 on 2021/8/12.
//

#import "LRSGameOpeningInfoResponseModel.h"
#import <BlocksKit/NSArray+BlocksKit.h>
#import "LRSEntranceSourceLoader.h"
#import "UIImage+LRSEntranceLoader.h"

typedef NS_ENUM(NSInteger, LRSGameRoomType) {
    LRSSimpleGameRoom = 0,
    LRSStandardCupidGameRoom = 1,
    LRSStandardIdiotGameRoom = 2,
    LRSStandardBomerGameRoom = 3,
    LRSStandardWolfKingGameRoom = 4,
    LRSSimpleWolfEscapeGameRoom = 5,
    LRSSimpleZooGameRoom = 6,
    LRSSimpleFiveGoldBattle = 14
};

@implementation LRSGameOpeningInfoResponseModel

- (void)configurePlaceHolderSource {
    GameOpeningInfoRootModelConfigure *simpleGames = self.result.simpleGames;
    GameOpeningInfoRootModelConfigure *recreationGames = self.result.recreationGames;
    GameOpeningInfoRootModelConfigure *standardGames = self.result.standardGames;
    [LRSGameOpeningInfoResponseModel checkCoverImage:simpleGames local:@"home_simple"];
    [LRSGameOpeningInfoResponseModel checkCoverImage:standardGames local:@"home_standard"];
    [LRSGameOpeningInfoResponseModel checkCoverImage:recreationGames local:@"home_entertainment"];
    
    [LRSGameOpeningInfoResponseModel checkGamePatternConfigs:simpleGames];
    [LRSGameOpeningInfoResponseModel checkGamePatternConfigs:standardGames];
    [LRSGameOpeningInfoResponseModel checkGamePatternConfigs:recreationGames];
}

+ (void)checkCoverImage:(GameOpeningInfoRootModelConfigure *)source local:(NSString *)localName {
    if (![LRSEntranceSourceLoader compareVersion:source.coverUrl] && [UIImage entrance_imageNamed:localName]) {
        source.coverUrl = localName;
    }
}

+ (void)checkGamePatternConfigs:(GameOpeningInfoRootModelConfigure *)source {
    static NSDictionary *boardMapper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        boardMapper = @{
            [@(LRSSimpleGameRoom) stringValue]: @"simple",
            
            [@(LRSStandardCupidGameRoom) stringValue]: @"cupid",
            [@(LRSStandardBomerGameRoom) stringValue]: @"bomber",
            [@(LRSStandardIdiotGameRoom) stringValue]: @"idiot",
            [@(LRSStandardWolfKingGameRoom) stringValue]: @"guard",
            
            [@(LRSSimpleWolfEscapeGameRoom) stringValue]: @"wolfrun",
            [@(LRSSimpleZooGameRoom) stringValue]: @"zoo",
            [@(LRSSimpleFiveGoldBattle) stringValue]: @"newyearfight",
        };
    });
    [source.gamePatternConfigs bk_each:^(LRSGameOpeningInfoRes *openInfo) {
        NSString *name = boardMapper[[NSString stringWithFormat:@"%lld", openInfo.gameRoomType]];
        [openInfo checkVersionForKey:@"evenPic" placeholderValue:[NSString stringWithFormat:@"board_%@_1", name]];
        [openInfo checkVersionForKey:@"oddPic" placeholderValue:[NSString stringWithFormat:@"board_%@_2", name]];
        
        [openInfo checkVersionForKey:@"evenMask" placeholderValue:[NSString stringWithFormat:@"board_%@_1_mask", name]];
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
