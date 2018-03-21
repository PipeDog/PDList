//
//  PDSingleSectionDemoController.m
//  PDList
//
//  Created by liang on 2018/3/21.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "PDSingleSectionDemoController.h"
#import "PDList.h"

@interface PDSingleSectionDemoController () <PDListAdapterDataSource, PDListSingleSectionControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) PDListAdapter *listAdapter;
@property (nonatomic, copy) NSArray<NSString *> *items;

@end

@implementation PDSingleSectionDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.listAdapter.dataSource = self;
}

#pragma mark - PDListAdapterDataSource Methods
- (NSArray *)objectsForListAdapter:(PDListAdapter *)listAdapter {
    // Wrapper into array.
    return @[self.items];
}

- (PDListSectionController *)listAdapter:(PDListAdapter *)listAdapter sectionControllerForSection:(NSInteger)section {
    PDListSingleSectionController *sectionController = [[PDListSingleSectionController alloc] initWithClass:[UITableViewCell class] configBlock:^(NSInteger index, __kindof UITableViewCell * _Nonnull cell) {
        // Config cell data here.
        cell.textLabel.text = self.items[index];
        cell.textLabel.numberOfLines = 0;
    } heightBlock:^CGFloat(NSInteger index) {
        // Return cell height.
        return 50.f + index * 20;
    }];
    sectionController.selectionDelegate = self;
    return sectionController;
}

#pragma mark - PDListSingleSectionControllerDelegate
// Did select cell event callback.
- (void)sectionController:(PDListSectionController *)sectionController didSelectRowAtIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:sectionController.section];
    [sectionController.listAdapter.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSLog(@"didSelectRowAtIndex < %zd >.", index);
}

#pragma mark - Getter Methods
- (PDListAdapter *)listAdapter {
    if (!_listAdapter) {
        _listAdapter = [[PDListAdapter alloc] initWithTableView:self.tableView];
        _listAdapter.viewController = self;
    }
    return _listAdapter;
}

- (NSArray<NSString *> *)items {
    if (!_items) {
        _items = @[@"Do any additional setup after loading",
                   @"Do any additional setup after loading\nDo any additional setup after loading",
                   @"Do any additional setup after loading\nDo any additional setup after loading\nDo any additional setup after loading",
                   @"Do any additional setup after loading\nDo any additional setup after loading\nDo any additional setup after loading\nDo any additional setup after loading",
                   @"Do any additional setup after loading\nDo any additional setup after loading\nDo any additional setup after loading\nDo any additional setup after loading\nDo any additional setup after loading"];
    }
    return _items;
}

@end
