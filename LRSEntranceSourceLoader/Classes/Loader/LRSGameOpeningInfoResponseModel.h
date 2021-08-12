//
//  LRSGameOpeningInfoResponseModel.h
//  LRSGameOpeningInfoResponseModel
//
//  Created by sama 刘 on 2021/8/12.
//

#import <JSONModel/JSONModel.h>
#import "LRSGameOpeningInfoRes.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameOpeningInfoRootModelConfigure : JSONModel

@property (nonatomic, strong) NSArray<LRSGameOpeningInfoRes, Optional> *gamePatternConfigs;
@property (nonatomic, strong) NSString *coverUrl;

@end

@interface GameOpeningInfoRootModel : JSONModel

@property (nonatomic, strong) GameOpeningInfoRootModelConfigure *simpleGames;
@property (nonatomic, strong) GameOpeningInfoRootModelConfigure *recreationGames;
@property (nonatomic, strong) GameOpeningInfoRootModelConfigure *standardGames;

@end

@interface LRSGameOpeningInfoResponseModel : JSONModel

@property (nonatomic, strong) GameOpeningInfoRootModel *result;

- (void)configurePlaceHolderSource;

@end

NS_ASSUME_NONNULL_END
