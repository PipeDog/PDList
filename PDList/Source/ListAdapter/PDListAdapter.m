//
//  PDListAdapter.m
//  PDList
//
//  Created by liang on 2018/3/20.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "PDListAdapter.h"
#import "PDListAdapter+UITableView.h"
#import "PDListAssert.h"
#import "PDListSectionController.h"
#import "PDListAdapter+Internal.h"

@interface PDListAdapter ()

@property (nonatomic, strong) UIView *emptyView;

@end

@implementation PDListAdapter

- (instancetype)init {
    UITableView *tableView;
    return [self initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        PDAssert(tableView, @"Arg `tableView` can not be nil!");

        _tableView = tableView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return self;
}

#pragma mark - PDListUpdater Methods
- (void)reloadData {
    PDAssertMainThread();
    
    [self addEmptyViewIfNecessary];
    [self.sectionControllers removeAllObjects];
    [self.tableView reloadData];
}

- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    PDAssertMainThread();
    
    [self addEmptyViewIfNecessary];
    
    for (NSInteger section = sections.firstIndex; section <= sections.lastIndex; section ++) {
        [self.sectionControllers removeObjectForKey:@(section)];
    }
    [self.tableView reloadSections:sections withRowAnimation:animation];
}

- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    PDAssertMainThread();

    [self addEmptyViewIfNecessary];
    
    for (NSIndexPath *indexPath in indexPaths) {
        [self.sectionControllers removeObjectForKey:@(indexPath.section)];
    }
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)performUpdateSectionControllers:(NSArray<PDListSectionController *> *)sectionControllers withRowAnimation:(UITableViewRowAnimation)animation {
    PDAssertMainThread();
    if (!sectionControllers.count) return;

    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    
    for (PDListSectionController *sectionController in sectionControllers) {
        if ([indexSet containsIndex:sectionController.section]) {
            continue;
        }
        [indexSet addIndex:sectionController.section];
    }
    [self reloadSections:indexSet withRowAnimation:animation];
}

- (void)performUpdateSectionController:(PDListSectionController *)sectionController atIndexs:(NSArray<NSNumber *> *)indexs withRowAnimation:(UITableViewRowAnimation)animation {
    PDAssertMainThread();
    if (!sectionController) return;
    if (![self.sectionControllers.allValues containsObject:sectionController]) return;

    NSMutableSet<NSIndexPath *> *indexPaths = [NSMutableSet set];
    NSInteger section = sectionController.section;
    
    for (NSNumber *index in indexs) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[index integerValue] inSection:section];
        [indexPaths addObject:indexPath];
    }
    [self reloadRowsAtIndexPaths:[indexPaths allObjects] withRowAnimation:animation];
}

- (void)addEmptyViewIfNecessary {
    if (![self.dataSource respondsToSelector:@selector(emptyViewForListAdapter:)]) return;
    
    if (_emptyView) {
        [_emptyView removeFromSuperview];
        _emptyView = nil;
    }
    
    if ([self.dataSource numberOfSectionControllersForListAdapter:self] <= 0) {
        self.emptyView = [self.dataSource emptyViewForListAdapter:self];
        self.emptyView.frame = self.tableView.bounds;
        [self.tableView addSubview:self.emptyView];
    }
}

#pragma mark - PDListTableContext Methods
- (UITableViewCell *)dequeueReusableCellWithStyle:(UITableViewCellStyle)style forClass:(Class)aClass {
    PDAssert(aClass, @"Arg `aClass` can not be nil!");
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"%@_%@", aClass, [NSNumber numberWithInteger:style]];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[aClass alloc] initWithStyle:style reuseIdentifier:cellIdentifier];
    }
    PDAssert(cell, @"Cell can not be null!");
    return cell;
}

- (UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewForClass:(Class)aClass {
    PDAssert(aClass, @"Arg `aClass` can not be nil!");

    NSString *sectionViewIdentifier = NSStringFromClass(aClass);
    UITableViewHeaderFooterView *sectionView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionViewIdentifier];
    if (!sectionView) {
        sectionView = [[aClass alloc] initWithReuseIdentifier:sectionViewIdentifier];
    }
    PDAssert(sectionView, @"SectionView can not be null!");
    return sectionView;
}

#pragma mark - Getter Methods
- (NSMutableDictionary<NSNumber *, PDListSectionController *> *)sectionControllers {
    if (!_sectionControllers) {
        _sectionControllers = [NSMutableDictionary dictionary];
    }
    return _sectionControllers;
}

- (UIViewController *)viewController {
    if (!_viewController) {
        UIResponder *responder = _tableView;

        while (responder) {
            if ([responder isKindOfClass:[UIViewController class]]) {
                return (UIViewController *)responder;
            }
            responder = [responder nextResponder];
        }
    }
    return _viewController;
}

- (NSArray<PDListSectionController *> *)visibleSectionControllers {
    PDAssertMainThread();
    
    NSMutableSet *visibleSectionControllers = [NSMutableSet new];
    NSArray<NSIndexPath *> *visibleIndexPaths = [self.tableView.indexPathsForVisibleRows copy];
    
    for (NSIndexPath *indexPath in visibleIndexPaths) {
        PDListSectionController *sectionController = [self.sectionControllers objectForKey:@(indexPath.section)];
        PDAssert(sectionController != nil, @"Section controller nil for cell in section %ld", (long)indexPath.section);
        if (sectionController) {
            [visibleSectionControllers addObject:sectionController];
        }
    }
    return [visibleSectionControllers allObjects];
}

@end
