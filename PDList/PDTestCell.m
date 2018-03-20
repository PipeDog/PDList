//
//  PDTestCell.m
//  PDList
//
//  Created by liang on 2018/3/20.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "PDTestCell.h"
#import "UITableViewCell+PDCellAutoHeight.h"

@interface PDTestCell ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation PDTestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [[UIColor brownColor] colorWithAlphaComponent:0.4];
        self.pd_bottomView = self.contentLabel;
        self.pd_bottomOffset = 20;
    }
    return self;
}

- (void)configData:(NSString *)text {
    self.contentLabel.text = text;
    [self.contentLabel sizeToFit];
}

#pragma mark - Getter Methods
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, CGRectGetWidth([UIScreen mainScreen].bounds) - 20 * 2, 0)];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.numberOfLines = 0;
        _contentLabel.backgroundColor = [UIColor colorWithRed:16 / 255.f green:16 / 255.f blue:16 / 255.f alpha:0.2];
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

@end
