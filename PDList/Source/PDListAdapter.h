//
//  PDListAdapter.h
//  PDList
//
//  Created by liang on 2018/3/20.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PDListAdapter;
@class PDListSectionController;

NS_ASSUME_NONNULL_BEGIN

@protocol PDListAdapterDataSource <NSObject>

@required
- (NSArray *)objectsForListAdapter:(PDListAdapter *)listAdapter;

- (PDListSectionController *)listAdapter:(PDListAdapter *)listAdapter sectionControllerForSection:(NSInteger)section;

@end

@protocol PDListAdapter <NSObject>

@required
// Reload list data methods.
- (void)reloadData;
- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;

@end

@interface PDListAdapter : NSObject <PDListAdapter>

@property (nonatomic, weak) id<PDListAdapterDataSource> dataSource;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIViewController *viewController;

- (instancetype)initWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
