//
//  UIViewController+swizzling.m
//  oc_audio_note
//
//  Created by qiansheng on 2018/3/23.
//  Copyright © 2018年 GCI. All rights reserved.
//

#import "UIViewController+swizzling.h"
#import <objc/runtime.h>
@implementation UIViewController (swizzling)

+ (void)load {
    Method fromMethod = class_getInstanceMethod(self, @selector(viewDidLoad));
    Method tomethod = class_getInstanceMethod(self, @selector(swizzlingViewLoad));
    if (!class_addMethod([self class], @selector(swizzlingViewLoad), method_getImplementation(tomethod), method_getTypeEncoding(tomethod))) {
        method_exchangeImplementations(fromMethod, tomethod);
    }
}

- (void)swizzlingViewLoad {
    NSString *str = [NSString stringWithFormat:@"%@",self.class];
    NSLog(@"___%@",str);
    if (![str containsString:@"UI"]) {
        NSLog(@"统计打点:%@",self.class);
    }
    
    [self swizzlingViewLoad];
}
@end
