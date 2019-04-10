//
//  UncaughtExceptionHandler.h
//  oc_audio_note
//
//  Created by 胜的钱 on 2019/4/8.
//  Copyright © 2019 GCI. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface UncaughtExceptionHandler : NSObject
{
    BOOL dismissed;//是否继续程序
}
@end

//处理未捕获的异常
void HandleUncaughtException(NSException *exception);
//处理信号类型的异常
void HandleSignal(int signal);
//为两种类型的信号注册处理函数
void InstallUncaughtExceptionHandler(void);

NS_ASSUME_NONNULL_END
