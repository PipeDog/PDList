//
//  PDListSectionController.h
//  PDList
//
//  Created by liang on 2018/3/20.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDListAdapter.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PDListSectionControllerDataSource <NSObject>

@required
- (NSInteger)numberOfRows;
- (__kindof UITableViewCell *)cellForRowAtIndex:(NSInteger)index;

@end

@protocol PDListSectionControllerDelegate <NSObject>

@optional
- (void)willDisplayCell:(UITableViewCell *)cell forRowAtIndex:(NSInteger)index;
- (void)didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndex:(NSInteger)index;

- (CGFloat)heightForRowAtIndex:(NSInteger)index;
- (CGFloat)heightForHeader;
- (CGFloat)heightForFooter;

- (nullable UIView *)viewForHeader;
- (nullable UIView *)viewForFooter;

- (void)didSelectRowAtIndex:(NSInteger)index;

- (BOOL)canEditRowAtIndex:(NSInteger)index;
- (UITableViewCellEditingStyle)editingStyleAtIndex:(NSInteger)index;
- (void)commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndex:(NSInteger)index;

@end

@interface PDListSectionController : NSObject <PDListSectionControllerDataSource, PDListSectionControllerDelegate, UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger section;
@property (nonatomic, weak) id<PDListUpdater> updater;
@property (nonatomic, weak) id<PDListTableContext> tableContext;

- (void)didUpdateToObject:(id)object;

@end

NS_ASSUME_NONNULL_END
