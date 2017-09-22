//
//  UIView+QS.swift
//  Learn_notes
//
//  Created by qiansheng on 2017/6/2.
//  Copyright © 2017年 qiansheng. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    var snapshotImage : UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let snap = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snap
    }
    
    var snapshotPDF : Data? {
        var bouns = self.bounds
        let data = Data()
        let  consumer = CGDataConsumer(data: data as! CFMutableData)
        let context = CGContext.init(consumer: consumer!, mediaBox: &bouns, nil)
        if context==nil {
            return nil
        }
        context?.beginPDFPage(nil)
        context?.translateBy(x: 0, y: bouns.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        self.layer.render(in: context!)
        context?.endPage()
        context?.closePDF()
        return data
    }
    
    var left : CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin.x
        }
    }
    var  top : CGFloat {
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        get {
           return self.frame.origin.y
        }
    }
    var right : CGFloat {
        set  {
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
        get {
           return self.frame.origin.x + self.frame.size.width
        }
        
    }
    var bottom : CGFloat {
        set {
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        
    }
    
    var width : CGFloat {
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
        get {
           return self.frame.size.width
        }
        
    }
    var height : CGFloat {
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
        get {
            return self.frame.size.height
        }
        
    }
    var centerX : CGFloat {
        set {
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
        get {
            return self.center.x
        }
        
    }
    var centerY : CGFloat {
        set {
           self.center = CGPoint(x: self.center.x, y: newValue)
        }
        get {
           return self.center.y
        }
        
    }
    var origion : CGPoint {
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
        get {
           return self.frame.origin
        }
        
    }
    var size : CGSize {
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
        get {
           return self.frame.size
        }
        
    }
    
    
    var visibleAlpha : CGFloat {
        if self.isKind(of: UIWindow.self) {
            if self.isHidden {
                return 0
            }
            return self.alpha
        }
        if self.window == nil {
            return 0
        }
        var alp : CGFloat = 1
        var v : UIView?
        v = self
        while v != nil {
            if v!.isHidden {
                alp = 0
                break
            }
            alp *= v!.alpha
            v = v?.superview
        }
        return alpha
        
        
    }
    

    func snapshotImageAfterScreenUpdates(afterUpdates:Bool) -> UIImage?{
        if self.responds(to: #selector(self.drawHierarchy(in:afterScreenUpdates:))) {
            return snapshotImage
        }
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: afterUpdates)
        let  snap = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snap
    }
    
    func setLayoutShadow(color:UIColor,offset:CGSize,radius:CGFloat) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = 1
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func removeAllSubviews()  {
        while self.subviews.count != 0 {
            self.subviews.last?.removeFromSuperview()
        }
    }
    
    func convertoViewWindow(point:CGPoint,converView:UIView?) -> CGPoint {
        if converView == nil {
            if self.isKind(of: UIWindow.self) {
                return (self as! UIWindow ) .convert(point, to: nil)
            } else {
                return self.convert(point, to: nil)
            }
        }
        let from = self.isKind(of: UIWindow.self) ? self : self.window
        let to = converView!.isKind(of: UIWindow.self) ? converView! : converView?.window
        if (from != nil) || (from == to) {
            return self.convert(point, to: converView)
        }
        var po : CGPoint!
        po = self.convert(point, to: from)
        po = to?.convert(point, from: from)
        po = converView?.convert(point, from: to!)
        return po
    }
    
   
    
   
    
    
    
    
}
