//
//  QSLable.m
//  oc_audio_note
//
//  Created by qiansheng on 2018/3/22.
//  Copyright © 2018年 GCI. All rights reserved.
//

#import "QSLable.h"
#import <YYAsyncLayer/YYAsyncLayer.h>
@interface QSLable () 


@end

@implementation QSLable

//- (void)setText:(NSString *)text{
//    _text = text.copy;
//    [[YYTransaction transactionWithTarget:self selector:@selector(contentsNeedUpdated)] commit];
//
//}
//
//- (void)contentsNeedUpdated {
//    [self.layer setNeedsDisplay];
//}
//
//+ (Class)layerClass {
//    return YYAsyncLayer.class;
//}

//- (YYAsyncLayerDisplayTask *)newAsyncDisplayTask {
//    NSString *text = _text;
//    UIFont *font = _font;
//
//    YYAsyncLayerDisplayTask *task = [YYAsyncLayerDisplayTask new];
//    task.willDisplay = ^(CALayer *layer) {
//        //...
//    };
//
//    task.display = ^(CGContextRef context, CGSize size, BOOL(^isCancelled)(void)) {
//        if (isCancelled()) return;
//        NSArray *lines = CreateCTLines(text, font, size.width);
//        if (isCancelled()) return;
//
//        for (int i = 0; i < lines.count; i++) {
//            CTLineRef line = line[i];
//            CGContextSetTextPosition(context, 0, i * font.pointSize * 1.5);
//            CTLineDraw(line, context);
//            if (isCancelled()) return;
//        }
//    };
//
//    task.didDisplay = ^(CALayer *layer, BOOL finished) {
//        if (finished) {
//            // finished
//        } else {
//            // cancelled
//        }
//    };
//
//    return task;
//}

@end
