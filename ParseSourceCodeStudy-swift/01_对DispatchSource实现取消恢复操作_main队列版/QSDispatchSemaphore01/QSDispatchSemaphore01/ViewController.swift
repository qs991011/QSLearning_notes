//
//  ViewController.swift
//  QSDispatchSemaphore01
//
//  Created by qiansheng on 2018/2/27.
//  Copyright © 2018年 GCI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let a = 3
        //assert(a < 3, "该数值不对")
        //QueueSemaphore()
        splitString()
    }
    
    func splitString() {
        var notice = "hello world"
        let sub = notice.split(separator: "l", maxSplits: 4, omittingEmptySubsequences: false)
        let sub3 = notice.split(separator: "l", maxSplits: 4, omittingEmptySubsequences: true)
        let sub1 = notice.split(maxSplits: 1, omittingEmptySubsequences: false) { (char) -> Bool in
            char == "o"
        }
        let sub2 = notice.split(maxSplits: 1, omittingEmptySubsequences: true) { (char) -> Bool in
            char == "o"
        }
        
        
        
        let sub4 = String(notice.reversed())
        print(sub4)
        print(sub)
        print(sub3)
        print(sub1)
        print(sub2)
        
        
    }
    
    func QueueSemaphore() {
        ////因为用到了dispatch_barrier_async，该函数只能搭配自定义并行队列dispatch_queue_t使用。所以不能使用：dispatch_get_global_queue
        let queue = DispatchQueue.init(label: "com.qs991011.gcd.sem", qos: .default, attributes: .concurrent)
        let semaphore = DispatchSemaphore.init(value: 1)
        var array = Array<Any>()
        for i in 0..<10000 {
            //semaphore.wait(timeout: DispatchTime.distantFuture)
            semaphore.wait(timeout: DispatchTime.distantFuture)
            print("🔴%@",Thread.current)
            array.append(i)
            semaphore.signal()
        }
        
        let  wirte = DispatchWorkItem(qos: .default, flags: .barrier) {
            print("🔴类名与方法名：%s（在第%d行），描述：%@",#function,#line)
            
        }
        queue.async(execute: wirte)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("🔴类名与方法名：\(#function)（在第\(#line)行），描述")
    }
    
    
    func SampleSemaphore() {
        let semaphore = DispatchSemaphore.init(value: 1)
        //let semaphore = DispatchSemaphore.init(value: 0)
        let time = DispatchTime.init(uptimeNanoseconds: 1)
        
        print("begin ==> 车库开始营业了!")
        /*
         *
         如果 semphore 的值等于0，就阻塞1秒钟，才会往下照常进行；
         如果大于等于1则往下进行并将 semphore 进行减1处理。
         *
         */
        let result = semaphore.wait(timeout: time)
        if result.hashValue == 0 {
            /*
             *
             *由子Dispatch Semaphore的计数值达到大于等于1
             *或者在待机中的指定时间内
             *Dispatch Semaphore的计数值达到大于等于1
             所以Dispatch Semaphore的计数值减去1
             可执行需要进行排他控制的处理.
             可以理解为：没有阻塞的线程了。
             就好比：车库有一个或一个以上的车位，只来了一辆车，所以“无需等待”
             *
             */
            print("result = 0 ==> 有车位，无需等待！==>在这里可安全执行【需要排他控制的处理（比如只允许一条线程为mutableArray进行addObj操作）】")
            semaphore.signal()//使用signal以确保编译器release掉dispatch_semaphore_t时的值与初始值一致， 否则会EXC_BAD_INSTRUCTION
        } else {
            /*
             *
             *由于Dispatch Semaphore的计数值为0
             .因此在达到指定时间为止待机
             这个else里发生的事情，就好比：车库没车位，来了一辆车，等待了半个小时后，做出的一些事情。
             比如：忍受不了，走了。。
             *
             */
            print("result != 0 ==> timeout，deadline，忍受不了，走了。。")
        }
    }
}

