//
//  AppDelegate.m
//  Example
//
//  Created by zsh on 2021/8/13.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "RootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    //self.window.rootViewController = [[ViewController alloc] init];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[RootViewController alloc] init]];
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
