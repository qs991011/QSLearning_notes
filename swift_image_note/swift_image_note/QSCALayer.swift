//
//  CALayer+QS.swift
//  swift_image_note
//
//  Created by qiansheng on 2018/5/28.
//  Copyright © 2018年 GCI. All rights reserved.
//

import Foundation
import UIKit
extension CALayer {
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
    
    var center : CGPoint {
        set {
            var frame = self.frame
            frame.origin.x = center.x - frame.size.width * 0.5
            frame.origin.y = center.y - frame.size.height * 0.5
            self.frame = frame
        }
        get {
            return CGPoint(x: self.frame.origin.x + self.frame.width * 0.5, y: self.frame.origin.y + self.frame.size.height * 0.5)
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
    
    var origin : CGPoint {
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
    
    var transformRotation : CGFloat {
        set {
            self.setValue(newValue, forKey: "transform.rotation" )
        }
        get {
            let v = self.value(forKeyPath: "transform.rotation") as! CGFloat
            return v
        }
    }
    
    var transformRotationX : CGFloat {
        set {
            self.setValue(newValue, forKey: "transform.rotation.x")
        }
        
        get {
            let v = self.value(forKeyPath: "transform.rotation.x") as! CGFloat
            return v
        }
    }
    
    var transformRotationY : CGFloat {
        set {
            self.setValue(newValue, forKey: "transform.rotation.y")
        }
        
        get {
            let v = self.value(forKeyPath: "transform.rotation.y") as! CGFloat
            return v
        }
    }
    
    var transformRotationZ : CGFloat {
        set {
            self.setValue(newValue, forKey: "transform.rotation.z")
        }
        
        get {
            let v = self.value(forKeyPath: "transform.rotation.z") as! CGFloat
            return v
        }
    }
    
    var transformScaleX : CGFloat {
        set {
            self.setValue(newValue, forKey: "transform.scale.x")
        }
        
        get {
            let v = self.value(forKeyPath: "transform.scale.x") as! CGFloat
            return v
        }
    }
    
    var transformScaleY : CGFloat {
        set {
            self.setValue(newValue, forKey: "transform.scale.y")
        }
        
        get {
            let v = self.value(forKeyPath: "transform.scale.y") as! CGFloat
            return v
        }
    }
    
    var transformScaleZ : CGFloat {
        set {
            self.setValue(newValue, forKey: "transform.scale.z")
        }
        
        get {
            let v = self.value(forKeyPath: "transform.scale.z") as! CGFloat
            return v
        }
    }
    
    var transformScale : CGFloat {
        set {
            self.setValue(newValue, forKey: "transform.scale")
        }
        
        get {
            let v = self.value(forKeyPath: "transform.scale") as! CGFloat
            return v
        }
    }
    
    var transformTranslationX : CGFloat {
        set {
            self.setValue(newValue, forKey: "transform.translation.x")
        }
        
        get {
            let v = self.value(forKeyPath: "transform.translation.x") as! CGFloat
            return v
        }
    }
    
    var transformTranslationY : CGFloat {
        set {
            self.setValue(newValue, forKey: "transform.translation.y")
        }
        
        get {
            let v = self.value(forKeyPath: "transform.translation.y") as! CGFloat
            return v
        }
    }
    
    var transformTranslationZ : CGFloat {
        set {
            self.setValue(newValue, forKey: "transform.translation.z")
        }
        
        get {
            let v = self.value(forKeyPath: "transform.translation.z") as! CGFloat
            return v
        }
    }
    
    var transformDepth : CGFloat {
        set {
            var d = self.transform
            d.m34 = newValue
            self.transform = d
        }
        get {
            return self.transform.m34
        }
    }
    
    func addFadeAnimation(duration:TimeInterval,curve:UIViewAnimationCurve) {
        if duration <= 0 {return}
        var mediaFunction : String!
        switch curve {
        case .easeInOut:
            mediaFunction = kCAMediaTimingFunctionEaseOut
            break
        case .easeIn:
            mediaFunction = kCAMediaTimingFunctionEaseIn
            break
        case .easeOut:
            mediaFunction = kCAMediaTimingFunctionLinear
            break
        default:
            mediaFunction = kCAMediaTimingFunctionLinear
            break
        }
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: mediaFunction)
        transition.type = kCATransitionFade
        self.add(transition, forKey: "qiansheng.fade")
    }
    
    func removePreviousFadeAnimation() {
        self.removeAnimation(forKey: "qiansheng.fade")
    }
    
    
    
}
