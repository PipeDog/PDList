//
//  PDListSectionController.m
//  PDList
//
//  Created by liang on 2018/3/20.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "PDListSectionController.h"
#import "PDListAssert.h"

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

#pragma mark - PDListSectionController
- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    return [self.listAdapter.tableView dequeueReusableCellWithIdentifier:identifier];
}

- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:self.section];
    return [self.listAdapter.tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewWithIdentifier:(NSString *)identifier {
    return [self.listAdapter.tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
}

- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier {
    [self.listAdapter.tableView registerNib:nil forCellReuseIdentifier:identifier];
}

- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
    [self.listAdapter.tableView registerClass:cellClass forCellReuseIdentifier:identifier];
}

- (void)registerNib:(UINib *)nib forHeaderFooterViewReuseIdentifier:(NSString *)identifier {
    [self.listAdapter.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:identifier];
}

- (void)registerClass:(Class)aClass forHeaderFooterViewReuseIdentifier:(NSString *)identifier {
    [self.listAdapter.tableView registerClass:aClass forHeaderFooterViewReuseIdentifier:identifier];
}

- (void)reloadData {
    PDAssertMainThread();
    
    [self.listAdapter reloadSections:[NSIndexSet indexSetWithIndex:self.section] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)reloadRows:(NSArray<NSNumber *> *)rows withRowAnimation:(UITableViewRowAnimation)animation {
    PDAssertMainThread();
    
    NSMutableArray<NSIndexPath *> *indexPaths = [NSMutableArray array];

    for (NSNumber *row in rows) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[row integerValue] inSection:self.section];
        [indexPaths addObject:indexPath];
    }
    [self.listAdapter.tableView reloadRowsAtIndexPaths:[indexPaths copy] withRowAnimation:animation];
}

#pragma mark - PDListSectionControllerOverride
- (void)didUpdateToObject:(id)object {
    
}

#pragma mark - Setter Methods
- (void)setObject:(id)object {
    _object = object;
    [self didUpdateToObject:_object];
}

@end
