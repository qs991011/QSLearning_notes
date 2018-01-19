//
//  ViewController.m
//  GPUImage_01
//
//  Created by qiansheng on 2017/12/13.
//  Copyright © 2017年 qiansheng. All rights reserved.
//

#import "ViewController.h"
#import "GPUImage.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
}

/**
 添加图片
 */
- (void)addImage {
        UIImage *inputImage = [UIImage imageNamed:@"meinv.jpg"];
        GPUImagePicture *sourcePicture = [[GPUImagePicture alloc] initWithImage:inputImage smoothlyScaleOutput:YES];
        GPUImageSketchFilter *customFileter = [[GPUImageSketchFilter alloc] init];
        [sourcePicture addTarget:customFileter];
        GPUImageView *imageView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:imageView];
        [customFileter addTarget:imageView];
        [sourcePicture processImage];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


@end
