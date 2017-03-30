//
//  MapFilterReduce.swift
//  WWZFunctionSwift
//
//  Created by wwz on 2017/3/30.
//  Copyright © 2017年 tijio. All rights reserved.
//

import Foundation


func map<Element, T>(xs:[Element], transform: (Element) -> T) -> [T] {
    
    var result : [T] = [T]()
    for x in xs {
        
        result.append(transform(x))
    }
    return result
}
