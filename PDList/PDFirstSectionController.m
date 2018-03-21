//
//  PDFirstSectionController.m
//  PDList
//
//  Created by liang on 2018/3/20.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "PDFirstSectionController.h"
#import "UITableView+PDCellAutoHeight.h"
#import "PDTestCell.h"

static NSString *kFirstCellId = @"kFirstCellId";
static NSString *kFirstHeaderViewId = @"kFirstHeaderViewId";

@interface PDFirstSectionController ()

@property (nonatomic, copy) NSArray<NSString *> *dataArray;

@end

@implementation PDFirstSectionController

- (NSInteger)numberOfRows {
    return self.dataArray.count;
}

- (CGFloat)heightForHeader {
    return 40.f;
}

- (CGFloat)heightForRowAtIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:self.section];
    NSString *text = self.dataArray[index];
    
    return [self.listAdapter.tableView pd_heightForRowAtIndexPath:indexPath config:^(PDTestCell *cell) {
        [cell configData:text];
    }];
}

- (UIView *)viewForHeader {
    UITableViewHeaderFooterView *sectionView = [self dequeueReusableHeaderFooterViewWithIdentifier:kFirstHeaderViewId];
    if (!sectionView) {
        sectionView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:kFirstHeaderViewId];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        label.text = @"Section 1 Header View";
        label.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.2];
        [sectionView addSubview:label];
    }
    return sectionView;
}

- (UITableViewCell *)cellForRowAtIndex:(NSInteger)index {
    PDTestCell *cell = [self dequeueReusableCellWithIdentifier:kFirstCellId];
    if (!cell) {
        cell = [[PDTestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kFirstCellId];
    }
    [cell configData:self.dataArray[index]];
    return cell;
}

- (void)didSelectRowAtIndex:(NSInteger)index {

}

- (void)didUpdateToObject:(id)object {
    self.dataArray = object;
}

@end
