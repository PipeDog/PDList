//
//  PDListSectionController+Internal.h
//  PDList
//
//  Created by liang on 2019/12/26.
//  Copyright © 2019 PipeDog. All rights reserved.
//

#import "PDListSectionController.h"
#import "PDListSectionControllerConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@interface PDListSectionController ()

- (void)_updateConfiguration:(id<PDListSectionControllerConfiguration>)configuration;

@end

NS_ASSUME_NONNULL_END
