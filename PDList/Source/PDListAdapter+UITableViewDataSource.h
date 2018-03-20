//
//  PDListAdapter+UITableViewDataSource.h
//  PDList
//
//  Created by liang on 2018/3/20.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "PDListAdapter.h"

@protocol PDListAdapter <NSObject>

@optional
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, PDListSectionController *> *sectionControllers;

@end

@interface PDListAdapter (UITableViewDataSource) <UITableViewDataSource>

@end
