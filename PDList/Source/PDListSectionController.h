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
/*
 You should override PDListSectionControllerDataSource and PDListSectionControllerDelegate methods in custom sectionController.
 */
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

@protocol PDListSectionController <NSObject>

@required
// Receive data, you should override this method to trans data.
- (void)didUpdateToObject:(id)object;

@end

@interface PDListSectionController : NSObject <PDListSectionController, PDListSectionControllerDataSource, PDListSectionControllerDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) PDListAdapter *listAdapter;
@property (nonatomic, assign) NSInteger section;

- (__kindof UITableViewCell *)dequeueReusableCellWithStyle:(UITableViewCellStyle)style forClass:(Class)aClass;
- (__kindof UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewForClass:(Class)aClass;

- (void)reloadData;
- (void)reloadRows:(NSArray<NSNumber *> *)rows withRowAnimation:(UITableViewRowAnimation)animation;

@end

NS_ASSUME_NONNULL_END
