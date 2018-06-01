//
//  HomeController.swift
//  GPUImage_swift_01
//
//  Created by qiansheng on 2018/1/17.
//  Copyright © 2018年 qiansheng. All rights reserved.
//

import UIKit
import GPUImage
class HomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //PiplineRender()
        addRenderView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    func PiplineRender() {
        
        //let renderView = RenderView(frame: self.view.frame)
        
        //创建一个BrightnessAdjustment颜色处理滤镜
        let brightnessAdjustment = BrightnessAdjustment()
        brightnessAdjustment.brightness = 0
        
        // 创建一个ExposureAdjustment颜色处理滤镜
        let exposureAdjustment = ExposureAdjustment()
        exposureAdjustment.exposure = 0.5
        
        
        let pictureInput = PictureInput(image:UIImage(named: "meinv.jpg")!)
        let pictureOutput = PictureOutput()
        pictureOutput.imageAvailableCallback = { (image) in
            
            let imageView = UIImageView(frame: self.view.bounds)
            imageView.image = image
            self.view.addSubview(imageView)
            
        }
        
        pictureInput --> brightnessAdjustment --> exposureAdjustment --> pictureOutput
        pictureInput.processImage(synchronously: true)//执行完毕 就会回调imageAvailableCallback回调
        
    }
    func addRenderView() {
        let pictureInput = PictureInput(image:UIImage(named: "meinv.jpg")!)
        let render = RenderView(frame: self.view.bounds)
        pictureInput --> render
//        let status = render.addSource(pictureInput)
        
        self.view.addSubview(render)
        pictureInput.processImage(synchronously: false)
    }
}

