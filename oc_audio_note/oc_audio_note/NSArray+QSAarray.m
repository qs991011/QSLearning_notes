//
//  NSArray+QSAarray.m
//  oc_audio_note
//
//  Created by qiansheng on 2018/3/23.
//  Copyright © 2018年 GCI. All rights reserved.
//

#import "NSArray+QSAarray.h"
#import <objc/runtime.h>
@implementation NSArray (QSAarray)
/**
      类                   真身
   NSArray              __NSArrayI
 NSMutableArray         __NSArrayM
  NSDictionary          __NSDictionaryI
 NSMutableDictionary    __NSDictionaryM
 */
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
        Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(qs_objectAtIndex:));
        method_exchangeImplementations(fromMethod, toMethod);
    });
   
}

- (id)qs_objectAtIndex:(NSUInteger)index {
    if (self.count-1 < index) {
        @try {
            return [self qs_objectAtIndex:index];
        }
        @catch (NSException *exception) {
            NSLog(@"----- %s Crash Because Method %s-------\n",class_getName(self.class),__func__);
            NSLog(@"%@",[exception callStackSymbols]);
        }
        
        @finally {}
    } else {
        return  [self qs_objectAtIndex:index];
    }
}
@end
