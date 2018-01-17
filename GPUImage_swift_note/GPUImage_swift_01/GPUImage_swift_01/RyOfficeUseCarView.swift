//
//  RyOfficeUseCarView.swift
//  renttravel
//
//  Created by qiansheng on 2018/1/4.
//  Copyright © 2018年 GCI. All rights reserved.
//

import UIKit

class RyOfficeUseCarView: UIView {
    
    @IBOutlet weak var mid: UILabel!
    @IBOutlet weak var mcomfort: QSButton!
    @IBOutlet weak var mbusiness: QSButton!
    @IBOutlet weak var smallbus: QSButton!
    
    @IBOutlet weak var mremark: UILabel!
    @IBOutlet weak var mnumber: UILabel!
    @IBOutlet weak var mpayType: UILabel!
    static func initView() ->RyOfficeUseCarView {
        return   (Bundle.main.loadNibNamed("RyOfficeUseCarView", owner: nil, options: nil)![0] as? RyOfficeUseCarView)!
    }

   

}
