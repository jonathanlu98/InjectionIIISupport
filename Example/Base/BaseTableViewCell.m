//
//  BaseTableViewCell.m
//  ExampleInjection
//
//  Created by zsh on 2021/7/31.
//

#import "BaseTableViewCell.h"
#import <Masonry/Masonry.h>

@interface BaseTableViewCell()

@end

@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
