//
//  UITableViewCell+PDCellAutoHeight.m
//  PDAutoCellHeight
//
//  Created by liang on 2018/2/22.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "UITableViewCell+PDCellAutoHeight.h"
#import <objc/runtime.h>

@implementation UITableViewCell (PDCellAutoHeight)

#pragma mark - Setter Methods
- (void)setPd_bottomViews:(NSArray<UIView *> *)pd_bottomViews {
    objc_setAssociatedObject(self, @selector(pd_bottomViews), pd_bottomViews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setPd_bottomView:(UIView *)pd_bottomView {
    objc_setAssociatedObject(self, @selector(pd_bottomView), pd_bottomView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setPd_bottomOffset:(CGFloat)pd_bottomOffset {
    objc_setAssociatedObject(self, @selector(pd_bottomOffset), @(pd_bottomOffset), OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - Getter Methods
- (NSArray<UIView *> *)pd_bottomViews {
    return objc_getAssociatedObject(self, _cmd);
}

- (UIView *)pd_bottomView {
    return objc_getAssociatedObject(self, _cmd);
}

- (CGFloat)pd_bottomOffset {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (CGFloat)pd_cellHeight {
    if (strcmp(dispatch_queue_get_label(dispatch_get_main_queue()),
               dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL)) != 0) {
        NSAssert(NO, @"UI operation must be performed in the main thread.");
    }
    
    [self layoutIfNeeded];
    
    CGFloat cellHeight = 0.f;
    
    if (self.pd_bottomViews.count > 0) {
        for (UIView *subview in [self.pd_bottomViews copy]) {
            cellHeight = MAX(CGRectGetMaxY(subview.frame), cellHeight);
        }
    }
    else if (self.pd_bottomView) {
        cellHeight = CGRectGetMaxY(self.pd_bottomView.frame);
    }
    else {
        for (UIView *subview in [self.subviews copy]) {
            cellHeight = MAX(CGRectGetMaxY(subview.frame), cellHeight);
        }
    }
    cellHeight += self.pd_bottomOffset;
    return cellHeight;
}

@end
