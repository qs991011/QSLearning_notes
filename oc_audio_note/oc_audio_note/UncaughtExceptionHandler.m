//
//  UncaughtExceptionHandler.m
//  oc_audio_note
//
//  Created by 胜的钱 on 2019/4/8.
//  Copyright © 2019 GCI. All rights reserved.
//

//

#import "UncaughtExceptionHandler.h"
#import <UIKit/UIKit.h>
#include <libkern/OSAtomic.h>
#include <execinfo.h>

NSString * const UncaughtExceptionHandlerSignalExceptionName=@"UncaughtExceptionHandlerSignalExceptionName";
NSString * const UncaughtExceptionHandlerSignalKey=@"UncaughtExceptionHandlerSignalKey";
NSString * const UncaughtExceptionHandlerAddressesKey=@"UncaughtExceptionHandlerAddressesKey";

volatile int32_t exceptionCount = 0;
const int32_t exceptionMaximum = 10;

const NSInteger UncaughtExceptionHandlerReportAddressCount = 10;//指明报告多少条调用堆栈信息
@interface UncaughtExceptionHandler ()<UIAlertViewDelegate>
//获取堆栈指针，返回符号化之后的数组
+ (NSArray *)backtrace;

//处理异常2，包括抛出的异常和信号异常
- (void)handleException:(NSException *)exception;
@end

@implementation UncaughtExceptionHandler
+ (NSArray *)backtrace{
    void *callStack[128];//堆栈方法数组
    int frames=backtrace(callStack, 128);//从iOS的方法backtrace中获取错误堆栈方法指针数组，返回数目
    char **strs=backtrace_symbols(callStack, frames);//符号化
    
    int i;
    NSMutableArray *symbolsBackTrace=[NSMutableArray arrayWithCapacity:frames];
    for (i=0; i<UncaughtExceptionHandlerReportAddressCount; i++) {
        [symbolsBackTrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    return symbolsBackTrace;
}

- (void)handleException:(NSException *)exception{
    NSString *message=[NSString stringWithFormat:@"如果点击继续，程序有可能会出现其他的问题，建议您还是点击退出按钮并重新打开\n\n异常报告:\n异常名称：%@\n异常原因：%@\n其他信息：%@\n",
                       [exception name],
                       [exception reason],
                       [[exception userInfo] objectForKey:UncaughtExceptionHandlerAddressesKey]];
    UIAlertView *alert =
    [[UIAlertView alloc]
     initWithTitle:NSLocalizedString(@"抱歉，程序出现了异常", nil)
     message:message
     delegate:self
     cancelButtonTitle:@"退出"
     otherButtonTitles:@"继续", nil];
    [alert show];
    
    ///////////////
    CFRunLoopRef runLoop=CFRunLoopGetCurrent();
    CFArrayRef allModes=CFRunLoopCopyAllModes(runLoop);
    NSArray *arr=(__bridge NSArray *)allModes;
    while (!dismissed) {
        for (NSString *mode in arr) {
            CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
        }
    }
    CFRelease(allModes);
    
    NSSetUncaughtExceptionHandler(NULL);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
    
    if ([[exception name] isEqual:UncaughtExceptionHandlerSignalExceptionName])
    {
        kill(getpid(), [[[exception userInfo] objectForKey:UncaughtExceptionHandlerSignalKey] intValue]);
    }
    else
    {
        [exception raise];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        dismissed=YES;
    }else{
        dismissed=false;
    }
}

@end

void HandleUncaughtException(NSException *exception){
    int32_t exceptionCount=OSAtomicIncrement32(&exceptionCount);
    if (exceptionCount>exceptionMaximum) {
        return;
    }
    
    NSArray *callStack=[UncaughtExceptionHandler backtrace];
    NSMutableDictionary *userInfo=[NSMutableDictionary dictionaryWithDictionary:[exception userInfo]];
    [userInfo setObject:callStack forKey:UncaughtExceptionHandlerAddressesKey];
    
    UncaughtExceptionHandler *uncaughtExceptionHandler=[[UncaughtExceptionHandler alloc] init];
    NSException *uncaughtException=[NSException exceptionWithName:[exception name] reason:[exception reason] userInfo:userInfo];
    [uncaughtExceptionHandler performSelectorOnMainThread:@selector(handleException:) withObject:uncaughtException waitUntilDone:YES];
}

void HandleSignal(int signal){
    int32_t exceptionCount= OSAtomicIncrement32(&exceptionCount);
    if (exceptionCount>exceptionMaximum) {
        return;
    }
    
    NSMutableDictionary *userInfo=[NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:signal] forKey:UncaughtExceptionHandlerSignalKey];
    NSArray *callBack=[UncaughtExceptionHandler backtrace];
    [userInfo setObject:callBack forKey:UncaughtExceptionHandlerAddressesKey];
    
    UncaughtExceptionHandler *uncaughtExceptionHandler=[[UncaughtExceptionHandler alloc] init];
    NSException *signalException=[NSException exceptionWithName:UncaughtExceptionHandlerSignalExceptionName reason:[NSString stringWithFormat:@"Signal %d was raised.",signal] userInfo:userInfo];
    [uncaughtExceptionHandler performSelectorOnMainThread:@selector(handleException:) withObject:signalException waitUntilDone:YES];
}

void InstallUncaughtExceptionHandler(void){
    NSSetUncaughtExceptionHandler(HandleUncaughtException);//设置未捕获的异常处理
    
    //设置信号类型的异常处理
    signal(SIGABRT, HandleSignal);
    signal(SIGILL, HandleSignal);
    signal(SIGSEGV, HandleSignal);
    signal(SIGFPE, HandleSignal);
    signal(SIGBUS, HandleSignal);
    signal(SIGPIPE, HandleSignal);
}

