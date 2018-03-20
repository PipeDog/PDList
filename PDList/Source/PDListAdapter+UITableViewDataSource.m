//
//  PDListAdapter+UITableViewDataSource.m
//  PDList
//
//  Created by liang on 2018/3/20.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "PDListAdapter+UITableViewDataSource.h"
#import "PDListSectionController.h"

@interface PDListAdapter () <PDListAdapter>

@end

@implementation PDListAdapter (UITableViewDataSource)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.dataSource) return 0;
    if (![self.dataSource respondsToSelector:@selector(objectsForListAdapter:)]) return 0;
    
    return [self.dataSource objectsForListAdapter:self].count;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PDListSectionController *sectionController = [self sectionControllerForSection:section];
    return [sectionController numberOfRowsInSectionController:sectionController];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDListSectionController *sectionController = [self.sectionControllers objectForKey:@(indexPath.section)];
    return [sectionController sectionController:sectionController cellForRowAtIndex:indexPath.row];
}
#pragma clang diagnostic pop

#pragma mark - Handle SectionControllers Methods
- (PDListSectionController *)sectionControllerForSection:(NSInteger)section {
    PDListSectionController *sectionController = [self.sectionControllers objectForKey:@(section)];
    if (!sectionController) {
        sectionController = [self.dataSource listAdapter:self sectionControllerForSection:section];
        
        NSArray *objects = [self.dataSource objectsForListAdapter:self];
        sectionController.object = [objects objectAtIndex:section];
        sectionController.listAdapter = self;
        sectionController.section = section;
    }
    [self.sectionControllers setObject:sectionController forKey:@(section)];
    return sectionController;
}

@end
