//
//  PDListSectionControllerDelegate.h
//  PDList
//
//  Created by liang on 2018/3/20.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PDListSectionController;

NS_ASSUME_NONNULL_BEGIN

@protocol PDListSectionControllerDelegate <NSObject>

@optional
- (CGFloat)sectionController:(__kindof PDListSectionController *)sectionController heightForRowAtIndex:(NSInteger)index;
- (CGFloat)heightForHeaderInSectionController:(__kindof PDListSectionController *)sectionController;
- (CGFloat)heightForFooterInSectionController:(__kindof PDListSectionController *)sectionController;

- (nullable UIView *)viewForHeaderInSectionController:(__kindof PDListSectionController *)sectionController;
- (nullable UIView *)viewForFooterInSectionController:(__kindof PDListSectionController *)sectionController;

- (void)sectionController:(__kindof PDListSectionController *)sectionController didSelectRowAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
