//
//  PDListSectionControllerConfiguration.h
//  PDList
//
//  Created by liang on 2019/12/26.
//  Copyright © 2019 PipeDog. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PDListUpdater;
@protocol PDListTableContext;

NS_ASSUME_NONNULL_BEGIN

@protocol PDListSectionControllerConfiguration <NSObject>

@property (nonatomic, assign) NSInteger section;
@property (nonatomic, weak) id<PDListUpdater> updater;
@property (nonatomic, weak) id<PDListTableContext> tableContext;

@end

@interface PDListSectionControllerConfiguration : NSObject <PDListSectionControllerConfiguration>

@end

NS_ASSUME_NONNULL_END
