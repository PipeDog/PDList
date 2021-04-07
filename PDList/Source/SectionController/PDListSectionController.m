//
//  PDListSectionController.m
//  PDList
//
//  Created by liang on 2018/3/20.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "PDListSectionController.h"
#import "PDListAssert.h"

static NSString *const kPDListSectionControllerContextStackKey = @"kPDListSectionControllerContextStackKey";

@interface PDListSectionControllerThreadContext : NSObject

@property (nonatomic, weak) id<PDListUpdater> updater;
@property (nonatomic, weak) id<PDListTableContext> tableContext;
@property (nonatomic, assign) NSInteger section;

@end

@implementation PDListSectionControllerThreadContext

- (instancetype)init {
    self = [super init];
    if (self) {
        _section = NSNotFound;
    }
    return self;
}

@end

static NSMutableArray<PDListSectionControllerThreadContext *> *threadContextStack(void) {
    PDAssertMainThread();
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSMutableArray *stack = threadDictionary[kPDListSectionControllerContextStackKey];
    if (!stack) {
        stack = [NSMutableArray array];
        threadDictionary[kPDListSectionControllerContextStackKey] = stack;
    }
    return stack;
}

static PDListSectionControllerThreadContext *PDListSectionControllerTopThread(void) {
    NSMutableArray *stack = threadContextStack();
    return stack.lastObject;
}

void PDListSectionControllerPushThread(id<PDListUpdater> updater, id<PDListTableContext> tableContext, NSInteger section) {
    PDListSectionControllerThreadContext *context = [[PDListSectionControllerThreadContext alloc] init];
    context.updater = updater;
    context.tableContext = tableContext;
    context.section = section;
    [threadContextStack() addObject:context];
}

void PDListSectionControllerPopThread(void) {
    NSMutableArray *stack = threadContextStack();
    [stack removeLastObject];
}

@implementation PDListSectionController

- (void)dealloc {
#ifdef DEBUG
    NSLog(@"%@ dealloc.", self);
#endif
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self _threadContextDidUpdate];
    }
    return self;
}

- (void)_threadContextDidUpdate {
    PDListSectionControllerThreadContext *context = PDListSectionControllerTopThread();
    _updater = context.updater;
    _tableContext = context.tableContext;
    _section = context ? context.section : NSNotFound;
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

@end
