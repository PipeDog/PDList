//
//  PDCellAutoHeightProtocol.h
//  PDAutoCellHeight
//
//  Created by liang on 2018/2/27.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "PDCellAutoHeightConst.h"

@protocol PDCellAutoHeightProtocol <NSObject>

// Recompute the cell height each time.
- (CGFloat)pd_heightForRowAtIndexPath:(NSIndexPath *)indexPath
                               config:(PDCellAutoHeightConfigBlock)config;

// The cell height is calculated according to the uniqueID cache.
- (CGFloat)pd_heightForRowAtIndexPath:(NSIndexPath *)indexPath
                               config:(PDCellAutoHeightConfigBlock)config
                            cacheInfo:(PDCellAutoHeightCacheInfoBlock)cacheInfo;

@end

@protocol PDCellAutoHeightCellConfiguration <NSObject>

@property (nonatomic, strong) NSArray<UIView *> *pd_bottomViews; // Bottom views on the cell.
@property (nonatomic, strong) UIView *pd_bottomView; // Bottom view on the cell.
@property (nonatomic, assign) CGFloat pd_bottomOffset; // Bottom edge of the view at the bottom of the cell.
@property (nonatomic, assign, readonly) CGFloat pd_cellHeight; // Fetch cell height according to pd_bottomView and pd_bottomOffset.

@end
