//
//  QSLayer.swift
//  Learn_notes
//
//  Created by qiansheng on 2017/8/8.
//  Copyright © 2017年 qiansheng. All rights reserved.
//

import UIKit

protocol QSTextAsyncLayerDelegate : NSObjectProtocol {
    func newAsyncDisplayTask()
}

class QSTextAsyncLayerDisplayTask: NSObject {
    var willDisplay  : ((_ layer : CALayer) ->Void)?
    var display : ((_ contex : CGContext,_ size:CGSize,_ iscancle:((_ isCancled : Bool)->Void))->Void)?
    var didDisplay : ((_ layer : CALayer,_ finish: Bool) ->Void)?
    
}

class _QSTextSentinel: NSObject {
    private (set) var qvalue : Int32!
    
}


class QSLayer: CALayer {
    var sentinel = _QSTextSentinel()
    
    var displaysAsynchronously : Bool = true
    let scale =  UIScreen.main.scale
    
    override init() {
        super.init()
        contentsScale = scale
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func defaultValue(forKey key: String) -> Any?{
        if key  == "displaysAsynchronously" {
            return true
        } else {
            return super.defaultValue(forKey: key)
        }
    }
    
    deinit {
        
    }
    
    override func setNeedsLayout() {
        cancleAsyncDisplay()
        super.setNeedsDisplay()
    }
    
    func cancleAsyncDisplay() {
        
    }
    
    func displayAsync(async:Bool)  {
        var delegte = self.delegate
        
        
    }
  

}
