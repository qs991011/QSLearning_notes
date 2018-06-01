//
//  QSString.swift
//  swift_image_note
//
//  Created by qiansheng on 2018/4/10.
//  Copyright © 2018年 GCI. All rights reserved.
//

import Foundation

extension String {
    var words : [String] {
        return components(separatedBy: .punctuationCharacters).joined().components(separatedBy: .whitespaces).filter{!$0.isEmpty}
    }
}
