//
//  SideslipCell.swift
//  GPUImage_swift_01
//
//  Created by qiansheng on 2017/12/18.
//  Copyright © 2017年 qiansheng. All rights reserved.
//

import UIKit

enum SideslipcellState {
    case Normal
    case Open
}

class SideslipCell: UITableViewCell,CAAnimationDelegate {
    var deletebtn : UIButton!
    var cellState = SideslipcellState.Normal {
        didSet {
            gettableView()
        }
    }
    override var isSelected: Bool {
        willSet {
            if newValue {
                self.contentView.backgroundColor = UIColor.red
            } else {
                self.contentView.backgroundColor = UIColor.white
            }
        }
    }
    
    var btnContainView : UIView?
    var _tableView : UITableView?
    var isAnimation = false
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupSideslipcell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSideslipcell() {
        deletebtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: self.frame.height))
        deletebtn.backgroundColor = UIColor.red
        deletebtn.setTitle("删除", for: .normal)
        deletebtn.addTarget(self, action: #selector(self.showDeleteAction), for: .touchUpInside)
        self.contentView.backgroundColor = UIColor.yellow
        addslipsView()
        self.addSubview(deletebtn)
        self.bringSubview(toFront: deletebtn)
        
    }
    
    @objc func showDeleteAction() {
        if isAnimation {
            return
        }
        // 添加旋转动画
        let anima = CABasicAnimation(keyPath: "transform.rotation.z")
        anima.duration = 0.3
        if cellState == .Normal {
            anima.toValue = NSNumber(value: Double.pi/2)
        }else{
            anima.toValue = NSNumber(value: 0)
        }
        anima.isRemovedOnCompletion = false
        //保留动画结束后的状态
        anima.fillMode = "forwards"
        anima.delegate = self
        deletebtn.layer.add(anima, forKey: nil)
    }
    
    func setContentViewX(x:CGFloat) {
        var frame = self.contentView.frame
        frame.origin.x = x
        self.contentView.frame = frame
    }
    
    func hiddenSideslip() {
        UIView.animate(withDuration: 0.2, animations: {
            self.setContentViewX(x: 0)
        }) { (isfinish) in
            
        }
    }
    
    func showSideslip() {
        //
        UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.setContentViewX(x: -self.deletebtn.frame.width)
            
        }) { (finished) in
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // let x = self.contentView.frame.origin
        btnContainView?.frame = CGRect(x: self.frame.size.width - 40, y: 0, width: 40, height: self.frame.size.height)
        var frame = self.contentView.frame
        frame.size.width = self.bounds.size.width
        self.contentView.frame = frame
    }
    
    func addslipsView() {
        if btnContainView != nil{
            btnContainView?.removeFromSuperview()
            btnContainView = nil
        }
        btnContainView = UIView()
        self.insertSubview(btnContainView!, belowSubview: self.contentView)
        let btn = UIButton(type: .custom)
        let title = "删除"
        btn.adjustsImageWhenHighlighted = false
        btn.setTitle(title, for: .normal)
        btn.backgroundColor = UIColor.red
        //        let width = (title as NSString).boundingRect(with: CGSize.init(width: 1000, height: 1000), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:15], context: nil).size.width
        btn.frame = CGRect(x: 0, y: 0, width: 40, height: self.frame.size.height)
        btnContainView?.addSubview(btn)
    }
    //MARK: - animationDelegate
    func animationDidStart(_ anim: CAAnimation) {
        isAnimation = true
        if cellState == .Normal {
            showSideslip()
        } else {
            hiddenSideslip()
        }
        
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        isAnimation = false
        if cellState == .Normal {
            cellState = .Open
            _tableView?.isScrollEnabled = false
            _tableView?.allowsSelection = false
        } else {
            cellState = .Normal
            _tableView?.isScrollEnabled = true
            _tableView?.allowsSelection = true
        }
    }
    // MARK: - 手势的代理方法
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if _tableView!.isScrollEnabled {
            return false
        }else{
            return true
        }
    }
    func gettableView() {
        var childView : UIView?
        childView = self
        while true {
            childView = childView?.superview
            if ((childView as? UITableView) != nil) {
                break
            }
        }
        _tableView = childView as? UITableView
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.PanGestureAction))
        pan.delegate = self
        _tableView?.addGestureRecognizer(pan)
        //return tableView
    }
    
    @objc func PanGestureAction(pan:UIPanGestureRecognizer) {
        if !_tableView!.isScrollEnabled && pan.state == .began {
            showDeleteAction()
        }
    }
    
}
