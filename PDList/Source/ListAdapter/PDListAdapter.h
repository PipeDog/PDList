//
//  PDListAdapter.h
//  PDList
//
//  Created by liang on 2018/3/20.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDListAdapter;
@class PDListSectionController;

NS_ASSUME_NONNULL_BEGIN

@protocol PDListAdapterDataSource <NSObject>

- (NSInteger)numberOfSectionControllersForListAdapter:(PDListAdapter *)listAdapter;
- (PDListSectionController *)listAdapter:(PDListAdapter *)listAdapter sectionControllerForSection:(NSInteger)section;

@optional
- (UIView *)emptyViewForListAdapter:(PDListAdapter *)listAdapter;

@end

@protocol PDListUpdater <NSObject>

- (void)reloadData;
- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;
- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;

- (void)performUpdateSectionControllers:(NSArray<PDListSectionController *> *)sectionControllers withRowAnimation:(UITableViewRowAnimation)animation;
- (void)performUpdateSectionController:(PDListSectionController *)sectionController atIndexs:(NSArray<NSNumber *> *)indexs withRowAnimation:(UITableViewRowAnimation)animation;

@end

@protocol PDListTableContext <NSObject>

@property (nullable, readonly) UIViewController *viewController;
@property (readonly) UITableView *tableView;

- (__kindof UITableViewCell *)dequeueReusableCellWithStyle:(UITableViewCellStyle)style forClass:(Class)aClass;
- (__kindof UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewForClass:(Class)aClass;

@end

@interface PDListAdapter : NSObject <PDListUpdater, PDListTableContext>

@property (nonatomic, weak) id<PDListAdapterDataSource> dataSource;
@property (nonatomic, weak, nullable) id<UIScrollViewDelegate> scrollDelegate;

@property (nonatomic, weak, readonly) UITableView *tableView;
@property (nonatomic, weak, nullable) UIViewController *viewController;
@property (readonly) NSArray<PDListSectionController *> *visibleSectionControllers;

- (instancetype)initWithTableView:(UITableView *)tableView NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
