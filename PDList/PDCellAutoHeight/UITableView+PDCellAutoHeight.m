//
//  UITableView+PDCellAutoHeight.m
//  PDAutoCellHeight
//
//  Created by liang on 2018/2/22.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "UITableView+PDCellAutoHeight.h"
#import "UITableViewCell+PDCellAutoHeight.h"
#import <objc/runtime.h>

@interface UITableView ()

@property (nonatomic, strong, readonly) NSMutableDictionary *cacheInfoDict;

@end

@implementation UITableView (PDCellAutoHeight)

- (CGFloat)pd_heightForRowAtIndexPath:(NSIndexPath *)indexPath
                               config:(PDCellAutoHeightConfigBlock)config {
    return [self pd_heightForRowAtIndexPath:indexPath config:config cacheInfo:^NSDictionary *{
        return @{PDCacheInfoUniqueIDKey: @"",
                 PDCacheInfoIsDynamicKey: @(NO)};
    }];
}

- (CGFloat)pd_heightForRowAtIndexPath:(NSIndexPath *)indexPath
                               config:(PDCellAutoHeightConfigBlock)config
                            cacheInfo:(PDCellAutoHeightCacheInfoBlock)cacheInfo {
    NSString *uniqueId = [cacheInfo() objectForKey:PDCacheInfoUniqueIDKey];
    BOOL isDynamic = [[cacheInfo() objectForKey:PDCacheInfoIsDynamicKey] boolValue];
    
    if (!(uniqueId.length > 0)) {
        CGSize size = CGSizeMake(indexPath.section, indexPath.row);
        uniqueId = NSStringFromCGSize(size);
    }
    BOOL alreadyCacheInfo = [[self.cacheInfoDict allKeys] containsObject:uniqueId];
    if (!isDynamic && alreadyCacheInfo) {
        return [self.cacheInfoDict[uniqueId] floatValue];
    } else {
        CGFloat cellHeight = [self fetchHeightForRowAtIndexPath:indexPath config:config];
        self.cacheInfoDict[uniqueId] = [NSNumber numberWithDouble:cellHeight];
        return cellHeight;
    }
}

#pragma mark - Fetch Height Methods
- (CGFloat)fetchHeightForRowAtIndexPath:(NSIndexPath *)indexPath
                                 config:(PDCellAutoHeightConfigBlock)config {
    if (!self.dataSource) {
        return 0.f;
    }
    UITableViewCell *cell = [self.dataSource tableView:self cellForRowAtIndexPath:indexPath];
    if (!cell) {
        return 0.f;
    }
    if (config) {
        config(cell);
    }
    return cell.pd_cellHeight;
}

#pragma mark - Getter Methods
- (NSMutableDictionary *)cacheInfoDict {
    NSMutableDictionary *cacheInfoDict = objc_getAssociatedObject(self, _cmd);
    if (!cacheInfoDict) {
        cacheInfoDict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, _cmd, cacheInfoDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cacheInfoDict;
}

@end
