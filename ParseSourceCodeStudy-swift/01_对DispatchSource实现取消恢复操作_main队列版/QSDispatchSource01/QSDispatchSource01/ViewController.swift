//
//  ViewController.swift
//  QSDispatchSource01
//
//  Created by qiansheng on 2018/2/27.
//  Copyright © 2018年 GCI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var processingQueueSource : DispatchSourceUserDataAdd!
    var isruning = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         让Dispatch 实现取消恢复操作
         */
        ///1.指定DISPATCH_SOURCE_TYPE_DATA_ADD 做成Dispatch Source(分派源) 设定Main Dispatch Queue 为追加处理的Dispatch Queue
        processingQueueSource = DispatchSource.makeUserDataAddSource(queue: DispatchQueue.global())
        var totalComplete : UInt = 0
        processingQueueSource.setEventHandler {
            //当处理事件被最终执行时，计算后的数据可以通过data来获取。这个数据的值在每次响应事件执行后会被重置，所以totalComplete的值是最终累积的值。
            let value =  self.processingQueueSource.data
            totalComplete += value
            print("进度：%@",(CGFloat(totalComplete)/100))
            print("🔵线程号 %@",Thread.current)
        }
        //分派源创建时默认处于暂停状态，在分派源分派处理程序之前必须先恢复。
        self.resume()
        //恢复源后，就可以通过add向Dispatch Source(分派源)发送事件:
        let queue = DispatchQueue.init(label: "com.qs991011", qos: .default, attributes: .concurrent)
        // let queue = DispatchQueue.global(qos: .default)
        //        queue.async {
        //            for _ in 0..<100 {
        //                self.processingQueueSource.add(data: 1)
        //                print("♻️线程号 %@",Thread.current)
        //                usleep(200000)
        //            }
        //        }
        //下面必上面要快17倍
        
        /**
         打印🔵（小蓝点）♻️（小绿点）个数是不一的，但 totalComplete 的值，或者进度条从0.0到1.0的执行是正常，但是🔵（小蓝点）为什么没有被打印？这是因为：
              DispatchSource能通过合并事件的方式确保在高负载下正常工作
         在同一时间，只有一个处理 block 的实例被分配，如果这个处理方法还没有执行完毕，另一个事件就发生了，事件会以指定方式（ADD或 OR）进行累积。DispatchSource能通过合并事件（block）的方式确保在高负载下正常工作。当处理事件被最终执行时，计算后的数据可以通过 dispatch_source_get_data 来获取。这个数据的值在每次响应时间执行后会被重置，所以上面的例子中进度条 totalComplete 的值是最终积累的值，而 block 不是每次都执行的，但打印🔵（小蓝点）♻️（小绿点）个数不一。但能确保进度条能从0.0到1.0的正常执行。
         */
        for _ in 0..<100 {
            queue.async {
                self.processingQueueSource.add(data: 1)
                print("♻️线程号 %@",Thread.current)
                usleep(200000)
            }
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        changeStatus(shouldPause: isruning)
    }
    
    func changeStatus(shouldPause:Bool) {
        if shouldPause {
            pause()
        } else {
            resume()
        }
    }
    
    func resume() {
        if  isruning{
            return
        }
        self.isruning = true
        print("✅恢复Dispatch Source(分派源)")
        processingQueueSource.resume()
    }
    
    func pause() {
        if !isruning {
            return
        }
        print("暂停Dispatch Source(分派源)")
        self.isruning = false
        processingQueueSource.suspend()
    }
    
    
}

