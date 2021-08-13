//
//  RootViewController.m
//  ExampleInjection
//
//  Created by zsh on 2021/7/31.
//

#import "RootViewController.h"
#import "MainViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"主页";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MainViewController * vc = [[MainViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    });
}


@end
