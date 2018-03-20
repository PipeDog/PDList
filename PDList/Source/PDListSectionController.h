//
//  PDListSectionController.h
//  PDList
//
//  Created by liang on 2018/3/20.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDListSectionControllerDelegate.h"
#import "PDListSectionControllerDataSource.h"
#import "PDListAdapter.h"

NS_ASSUME_NONNULL_BEGIN

@interface PDListSectionController : NSObject <PDListSectionControllerDataSource, PDListSectionControllerDelegate>

@property (nonatomic, strong) id object;
@property (nonatomic, weak) PDListAdapter *listAdapter;
@property (nonatomic, assign) NSInteger section;

@end

NS_ASSUME_NONNULL_END
