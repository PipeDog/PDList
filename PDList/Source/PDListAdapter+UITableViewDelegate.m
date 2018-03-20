//
//  PDListAdapter+UITableViewDelegate.m
//  PDList
//
//  Created by liang on 2018/3/20.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "PDListAdapter+UITableViewDelegate.h"
#import "PDListSectionController.h"
#import "PDListAdapter+UITableViewDataSource.h"

@interface PDListAdapter () <PDListAdapter>

@end

@implementation PDListAdapter (UITableViewDelegate)

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDListSectionController *sectionController = [self.sectionControllers objectForKey:@(indexPath.section)];
    if ([sectionController respondsToSelector:@selector(sectionController:cellForRowAtIndex:)]) {
        return [sectionController sectionController:sectionController heightForRowAtIndex:indexPath.row];
    }
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    PDListSectionController *sectionController = [self.sectionControllers objectForKey:@(section)];
    if ([sectionController respondsToSelector:@selector(heightForHeaderInSectionController:)]) {
        return [sectionController heightForHeaderInSectionController:sectionController];
    }
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    PDListSectionController *sectionController = [self.sectionControllers objectForKey:@(section)];
    if ([sectionController respondsToSelector:@selector(heightForFooterInSectionController:)]) {
        return [sectionController heightForFooterInSectionController:sectionController];
    }
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PDListSectionController *sectionController = [self.sectionControllers objectForKey:@(section)];
    if ([sectionController respondsToSelector:@selector(viewForHeaderInSectionController:)]) {
        return [sectionController viewForHeaderInSectionController:sectionController];
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    PDListSectionController *sectionController = [self.sectionControllers objectForKey:@(section)];
    if ([sectionController respondsToSelector:@selector(viewForFooterInSectionController:)]) {
        return [sectionController viewForFooterInSectionController:sectionController];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PDListSectionController *sectionController = [self.sectionControllers objectForKey:@(indexPath.section)];
    if ([sectionController respondsToSelector:@selector(sectionController:didSelectRowAtIndex:)]) {
        [sectionController sectionController:sectionController didSelectRowAtIndex:indexPath.row];
    }
}

@end
