//
//  BorderLable.swift
//  swift_image_note
//
//  Created by qiansheng on 2018/5/31.
//  Copyright © 2018年 GCI. All rights reserved.
//

import UIKit

class BorderLable: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func sizeToFit() {
        super.sizeToFit()
        self.width += 5
        self.height += 5
    }
}

enum  QSGestureRecognizerState : Int{
    case  Began = 0 , Moved , Ended , Cancelled
}

class GCIControl : UIView {
    var longPressDetected = false
    var imageView : UIImageView!
    
    var image : UIImage? {
        set {
            self.layer.contents = image!.cgImage
        }
        get {
            var _image : UIImage?
            
            let content = self.layer.contents as! CGImage
            
            if content != self.image?.cgImage {
                _image = UIImage(cgImage: content , scale: self.layer.contentsScale, orientation: .up)
                
            } else {
                _image = nil
            }
            return _image
            
        }
    }
    
    var touchBlock : ((_ view:GCIControl,_ state : QSGestureRecognizerState, _ touches : Set<UITouch>, _ event:UIEvent?)->Void )?
    
    var longPressBlock : ((_ view : GCIControl,_ point : CGPoint) -> CGPoint)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView(frame: self.bounds)
        imageView.isUserInteractionEnabled = true
        self.addSubview(imageView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(touches)
        longPressDetected = false
        touchBlock?(self,.Began,touches,event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if longPressDetected {return}
        touchBlock?(self,.Moved,touches,event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if longPressDetected {return}
        touchBlock?(self,.Ended,touches,event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if longPressDetected {return}
        touchBlock?(self,.Cancelled,touches,event)
    }
    
}
