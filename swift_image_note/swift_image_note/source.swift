//
//  source.swift
//  swift_image_note
//
//  Created by 胜的钱 on 2019/4/7.
//  Copyright © 2019 GCI. All rights reserved.
//

import Foundation

protocol Resource {
    var cacheKey : String { get }
    var downloadURL : URL { get }
}


protocol ImageDataProvider {
    var cacheKey : String { get }
    func data(handler : @escaping(Result <Data, Error>)->Void)
}
enum Source {
    enum Identify {
        typealias Value = UInt
        static var current : Value = 0
        static func next() -> Value {
            current += 1
            return current
        }
    }
    
    case network(Resource)
    
    case provider(ImageDataProvider)
    
    var cacheKey : String {
        switch self {
        case .network(let resource):return resource.cacheKey
        case .provider(let provide):return provide.cacheKey
        }
    }
    
    var url : URL?{
        switch self {
        case .network(let resource):
            return resource.downloadURL
        case .provider(_):
            return nil
        }
    }
}

extension Source {
    var asResource : Resource? {
        guard case .network(let resource) = self else {
            return nil
        }
        return resource
    }
    
    var asProvider : ImageDataProvider? {
        guard case .provider(let provider) = self else {
            return nil
        }
        return provider
    }
    
    
}
