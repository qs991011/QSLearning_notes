//
//  ViewController.m
//  oc_audio_note
//
//  Created by qiansheng on 2018/1/15.
//  Copyright © 2018年 GCI. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>
void dynamicMethodTMP(id self, SEL _cmd) {
    NSLog(@"id = %@,sel = %p",self,_cmd);
}

@interface TransmitClass : NSObject

@end

@implementation TransmitClass

+ (void)load {
    NSLog(@"TransmitClass _cmd : %@",NSStringFromSelector(_cmd));
}

- (void)transmitClassMethod {
    NSLog(@"TransmitClass _cmd : %@",NSStringFromSelector(_cmd));
}

- (void)isSeleep {
    NSLog(@"我正在。。。");
}

- (void)takehandle {
    NSLog(@"我是最后的接盘侠");
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self isSeleep];
   
}

- (void)takename {
    NSLog(@"睡觉");
}
//一号接盘侠
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if (sel == @selector(isSeleep)) {
        
        class_addMethod([self class], sel, (IMP)dynamicMethodTMP, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

//二号接盘侠

- (id)forwardingTargetForSelector:(SEL)aSelector {
   NSLog(@"%@",NSStringFromSelector(aSelector));
    TransmitClass *transfer = [[TransmitClass alloc] init];
    if ([transfer respondsToSelector:aSelector]) {
        return transfer;
    }
    return [super forwardingTargetForSelector:aSelector];
}

//三号接盘侠

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSString *sel = NSStringFromSelector(aSelector);
    if ([sel isEqualToString:@"isSeleep"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return  [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
     //SEL selector = [anInvocation selector];
    anInvocation.selector = @selector(takehandle);
    SEL selector = anInvocation.selector;
    TransmitClass *transmit = [[TransmitClass alloc] init];
    if ([transmit respondsToSelector:selector]) {
        [anInvocation invokeWithTarget:transmit];
    }
}





@end
