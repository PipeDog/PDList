//
//  PDCellAutoHeightConst.h
//  PDAutoCellHeight
//
//  Created by liang on 2018/2/27.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PDCellAutoHeightConfigBlock)(__kindof UITableViewCell *cell);
typedef NSDictionary *(^PDCellAutoHeightCacheInfoBlock)(void);

FOUNDATION_EXTERN NSString *const PDCacheInfoUniqueIDKey; // Cell id.
FOUNDATION_EXTERN NSString *const PDCacheInfoIsDynamicKey; // Whether the height will change. If you want the height to be cached, set value to NO.
