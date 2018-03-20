//
//  PDSecondSectionController.m
//  PDList
//
//  Created by liang on 2018/3/20.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "PDSecondSectionController.h"
#import "UITableView+PDCellAutoHeight.h"
#import "PDTestCell.h"

static NSString *kSecondCellId = @"kSecondCellId";
static NSString *kSecondHeaderViewId = @"kSecondHeaderViewId";

@interface PDSecondSectionController ()

@property (nonatomic, copy) NSArray<NSString *> *dataArray;

@end

@implementation PDSecondSectionController

- (NSInteger)numberOfRowsInSectionController:(__kindof PDListSectionController *)sectionController {
    return self.dataArray.count;
}

- (CGFloat)heightForHeaderInSectionController:(__kindof PDListSectionController *)sectionController {
    return 40.f;
}

- (UIView *)viewForHeaderInSectionController:(__kindof PDListSectionController *)sectionController {
    UITableViewHeaderFooterView *sectionView = [self.listAdapter dequeueReusableHeaderFooterViewWithIdentifier:kSecondHeaderViewId];
    if (!sectionView) {
        sectionView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:kSecondHeaderViewId];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        label.text = @"Section 2 Header View";
        label.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.2];
        [sectionView addSubview:label];
    }
    return sectionView;
}

- (CGFloat)sectionController:(__kindof PDListSectionController *)sectionController heightForRowAtIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:self.section];
    NSString *text = self.dataArray[index];
    
    return [self.listAdapter.tableView pd_heightForRowAtIndexPath:indexPath config:^(PDTestCell *cell) {
        [cell configData:text];
    }];
}

- (UITableViewCell *)sectionController:(__kindof PDListSectionController *)sectionController cellForRowAtIndex:(NSInteger)index {
    PDTestCell *cell = [self.listAdapter dequeueReusableCellWithIdentifier:kSecondCellId];
    if (!cell) {
        cell = [[PDTestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSecondCellId];
    }
    [cell configData:self.dataArray[index]];
    return cell;
}

- (void)sectionController:(__kindof PDListSectionController *)sectionController didSelectRowAtIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:self.section];
    [self.listAdapter.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Setter Methods
- (void)setObject:(id)object {
    [super setObject:object];
    self.dataArray = (NSArray<NSString *> *)object;
}

@end
