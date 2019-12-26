//
//  PDListAdapter+Internal.h
//  PDList
//
//  Created by liang on 2019/12/26.
//  Copyright © 2019 PipeDog. All rights reserved.
//

#import "PDListAdapter.h"

@class PDListSectionController;

NS_ASSUME_NONNULL_BEGIN

@interface PDListAdapter ()

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, PDListSectionController *> *sectionControllers;

@end

NS_ASSUME_NONNULL_END
