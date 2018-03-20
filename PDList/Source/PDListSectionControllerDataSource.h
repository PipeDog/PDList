//
//  PDListSectionControllerDataSource.h
//  PDList
//
//  Created by liang on 2018/3/20.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PDListSectionController;

NS_ASSUME_NONNULL_BEGIN

@protocol PDListSectionControllerDataSource <NSObject>

@required
- (NSInteger)numberOfRowsInSectionController:(__kindof PDListSectionController *)sectionController;
- (__kindof UITableViewCell *)sectionController:(__kindof PDListSectionController *)sectionController cellForRowAtIndex:(NSInteger)index;

@optional

@end

NS_ASSUME_NONNULL_END
