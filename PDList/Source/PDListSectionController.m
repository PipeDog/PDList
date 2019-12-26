//
//  PDListSectionController.m
//  PDList
//
//  Created by liang on 2018/3/20.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "PDListSectionController.h"
#import "PDListAssert.h"
#import "PDListSectionController+Internal.h"

@implementation PDListSectionController

- (void)dealloc {
#ifdef DEBUG
    NSLog(@"%@ dealloc.", self);
#endif
}

- (NSInteger)numberOfRows {
    PDAssert(NO, @"This method must be override, (%s).", __FUNCTION__);
    return 0;
}

- (UITableViewCell *)cellForRowAtIndex:(NSInteger)index {
    PDAssert(NO, @"This method must be override, (%s).", __FUNCTION__);
    return nil;
}

#pragma mark - PDListSectionControllerOverride
- (void)didUpdateToObject:(id)object {
    PDAssert(NO, @"This method must be override, (%s).", __FUNCTION__);
}

#pragma mark - Private Methods
- (void)_updateConfiguration:(id<PDListSectionControllerConfiguration>)configuration {
    PDAssert(configuration, @"Arg `configuration` can not be nil!");
    
    _section = configuration.section;
    _updater = configuration.updater;
    _tableContext = configuration.tableContext;
}

@end
