//
//  UIController+QSAdd.swift
//  Learn_notes
//
//  Created by qiansheng on 2017/8/15.
//  Copyright © 2017年 qiansheng. All rights reserved.
//

import Foundation
import UIKit

class _LFUIControllerBlockTarget: NSObject {
    var block : ((_ sender : Any)->Void)?
    var events : UIControlEvents?
    init(block:((_ sender : Any)->Void)?,events: UIControlEvents?){
        super.init()
        self.block = block
        self.events = events
    }
    
    func invoke(sender:Any)  {
        if block != nil {
            block!(sender)
        }
    }
    
    
}
extension UIControl {
    
    
    func removeAllTargets()   {
        for target in self.allTargets {
            self.removeTarget(target, action: nil, for: .allEvents)
        }
    }
    
    func setTarger(target:Any?,action:Selector?,controlEvents:UIControlEvents) {
        if target == nil || action == nil {
            return
            
        }
        let targets = self.allTargets
        
        for currentTarget in targets {
            let actions = self.actions(forTarget: currentTarget, forControlEvent: controlEvents)
            if actions == nil {
                break
            }
            for currentAction in actions! {
                self.removeTarget(currentTarget, action: NSSelectorFromString(currentAction), for: controlEvents)
            }
        }
        
        self.addTarget(target!, action: action!, for: controlEvents)
    }
    
    
    
    
    
}
