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

@implementation PDListAdapter

@synthesize sectionControllers = _sectionControllers;

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        self.tableView = tableView;
    }
    return self;
}

#pragma mark - PDListUpdater Methods
- (void)reloadData {
    PDAssertMainThread();
    
    [self.sectionControllers removeAllObjects];
    [self.tableView reloadData];
}

- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    PDAssertMainThread();
    
    for (NSInteger section = sections.firstIndex; section <= sections.lastIndex; section ++) {
        [self.sectionControllers removeObjectForKey:@(section)];
    }
    [self.tableView reloadSections:sections withRowAnimation:animation];
}

- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    PDAssertMainThread();

    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

#pragma mark - Setter Methods
- (void)setTableView:(UITableView *)tableView {
    _tableView = tableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
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
        PDAssert(sectionController != nil, @"Section controller nil for cell in section %zd", indexPath.section);
        if (sectionController) {
            [visibleSectionControllers addObject:sectionController];
        }
    }
    return [visibleSectionControllers allObjects];
}

@end
