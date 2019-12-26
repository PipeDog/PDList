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
    UITableViewHeaderFooterView *sectionView = [self.tableContext dequeueReusableHeaderFooterViewForClass:[UITableViewHeaderFooterView class]];
    
    UILabel *textLabel = [sectionView viewWithTag:1000];
    if (!textLabel) {
        textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        textLabel.tag = 1000;
        textLabel.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.2];
        [sectionView addSubview:textLabel];
    }
    textLabel.text = [NSString stringWithFormat:@"Section %zd Header View", self.section];
    return sectionView;
}

- (CGFloat)heightForRowAtIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:self.section];
    NSString *text = self.dataArray[index];
    
    return [self.tableContext.tableView pd_heightForRowAtIndexPath:indexPath config:^(PDTestCell *cell) {
        [cell configData:text];
    }];
}

- (UITableViewCell *)cellForRowAtIndex:(NSInteger)index {
    PDTestCell *cell = [self.tableContext dequeueReusableCellWithStyle:UITableViewCellStyleDefault forClass:[PDTestCell class]];
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
