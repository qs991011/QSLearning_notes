//
//  ViewController.swift
//  swift_image_note
//
//  Created by qiansheng on 2018/1/15.
//  Copyright © 2018年 GCI. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let fv = GCIControl(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        fv.backgroundColor = UIColor.red
//        self.view.addSubview(fv)
        
        
        let table = UITableView(frame: self.view.bounds, style: .plain)
        table.separatorStyle = .none
        table.delegate  = self
        table.dataSource = self
        table.rowHeight = 60
        self.view.addSubview(table)
        
    
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        
        let fv = GCIControl(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        v.addSubview(fv)
        fv.backgroundColor = UIColor.red
    
        cell.contentView.addSubview(fv)
        return cell
        
    }
    


}

