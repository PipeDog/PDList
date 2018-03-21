//
//  PDListAdapter+UITableView.m
//  PDList
//
//  Created by liang on 2018/3/21.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "PDListAdapter+UITableView.h"
#import "PDListSectionController.h"

@implementation PDListAdapter (UITableViewDataSource)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.dataSource) return 0;
    if (![self.dataSource respondsToSelector:@selector(objectsForListAdapter:)]) return 0;
    
    return [self.dataSource objectsForListAdapter:self].count;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PDListSectionController *sectionController = [self sectionControllerForSection:section];
    return [sectionController numberOfRows];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDListSectionController *sectionController = [self.sectionControllers objectForKey:@(indexPath.section)];
    return [sectionController cellForRowAtIndex:indexPath.row];
}
#pragma clang diagnostic pop

// Get sectionController from self.sectionControllers with section, if failed, get from dataSource method <objectsForListAdapter:> again.
- (PDListSectionController *)sectionControllerForSection:(NSInteger)section {
    PDListSectionController *sectionController = [self.sectionControllers objectForKey:@(section)];
    if (!sectionController) {
        sectionController = [self.dataSource listAdapter:self sectionControllerForSection:section];
        
        NSArray *objects = [self.dataSource objectsForListAdapter:self];
        sectionController.object = [objects objectAtIndex:section];
        sectionController.listAdapter = self;
        sectionController.section = section;
    }
    [self.sectionControllers setObject:sectionController forKey:@(section)];
    return sectionController;
}

@end

@implementation PDListAdapter (UITableViewDelegate)

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDListSectionController *sectionController = [self.sectionControllers objectForKey:@(indexPath.section)];
    if ([sectionController respondsToSelector:@selector(heightForRowAtIndex:)]) {
        return [sectionController heightForRowAtIndex:indexPath.row];
    }
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    PDListSectionController *sectionController = [self.sectionControllers objectForKey:@(section)];
    if ([sectionController respondsToSelector:@selector(heightForHeader)]) {
        return [sectionController heightForHeader];
    }
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    PDListSectionController *sectionController = [self.sectionControllers objectForKey:@(section)];
    if ([sectionController respondsToSelector:@selector(heightForFooter)]) {
        return [sectionController heightForFooter];
    }
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PDListSectionController *sectionController = [self.sectionControllers objectForKey:@(section)];
    if ([sectionController respondsToSelector:@selector(viewForHeader)]) {
        return [sectionController viewForHeader];
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    PDListSectionController *sectionController = [self.sectionControllers objectForKey:@(section)];
    if ([sectionController respondsToSelector:@selector(viewForFooter)]) {
        return [sectionController viewForFooter];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    PDListSectionController *sectionController = [self.sectionControllers objectForKey:@(indexPath.section)];
    if ([sectionController respondsToSelector:@selector(didSelectRowAtIndex:)]) {
        [sectionController didSelectRowAtIndex:indexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    PDListSectionController *sectionController = [self.sectionControllers objectForKey:@(indexPath.section)];
    if ([sectionController respondsToSelector:@selector(willDisplayCell:forRowAtIndex:)]) {
        [sectionController willDisplayCell:cell forRowAtIndex:indexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    PDListSectionController *sectionController = [self.sectionControllers objectForKey:@(indexPath.section)];
    if ([sectionController respondsToSelector:@selector(didEndDisplayingCell:forRowAtIndex:)]) {
        [sectionController didEndDisplayingCell:cell forRowAtIndex:indexPath.row];
    }
}

@end
