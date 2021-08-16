//
//  ViewController.m
//  Example
//
//  Created by zsh on 2021/8/13.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>

@interface ViewController ()

@property (nonatomic, strong) UIView * customView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.customView = ({
        UIView * view = [[UIView alloc] init];
        view.backgroundColor = UIColor.blueColor;
        view;
    });
    [self.view addSubview:self.customView];
    [self.customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_equalTo(100);
    }];
}


@end
