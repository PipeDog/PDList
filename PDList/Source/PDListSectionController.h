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

@end

@protocol PDListSectionControllerProvide <NSObject>

@required
// Dequeue reusable cells and headerFooterViews.
- (nullable __kindof UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;
- (__kindof UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndex:(NSInteger)index;
- (nullable __kindof UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewWithIdentifier:(NSString *)identifier;

// Register cells and headerFooterViews.
- (void)registerNib:(nullable UINib *)nib forCellReuseIdentifier:(NSString *)identifier;
- (void)registerClass:(nullable Class)cellClass forCellReuseIdentifier:(NSString *)identifier;

- (void)registerNib:(nullable UINib *)nib forHeaderFooterViewReuseIdentifier:(NSString *)identifier;
- (void)registerClass:(nullable Class)aClass forHeaderFooterViewReuseIdentifier:(NSString *)identifier;

// Reload sectionController data.
- (void)reloadData;
- (void)reloadRows:(NSArray<NSNumber *> *)rows withRowAnimation:(UITableViewRowAnimation)animation;

@end

@protocol PDListSectionController <NSObject>

@required
// Receive data, you should override this method to trans data.
- (void)didUpdateToObject:(id)object;

@end

@interface PDListSectionController : NSObject <PDListSectionControllerProvide, PDListSectionController, PDListSectionControllerDataSource, PDListSectionControllerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) id object; ///< Data for current sectionController.
@property (nonatomic, weak) PDListAdapter *listAdapter; ///< ListAdapter for current sectionController.
@property (nonatomic, assign) NSInteger section; ///< Section in tableView for current sectionController.

@end

NS_ASSUME_NONNULL_END
