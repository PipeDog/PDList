//
//  PDListAdapter+UITableView.m
//  PDList
//
//  Created by liang on 2018/3/21.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "PDListAdapter+UITableView.h"
#import "PDListAdapter+Internal.h"
#import "PDListSectionController.h"
#import "PDListSectionController+Internal.h"

static CGFloat const kUITableViewCellDefaultHeight = 44.f;

@implementation PDListAdapter (UITableViewDataSource)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.dataSource) return 0;
    if (![self.dataSource respondsToSelector:@selector(numberOfSectionControllersForListAdapter:)]) return 0;
    
    return [self.dataSource numberOfSectionControllersForListAdapter:self];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PDListSectionController *sectionController = [self sectionControllerForSection:section];
    return [sectionController numberOfRows];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDListSectionController *sectionController = [self sectionControllerForSection:indexPath.section];
    return [sectionController cellForRowAtIndex:indexPath.row];
}
#pragma clang diagnostic pop

// Get sectionController from self.sectionControllers with section, if failed, get from dataSource method <listAdapter:sectionControllerForSection:> again.
- (PDListSectionController *)sectionControllerForSection:(NSInteger)section {
    // At `PDListSectionController.m`
    extern void PDListSectionControllerPushThread(id<PDListUpdater>, id<PDListTableContext>, NSInteger);
    extern void PDListSectionControllerPopThread(void);

    PDListSectionController *sectionController = [self.sectionControllers objectForKey:@(section)];
    if (!sectionController) {
        PDListSectionControllerPushThread(self, self, section);
        sectionController = [self.dataSource listAdapter:self sectionControllerForSection:section];
        self.sectionControllers[@(section)] = sectionController;
        PDListSectionControllerPopThread();
    }

    if (sectionController.section != section) {
        PDListSectionControllerPushThread(self, self, section);
        [sectionController _threadContextDidUpdate];
        PDListSectionControllerPopThread();
    }

    return sectionController;
}

@end

@implementation PDListAdapter (UITableViewDelegate)

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDListSectionController *sectionController = [self sectionControllerForSection:indexPath.section];
    if ([sectionController respondsToSelector:@selector(heightForRowAtIndex:)]) {
        return [sectionController heightForRowAtIndex:indexPath.row];
    }
    return kUITableViewCellDefaultHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    PDListSectionController *sectionController = [self sectionControllerForSection:section];
    if ([sectionController respondsToSelector:@selector(heightForHeader)]) {
        return [sectionController heightForHeader];
    }
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    PDListSectionController *sectionController = [self sectionControllerForSection:section];
    if ([sectionController respondsToSelector:@selector(heightForFooter)]) {
        return [sectionController heightForFooter];
    }
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PDListSectionController *sectionController = [self sectionControllerForSection:section];
    if ([sectionController respondsToSelector:@selector(viewForHeader)]) {
        return [sectionController viewForHeader];
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    PDListSectionController *sectionController = [self sectionControllerForSection:section];
    if ([sectionController respondsToSelector:@selector(viewForFooter)]) {
        return [sectionController viewForFooter];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    PDListSectionController *sectionController = [self sectionControllerForSection:indexPath.section];
    if ([sectionController respondsToSelector:@selector(didSelectRowAtIndex:)]) {
        [sectionController didSelectRowAtIndex:indexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    PDListSectionController *sectionController = [self sectionControllerForSection:indexPath.section];
    if ([sectionController respondsToSelector:@selector(willDisplayCell:forRowAtIndex:)]) {
        [sectionController willDisplayCell:cell forRowAtIndex:indexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!(indexPath.section < self.sectionControllers.count)) {
        // Tells the delegate that the specified cell was removed from the table.
        return;
    }
    PDListSectionController *sectionController = [self sectionControllerForSection:indexPath.section];
    if ([sectionController respondsToSelector:@selector(didEndDisplayingCell:forRowAtIndex:)]) {
        [sectionController didEndDisplayingCell:cell forRowAtIndex:indexPath.row];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    PDListSectionController *sectionController = [self sectionControllerForSection:indexPath.section];
    if ([sectionController respondsToSelector:@selector(canEditRowAtIndex:)]) {
        return [sectionController canEditRowAtIndex:indexPath.row];
    }
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDListSectionController *sectionController = [self sectionControllerForSection:indexPath.section];
    if ([sectionController respondsToSelector:@selector(editingStyleAtIndex:)]) {
        return [sectionController editingStyleAtIndex:indexPath.row];
    }
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    PDListSectionController *sectionController = [self sectionControllerForSection:indexPath.section];
    if ([sectionController respondsToSelector:@selector(commitEditingStyle:forRowAtIndex:)]) {
        [sectionController commitEditingStyle:editingStyle forRowAtIndex:indexPath.row];
    }
}

@end

@implementation PDListAdapter (UIScrollViewDelegate)

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    id<UIScrollViewDelegate> scrollDelegate = self.scrollDelegate;
    if ([scrollDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [scrollDelegate scrollViewDidScroll:scrollView];
    }
    
    NSArray<PDListSectionController *> *visibleSectionControllers = [self visibleSectionControllers];
    for (PDListSectionController *sectionController in visibleSectionControllers) {
        if ([sectionController respondsToSelector:@selector(scrollViewDidScroll:)]) {
            [sectionController scrollViewDidScroll:scrollView];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    id<UIScrollViewDelegate> scrollDelegate = self.scrollDelegate;
    if ([scrollDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [scrollDelegate scrollViewWillBeginDragging:scrollView];
    }
    
    NSArray<PDListSectionController *> *visibleSectionControllers = [self visibleSectionControllers];
    for (PDListSectionController *sectionController in visibleSectionControllers) {
        if ([sectionController respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
            [sectionController scrollViewWillBeginDragging:scrollView];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    id<UIScrollViewDelegate> scrollDelegate = self.scrollDelegate;
    if ([scrollDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [scrollDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
    
    NSArray<PDListSectionController *> *visibleSectionControllers = [self visibleSectionControllers];
    for (PDListSectionController *sectionController in visibleSectionControllers) {
        if ([sectionController respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
            [sectionController scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    id<UIScrollViewDelegate> scrollDelegate = self.scrollDelegate;
    if ([scrollDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [scrollDelegate scrollViewDidEndDecelerating:scrollView];
    }
    
    NSArray<PDListSectionController *> *visibleSectionControllers = [self visibleSectionControllers];
    for (PDListSectionController *sectionController in visibleSectionControllers) {
        if ([sectionController respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
            [sectionController scrollViewDidEndDecelerating:scrollView];
        }
    }
}

@end
