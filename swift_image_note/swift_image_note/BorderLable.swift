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
