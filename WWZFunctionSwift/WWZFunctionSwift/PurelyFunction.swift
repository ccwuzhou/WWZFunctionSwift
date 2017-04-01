//
//  PurelyFunction.swift
//  WWZFunctionSwift
//
//  Created by wwz on 2017/4/1.
//  Copyright © 2017年 tijio. All rights reserved.
//

import Foundation

/// indirect：递归
/// 二叉搜索树
indirect enum BinarySearchTree <Element: Comparable> {
    case leaf
    case Node(BinarySearchTree<Element>, Element, BinarySearchTree<Element>)
}

let left : BinarySearchTree<Int> = .leaf
let five : BinarySearchTree<Int> = .Node(.leaf, 5, .leaf)

extension BinarySearchTree {

    init() {
        self = .leaf
    }
    init(value: Element) {
        
        self = .Node(.leaf, value, .leaf)
    }
    
    /// 存值的个数
    var count: Int {
    
        switch self {
        case .leaf:
            return 0
        case let .Node(left, _, right):
            return 1+left.count + right.count
        }
    }
    
    /// 所有元素组成的数组
    var elements: [Element] {
    
        switch self {
        case .leaf:
            return []
        case let .Node(left, x, right):
            return left.elements + [x] + right.elements
        }
    }
    
    /// 是否为空
    var isEmpty: Bool {
    
        if case .leaf = self {
            return true
        }
        return false
    }
}


extension BinarySearchTree where Element: Comparable {

    var isBST: Bool {
    
        switch self {
        case .leaf:
            return true
        case let .Node(left, x, right):
            return left.all(predicate: {y in y < x}) && right.all(predicate: {y in y > x}) && left.isBST && right.isBST
        }
    }
    
    
    func all(predicate: (Element) -> Bool) -> Bool {
    
        for x in self.elements {
            
            if !predicate(x) {
                return false
            }
        }
        return true
    }
    
    /// 是否包含
    func contains(_ x: Element) -> Bool {
        
        switch self {
        case .leaf:
            return false
        case let .Node(_, y, _) where x == y:
            return true
        case let .Node(left, y, _) where x < y:
            return left.contains(x)
        case let .Node(_, y, right) where x > y:
            return right.contains(x)
        default:
            fatalError()
        }
    }
    
    mutating func insert(_ x: Element) {
        
        switch self {
        case .leaf:
            self = BinarySearchTree(value: x)
        case .Node(var left,let y,var right):
            if x < y { left.insert(x) }
            if x > y { right.insert(x) }
            self = .Node(left, y, right)
        }
    }
}
