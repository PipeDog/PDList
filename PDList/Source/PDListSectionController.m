//
//  PDListSectionController.m
//  PDList
//
//  Created by liang on 2018/3/20.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "PDListSectionController.h"

@implementation PDListSectionController

- (void)dealloc {
#ifdef DEBUG
    NSLog(@"%@ dealloc.", self);
#endif
}

- (NSInteger)numberOfRowsInSectionController:(PDListSectionController *)sectionController {
    NSAssert(NO, @"This method must be override, (%s).", __FUNCTION__);
    return 0;
}

- (UITableViewCell *)sectionController:(__kindof PDListSectionController *)sectionController cellForRowAtIndex:(NSInteger)index {
    NSAssert(NO, @"This method must be override, (%s).", __FUNCTION__);
    return nil;
}

@end
