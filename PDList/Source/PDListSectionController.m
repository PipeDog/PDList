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
- (UITableViewCell *)dequeueReusableCellWithStyle:(UITableViewCellStyle)style forClass:(Class)aClass {
    NSString *cellIdentifier = [NSString stringWithFormat:@"%@_%@", aClass, [NSNumber numberWithInteger:style]];
    UITableViewCell *cell = [self.listAdapter.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[aClass alloc] initWithStyle:style reuseIdentifier:cellIdentifier];
    }
    PDAssert(cell, @"Cell can not be null!");
    return cell;
}

- (UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewForClass:(Class)aClass {
    NSString *sectionViewIdentifier = NSStringFromClass(aClass);
    UITableViewHeaderFooterView *sectionView = [self.listAdapter.tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionViewIdentifier];
    if (!sectionView) {
        sectionView = [[aClass alloc] initWithReuseIdentifier:sectionViewIdentifier];
    }
    PDAssert(sectionView, @"SectionView can not be null!");
    return sectionView;
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
    PDAssert(NO, @"This method must be override, (%s).", __FUNCTION__);
}

@end
