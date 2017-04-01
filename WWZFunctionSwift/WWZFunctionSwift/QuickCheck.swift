
//
//  QuickCheck.swift
//  WWZFunctionSwift
//
//  Created by wwz on 2017/3/31.
//  Copyright © 2017年 tijio. All rights reserved.
//

import Foundation

public protocol Smaller {

    func smaller() -> Self?
}

public protocol Arbitrary: Smaller {
    
    static func arbitrary() -> Self
}

struct ArbitraryInstance<T> {
    
    let arbitrary : () -> T
    let smaller : (T) -> T?
}


public func tabulate<T>(times: Int, transform: (Int)->T) -> [T] {
    
    return (0..<times).map(transform)
}

extension Int: Arbitrary {

    public static func arbitrary() -> Int {
        
        return Int(arc4random())
    }
    
    public func smaller() -> Int? {
        
        return self == 0 ? nil : self / 2
    }
    
    static func random(from: Int, to: Int) -> Int {
    
        return from + Int(arc4random()) % (to - from)
    }
}

extension Character : Arbitrary {

    public static func arbitrary() -> Character {
        
        return Character(UnicodeScalar(Int.random(from: 65, to: 90))!)
    }
    
    public func smaller() -> Character? {
        
        return Int(String(self))! == 0 ? nil : Character(UnicodeScalar(Int(String(self))!-1)!)
    }
}

extension String: Arbitrary {

    public static func arbitrary() -> String {
        
        let randomLength = Int.random(from: 0, to: 40)
        
        let randomCharacters = tabulate(times: randomLength) { (_) -> Character in
            
            Character.arbitrary()
        }
        return String(randomCharacters)
    }
    public func smaller() -> String? {
        
        return self.isEmpty ? nil : String(self.characters.dropFirst())
    }
}
extension Array : Smaller {

    public func smaller() -> Array? {
        
        return self.isEmpty ? nil : Array(self.dropFirst())
    }
}

extension Array where Element : Arbitrary {

    static func arbitrary() -> [Element] {
    
        let randomLength = Int(arc4random()%50)
        return tabulate(times: randomLength, transform: { (_) -> Element in
            Element.arbitrary()
        })
    }
}

// 递归筛选
func iterateWhile<A>(condition: (A)->Bool, initial: A, next: (A)->A?) -> A {
    
    if let x = next(initial) , condition(x) {
        
        return iterateWhile(condition: condition, initial: x, next: next)
    }
    
    return initial
}


//func check<A: Arbitrary>(message: String, property: (A)->Bool) -> () {
//    
//    let instance = ArbitraryInstance(arbitrary: A.arbitrary()) { (<#T#>) -> T? in
//        <#code#>
//    }
//}
