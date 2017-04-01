//
//  DictionaryTree.swift
//  WWZFunctionSwift
//
//  Created by wwz on 2017/4/1.
//  Copyright © 2017年 tijio. All rights reserved.
//

import Foundation


struct Trie<Element: Hashable> {
    
    let isElement: Bool
    let children: [Element: Trie<Element>]
    
    init() {
        isElement = false
        children = [Element: Trie]()
    }
    
    init(isElement: Bool, children: [Element: Trie]) {
        self.isElement = isElement
        self.children = children
    }
    
    init(key: [Element]) {
        
        if let (head, tail) = key.decompose {
        
            let children = [head: Trie(key: tail)]
            self = Trie(isElement: false, children: children)
        }else {
        
            self = Trie(isElement: true, children: [:])
        }
    }
    
    func insert(key: [Element]) -> Trie<Element> {
        
        guard let (head, tail) = key.decompose else { return Trie(isElement: true, children: children) }
        
        var newChildren = children
        
        if let newTrie = children[head] {
        
            newChildren[head] = newTrie.insert(key: tail)
        }else {
            newChildren[head] = Trie(key: tail)
        }
        return Trie(isElement: isElement, children: newChildren)
        
    }
    
    var elements: [[Element]] {
    
        var result: [[Element]] = isElement ? [[]] : []
        
        for (element, trie) in children {
            
            result += trie.elements.map({ [element] + $0 })
        }
        return result
    }
    /// 给定一个由一些 Element 组成的键组，遍历一棵字典树，来逐一确定对应的键是否储存在树中
    func lookup(key: [Element]) -> Bool {
        
        guard let (head, tail) = key.decompose else { return self.isElement }
        
        guard let subtrie = self.children[head] else { return false }
        
        return subtrie.lookup(key: tail)
    }
    /// 给定一个前缀键组，使其返回一个含有所有匹配元素的子树
    func withPrefix(prefix: [Element]) -> Trie<Element>? {
        
        guard let (head, tail) = prefix.decompose else { return self }
        
        guard let remainder = self.children[head] else { return nil }
        
        return remainder.withPrefix(prefix: tail)
    }
    
    /// autocomplete
    func autocomplete(key: [Element]) -> [[Element]] {
        
        return withPrefix(prefix: key)?.elements ?? []
    }
}

extension Array {

    var decompose: (Element, [Element])? {
    
        return isEmpty ? nil : (self[startIndex], Array(self.dropFirst()))
    }
}

/// 使用递归实现 从小到大排序数组
func qsort(_ input: [Int]) -> [Int] {
    guard let (pivot, rest) = input.decompose else { return [] }
    let lesser = rest.filter { $0 < pivot }
    let greater = rest.filter { $0 >= pivot }
    return qsort(lesser) + Array([pivot]) + qsort(greater)
}


func buildStringTrie(words: [String]) -> Trie<Character> {
    
    let emptyTrie = Trie<Character>()

    return words.reduce(emptyTrie, { (tire, word) in
        tire.insert(key: Array(word.characters))
    })
}

func autocompleteString(knownWords: Trie<Character>, word: String) -> [String] {
    
    let chars = Array(word.characters)
    let completed = knownWords.autocomplete(key: chars)
    
    return completed.map( {chars in
    
        word + String(chars)
    })
}


