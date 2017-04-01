//
//  Function.swift
//  WWZFunctionSwift
//
//  Created by wwz on 2017/3/30.
//  Copyright © 2017年 tijio. All rights reserved.
//

import Foundation


typealias Distance = Double

struct Position {
    
    var x: Double
    var y: Double
    
    var length : Double {
    
        return sqrt(x*x + y*y)
    }
    
    func minus(p: Position) -> Position {
        
        return Position(x: x-p.x, y: y-p.y)
    }
}


/// 判断点是否在圆内
/// 传入点，返回bool值
typealias Region = (_ position: Position) -> Bool

/// 以原点为圆心的圆
func cicle(radius: Distance) -> Region {
    
    return { point in point.length <= radius }
}

/// 区域变换
func shift(region: @escaping Region, offset: Position) -> Region {

    return { point in region(point.minus(p: offset)) }
}


/// 反转区域
func invert(region: @escaping Region) -> Region {

    return { point in !region(point) }
}

/// 交集
func intersection(region1: @escaping Region, region2: @escaping Region) -> Region {
    
    return { point in region1(point) && region2(point) }
}

/// 并集
func union(region1: @escaping Region, region2: @escaping Region) -> Region {
    
    return { point in region1(point) || region2(point) }
}

/// 差集
func difference(region: @escaping Region, minus: @escaping Region) -> Region {
    
    return intersection(region1: region, region2: invert(region: minus))
}










        
