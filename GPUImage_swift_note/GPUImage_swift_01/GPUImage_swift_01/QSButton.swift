//
//  QSButton.swift
//  EasyParking
//
//  Created by qiansheng on 2017/2/22.
//  Copyright © 2017年 GCI. All rights reserved.
//

import UIKit

class QSButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        commonInit()
        
    }
    
    func commonInit()  {
       self.titleLabel?.textAlignment = .center
       self.imageView?.contentMode = .scaleAspectFit
       //self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleX : CGFloat = 0
        let titleY : CGFloat = contentRect.size.height * 0.1
        let titleW : CGFloat = contentRect.size.width;
        let titleH : CGFloat = contentRect.size.height * 0.3 ;
        return CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
    }

    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        
        let imageY = contentRect.size.height * 0.6
        let imageX : CGFloat = contentRect.width * 0.3
        let imageW : CGFloat = contentRect.width * 0.4
        let imageH : CGFloat = contentRect.size.height * 0.2
        return CGRect(x: imageX, y: imageY, width: imageW, height: imageH)
    }
    

}
