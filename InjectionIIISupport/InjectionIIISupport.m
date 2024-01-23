//
//  InjectionIIISupport.m
//  InjectionIIISupport
//
//  Created by zsh on 2021/8/1.
//

#import "InjectionIIISupport.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

#if DEBUG

@implementation InjectionIIISupport

+ (void)load {
    __block id observer =
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
        // iOS  优先加载内置的
        NSString *pathInProject = [NSBundle.mainBundle pathForResource:@"iOSInjection" ofType:@"bundle"];
        if (pathInProject.length > 0) {
            [[NSBundle bundleWithPath:pathInProject] load];
        } else {
            [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];//旧版本: /Applications/InjectionIII.app/Contents/Resources/iOSInjection10.bundle
        }
        // tvOS
        //[[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/tvOSInjection.bundle"] load];
        
        // macOS
        //[[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/macOSInjection.bundle"] load];
        
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }];
    class_addMethod(NSObject.class, NSSelectorFromString(@"injected"), (IMP)injectedObj, "v@:");
}

void injectedObj(id self, SEL _cmd) {
    NSLog(@"监测到改动: %@", [self class]);
    
    if ([self isKindOfClass:UIViewController.class]) {
        
        UIViewController * vc = (UIViewController *)self;
        [vc.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        NSLog(@"执行注入vc: %@", [vc class]);
        
        // support lazy property
        unsigned int propertyCount;
        unsigned int methodCount;
        Method * methods = class_copyMethodList(vc.class, &methodCount);
        objc_property_t * propertys = class_copyPropertyList(vc.class, &propertyCount);
        NSMutableArray<NSString *> *methodStrs = [NSMutableArray array];
        for (int i = 0; i < methodCount; i++) {
            [methodStrs addObject:NSStringFromSelector(method_getName(methods[i]))];
        }
        for (int i = 0; i < propertyCount; i++) {
            objc_property_t property = propertys[i];
            const char * cPropertyName = property_getName(property);
            NSString * propertyName = [NSString stringWithUTF8String:cPropertyName];
            id propertyValue = [vc valueForKey:propertyName];
            __block BOOL haveSetMethod = NO;
            [methodStrs enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj containsString:propertyName] && [[obj substringToIndex:2] isEqualToString:@"set"]) {
                    haveSetMethod = YES;
                    *stop = YES;
                }
            }];
            if ([propertyValue isKindOfClass:NSObject.class] && haveSetMethod) {
                NSObject * obj = (NSObject *)obj;
                @try {
                    [vc setValue:nil forKey:propertyName];
                } @catch (NSException *exception) {
                    //NSLog(@"exception = %@", exception);
                } @finally {
        
                }
            }
        }
        free(propertys);
        
        [self awakeFromNib];
        [self loadView];
        [self viewDidLoad];
        [self viewWillAppear:NO];
        [self viewWillLayoutSubviews];
        [self viewDidLayoutSubviews];
        [self viewDidAppear:NO];
    }
    else if ([self isKindOfClass:UIView.class]) {
        UIViewController *vc = [InjectionIIISupport viewControllerSupportView:self];
        if (vc && [vc isKindOfClass:[UIViewController class]]) {
            injectedObj(vc, _cmd);//改为调用UIViewController的注入方式，递归
        }
    }
}

+ (UIViewController *)viewControllerSupportView:(UIView *)view {
    for (UIView * next = [view superview]; next; next = next.superview) {
        UIResponder * nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end

#endif

