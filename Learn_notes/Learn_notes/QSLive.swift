//
//  QSLive.swift
//  Learn_notes
//
//  Created by qiansheng on 2017/8/15.
//  Copyright © 2017年 qiansheng. All rights reserved.
//

import UIKit



class QSLive: UIView {
    
    let a = UIView()
    override func draw(_ rect: CGRect) {
       
    }
    
    
}

struct URLEncoding {
    public enum Destination {
        case methodDependent, queryString, httpBody
    }
    
    public enum ArrayEncoding {
        case brackets, noBrackets
        
        func encode(key: String) -> String {
            switch self {
            case .brackets:
                return "\(key)[]"
            case .noBrackets:
                return key
            }
        }
    }
    
    public enum BoolEncoding {
        case numeric, literal
        
        func encode(value: Bool) -> String {
            switch self {
            case .numeric:
                return value ? "1" : "0"
            case .literal:
                return value ? "true" : "false"
            }
        }
    }
    public let destination: Destination
    public let arrayEncoding: ArrayEncoding
    public let boolEncoding: BoolEncoding
    public static var `default`: URLEncoding { return URLEncoding() }
    public init(destination: Destination = .methodDependent, arrayEncoding: ArrayEncoding = .brackets, boolEncoding: BoolEncoding = .numeric) {
        self.destination = destination
        self.arrayEncoding = arrayEncoding
        self.boolEncoding = boolEncoding
    }
}
