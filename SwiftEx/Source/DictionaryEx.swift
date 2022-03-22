//
//  DictionaryEx.swift
//  SwiftExtension
//
//  Created by xuzexin on 2022/3/22.
//

import Foundation

extension Dictionary {
    
        func each (each: (Key, Value) -> ()) {

            for (key, value) in self {
                each(key, value)
            }

        }

        /**
            Constructs a dictionary containing every [key: value] pair from self
            for which testFunction evaluates to true.

            :param: testFunction Function called to test each key, value
            :returns: Filtered dictionary
        */
        func filter (test: (Key, Value) -> Bool) -> Dictionary {

            var result = Dictionary()

            for (key, value) in self {
                if test(key, value) {
                    result[key] = value
                }
            }
            return result
        }

    
}
