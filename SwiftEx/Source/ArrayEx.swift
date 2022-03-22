//
//  ArrayEx.swift
//  SwiftExtension
//
//  Created by xuzexin on 2022/3/22.
//

import Foundation

extension Array {
    
    //索引是否在数组范围内
    func indexExists(_ index: Int) -> Bool {
        return indices.contains(index)
    }
    
    //按索引取所在元素
    func get(index: Int) -> Element? {
        return self[safe: index]
    }
    
    public subscript (safe index: Array.Index) -> Element? {
        get {
            return indices ~= index ? self[index] : nil
        }
        set {
            guard let element = newValue else { return }
            self[index] = element
        }
    }

    
    func each (call: (Int, Element) -> ()) {
        
        for (index, item) in enumerated() {
            call(index, item)
        }
    }
}
