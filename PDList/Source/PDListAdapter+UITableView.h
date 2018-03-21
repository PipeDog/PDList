//
//  PDListAdapter+UITableView.h
//  PDList
//
//  Created by liang on 2018/3/21.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "PDListAdapter.h"

@protocol PDListAdapterPrivateProtocol <NSObject>

@required
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, PDListSectionController *> *sectionControllers;

@end

@interface PDListAdapter () <PDListAdapterPrivateProtocol>
@end

@interface PDListAdapter (UITableViewDataSource) <UITableViewDataSource>
@end

@interface PDListAdapter (UITableViewDelegate) <UITableViewDelegate>
@end

@interface PDListAdapter (UIScrollViewDelegate)
@end
