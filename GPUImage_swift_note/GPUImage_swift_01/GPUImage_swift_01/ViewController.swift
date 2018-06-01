//
//  ViewController.swift
//  GPUImage_swift_01
//
//  Created by qiansheng on 2017/12/14.
//  Copyright © 2017年 qiansheng. All rights reserved.
//

import UIKit
import GPUImage
import AVFoundation
class ViewController: UIViewController , SerialDispatchPool,UITableViewDelegate,UITableViewDataSource  {
   
    var camera : Camera!
    var button : UIButton!
    var prilayer : CALayer!
    var tableview : UITableView!
    

    override func viewDidLoad() {
       super.viewDidLoad()

//       let pictureInput = UIImageView(frame: self.view.bounds)
//       let inputImage = UIImage(named: "meinv.jpg")
//       //let toonFilter = SmoothToonFilter()
//      // let filteredImage = inputImage?.filterWithOperation(toonFilter)
//       pictureInput.image  = inputImage
//       //PiplineRender(image: pictureInput.image!)

//
//      self.view.addSubview(pictureInput)
        //PiplineRender()
//        runOperationPoolAsynchronously {
//            self.cameraFiltering()
////        }
//        let red = UIView()
//        red.backgroundColor = UIColor.red
//        let blue = UIView()
//        blue.backgroundColor = UIColor.blue
//
//
//        view.layout(red).left(10).right(10).top(10).bottom(20)
//        button = UIButton(type: .custom)
//        button.frame = CGRect(x: 100, y: 100, width: 80, height: 80)
//        button.setTitle("旋转动画", for: .normal)
//        button.backgroundColor = UIColor.red
//        button.addTarget(self, action: #selector(self.rotateAnimation), for: .touchUpInside)
//        view.addSubview(button)
        //initTableview()
        
//        prilayer = CALayer()
//        prilayer.bounds = CGRect(x: 100, y: 100, width: 80, height: 80)
//        prilayer.backgroundColor = UIColor.red.cgColor
//        view.layer.addSublayer(prilayer)
       
        
    }
    

    
    @objc func rotateAnimation() {
//        let anima = CABasicAnimation(keyPath: "transform.rotation.z")
//        anima.duration = 1.0
//        anima.toValue = NSNumber(value: Double.pi/2)
//        anima.isRemovedOnCompletion = false
//        anima.fillMode = "forwards"
//        button.layer.add(anima, forKey: nil)
       // tableview.setEditing(true, animated: true)
        print(self.button.frame)
        UIView.animate(withDuration: 0.2, animations: {
            var frame = self.button.frame
            frame.origin.y -= 10
            self.button.frame = frame
            
        }) { (finish) in
            print(self.button.frame)
        }
        
        
    }
    
    func initTableview()  {
        //tableview = UITableView(frame: CGRect(x: 0, y: 180, width: 200, height: 200), style: .plain)
        tableview = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height), style: .grouped)
        tableview.dataSource = self
        tableview.delegate = self
        tableview.allowsMultipleSelection  = true
        view.addSubview(tableview)
    }
    
    //MARK: - tableviewdelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SideslipCell
        if cell == nil {
             cell = SideslipCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text = "12333334445"
        return cell!
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableview.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        let cell = tableview.cellForRow(at: indexPath)
        cell?.isSelected =  cell!.isSelected
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableview.cellForRow(at: indexPath)
        cell?.isSelected =  cell!.isSelected
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //rotateAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController {
    func cameraFiltering() {
        do {
            // 创建一个camera的实例 Camera遵循ImageSource协议，用来从相机捕获数据
            
            camera = try Camera(sessionPreset: AVCaptureSession.Preset.hd1280x720.rawValue, cameraDevice: nil, location: .backFacing, captureAsYUV: true)
            
        } catch {
            print(error)
            return
        }
        // 创建一个Luminance颜色处理滤镜
        let basicOperation = Luminance()
        
        // 创建一个RenderView的实例并添加到view上，用来显示最终处理出的内容
        
        let renderView = RenderView(frame: self.view.bounds)
        
        self.view.addSubview(renderView)
        
        camera --> basicOperation --> renderView
        
        camera.startCapture()
        
    }
}

protocol SerialDispatchPool {
   
}

extension SerialDispatchPool {
    public func runOperationPoolAsynchronously(_ operation:@escaping () -> ()) {
        DispatchQueue.main.async {
            operation()
        }
    }
}

