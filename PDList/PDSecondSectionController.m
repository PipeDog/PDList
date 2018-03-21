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

- (NSInteger)numberOfRows {
    return self.dataArray.count;
}

- (CGFloat)heightForHeader {
    return 40.f;
}

- (UIView *)viewForHeader {
    UITableViewHeaderFooterView *sectionView = [self dequeueReusableHeaderFooterViewWithIdentifier:kSecondHeaderViewId];
    if (!sectionView) {
        sectionView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:kSecondHeaderViewId];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        label.text = @"Section 2 Header View";
        label.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.2];
        [sectionView addSubview:label];
    }
    return sectionView;
}

- (CGFloat)heightForRowAtIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:self.section];
    NSString *text = self.dataArray[index];
    
    return [self.listAdapter.tableView pd_heightForRowAtIndexPath:indexPath config:^(PDTestCell *cell) {
        [cell configData:text];
    }];
}

- (UITableViewCell *)cellForRowAtIndex:(NSInteger)index {
    PDTestCell *cell = [self dequeueReusableCellWithIdentifier:kSecondCellId];
    if (!cell) {
        cell = [[PDTestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSecondCellId];
    }
    [cell configData:self.dataArray[index]];
    return cell;
}

- (void)didSelectRowAtIndex:(NSInteger)index {

}

#pragma mark - Setter Methods
- (void)didUpdateToObject:(id)object {
    self.dataArray = object;
}

@end
