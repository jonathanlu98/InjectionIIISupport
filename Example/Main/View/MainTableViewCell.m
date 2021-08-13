//
//  MainTableViewCell.m
//  ExampleInjection
//
//  Created by zsh on 2021/7/31.
//

#import "MainTableViewCell.h"
#import <Masonry/Masonry.h>
#import "CustomLabel.h"

@interface MainTableViewCell ()

@end

@implementation MainTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    self.contentView.backgroundColor = [UIColor lightGrayColor];
    
    CustomLabel *lab = [[CustomLabel alloc] init];
    lab.font = [UIFont systemFontOfSize:22];
    lab.text = @"100";
    lab.textColor = UIColor.redColor;
    [self.contentView addSubview:lab];
    
    if (lab.superview) {
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(10);
        }];
    }
}

@end
