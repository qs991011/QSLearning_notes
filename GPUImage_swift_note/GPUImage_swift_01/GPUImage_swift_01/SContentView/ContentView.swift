//
//  ContentView.swift
//  GPUImage_swift_01
//
//  Created by qiansheng on 2018/3/21.
//  Copyright © 2018年 qiansheng. All rights reserved.
//

import UIKit

class ContentView: UIView{
    
    var topview : UIView!
    var contentview : UIView!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initTopMenuView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        topview = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 40), collectionViewLayout: layout)
    }
    
    func initContentView() {
        contentview = UITableView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 100))
    }

}
