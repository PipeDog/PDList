//
//  PDListSingleSectionController.h
//  PDList
//
//  Created by liang on 2018/3/21.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "PDListSectionController.h"

@class PDListSingleSectionController;

NS_ASSUME_NONNULL_BEGIN

typedef void (^PDListCellConfigBlock)(NSInteger index, __kindof UITableViewCell *cell);
typedef CGFloat (^PDListCellHeightBlock)(NSInteger index);

@protocol PDListSingleSectionControllerDelegate <NSObject>

- (void)sectionController:(PDListSingleSectionController *)sectionController didSelectRowAtIndex:(NSInteger)index;

@end

@interface PDListSingleSectionController : PDListSectionController

- (instancetype)initWithClass:(Class)cellClass
                  configBlock:(PDListCellConfigBlock)configBlock
                  heightBlock:(PDListCellHeightBlock)heightBlock;

@property (nonatomic, weak) id<PDListSingleSectionControllerDelegate> selectionDelegate;

@end

NS_ASSUME_NONNULL_END
