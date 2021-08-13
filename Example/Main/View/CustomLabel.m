//
//  CustomLabel.m
//  ExampleInjection
//
//  Created by zsh on 2021/7/31.
//

#import "CustomLabel.h"

@implementation CustomLabel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    self.backgroundColor = UIColor.whiteColor;
}


@end
