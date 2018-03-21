//
//  PDListSingleSectionController.m
//  PDList
//
//  Created by liang on 2018/3/21.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "PDListSingleSectionController.h"
#import "PDListAssert.h"

@interface PDListSingleSectionController ()

@property (nonatomic, strong) Class cellClass;
@property (nonatomic, copy) PDListCellConfigBlock configBlock;
@property (nonatomic, copy) PDListCellHeightBlock heightBlock;
@property (nonatomic, copy) NSArray *items; // DataSource for singleSectionController.

@end

@implementation PDListSingleSectionController

- (instancetype)initWithClass:(Class)cellClass
                  configBlock:(PDListCellConfigBlock)configBlock
                  heightBlock:(PDListCellHeightBlock)heightBlock {
    PDParameterAssert(cellClass != nil);
    PDParameterAssert(configBlock != nil);
    PDParameterAssert(heightBlock != nil);
    
    self = [super init];
    if (self) {
        _cellClass = cellClass;
        _configBlock = configBlock;
        _heightBlock = heightBlock;
    }
    return self;
}

#pragma mark - PDListSectionControllerDataSource Methods
- (NSInteger)numberOfRows {
    return self.items.count;
}

- (UITableViewCell *)cellForRowAtIndex:(NSInteger)index {
    NSString *const reuseId = [NSString stringWithFormat:@"%@", self.cellClass];
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[self.cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    self.configBlock(index, cell);
    return cell;
}

#pragma mark - PDListSectionControllerDelegate Methods
- (CGFloat)heightForRowAtIndex:(NSInteger)index {
    return self.heightBlock(index);
}

- (void)didSelectRowAtIndex:(NSInteger)index {
    if (!self.selectionDelegate) return;
    
    SEL sel = @selector(sectionController:didSelectRowAtIndex:);
    if (![self.selectionDelegate respondsToSelector:sel]) return;

    [self.selectionDelegate sectionController:self didSelectRowAtIndex:index];
}

#pragma mark - PDListSectionController Methods
- (void)didUpdateToObject:(id)object {
    NSParameterAssert([object isKindOfClass:[NSArray class]] == YES);
    
    self.items = object;
}

@end
