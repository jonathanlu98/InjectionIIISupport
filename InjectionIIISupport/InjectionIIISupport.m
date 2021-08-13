//
//  InjectionIIISupport.m
//  InjectionIIISupport
//
//  Created by zsh on 2021/8/1.
//

/*
 首先 Mac App Store 下载 InjectionIII 这个软件并安装打开。
 InjectionIII 首先Open Project，然后将此类拖入工程中，即可愉快的动态调试。
 输入代码后按 Command + S 保存 或者 Xcode焦点移到模拟器上面看效果即可
 注意：此软件目前只支持模拟器使用。
 
 iOS开发神器InjectionIII-让代码所见即所得
 https://www.jishudog.com/16062/html
 */

#import "InjectionIIISupport.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

#if DEBUG

@implementation InjectionIIISupport

+ (void)load {
    __block id observer =
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
        // iOS
        [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];//旧版本: /Applications/InjectionIII.app/Contents/Resources/iOSInjection10.bundle
        
        // tvOS
        //[[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/tvOSInjection.bundle"] load];
        
        // macOS
        //[[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/macOSInjection.bundle"] load];
        
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }];
    class_addMethod(NSObject.class, NSSelectorFromString(@"injected"), (IMP)injectedObj, "v@:");
}

/**
InjectionIII 热部署会调用的一个方法，
runtime给VC绑定上之后，每次部署完就重新viewDidLoad
*/
void injectedObj(id self, SEL _cmd) {
    NSLog(@"执行注入...");
    if ([self isKindOfClass:UIViewController.class]) {
        UIViewController * vc = ((UIViewController *)self);
        [vc.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        [self awakeFromNib];
        [self loadView];
        [self viewDidLoad];
        [self viewWillAppear:NO];
        [self viewWillLayoutSubviews];
        [self viewDidLayoutSubviews];
        [self viewDidAppear:NO];
        
        //[self viewWillDisappear:NO];
        //[self viewDidDisappear:NO];
        
        //iOS程序执行顺序和UIViewController 的生命周期(整理)
        //https://www.jianshu.com/p/d60b388b19f5
        
        NSLog(@"注入vc: %@", [vc class]);
    }
    /*
    else if ([self isKindOfClass:UITableViewCell.class]) {//此种注入方式效果不好
        UITableViewCell * cell = ((UITableViewCell *)self);
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        id ret = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(cell.class)];
     
        NSLog(@"注入cell: %@", [cell class]);
    }
    else if ([self isKindOfClass:UIView.class]) {//此种注入方式效果不好
        UIView * view = ((UIView *)self);
        [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        id ret = [view init];
        ret = [view initWithFrame:view.frame];
        [view layoutSubviews];
        
        NSLog(@"注入view: %@", [ret class]);
    }
    */
    else if ([self isKindOfClass:UIView.class]) {//改为调用UIViewController的注入方式
        NSLog(@"监测到改动: %@", [self class]);
        
        UIViewController *vc = [InjectionIIISupport viewControllerSupportView:self];
        if (vc && [vc isKindOfClass:[UIViewController class]]) {
            injectedObj(vc, _cmd);//递归
        }
    }
}

/**
 获取view 所属的vc，失败为nil
 */
+ (UIViewController *)viewControllerSupportView:(UIView *)view {
    for (UIView * next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end

#endif

