//
//  WWZFunctionSwiftTests.swift
//  WWZFunctionSwiftTests
//
//  Created by wwz on 2017/3/30.
//  Copyright © 2017年 tijio. All rights reserved.
//

import XCTest

@testable import WWZFunctionSwift

class WWZFunctionSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
//        let numbers = [1,2,3,4,5].map { (number) -> String in
//        
//            return "\(number+3)"
//        }
//    
//        print(numbers)
//        
//        let reduceArr = [1,2,3,4,5].reduce([String]()) { (result: [String], number: Int) -> [String] in
//            
//            var arr = result
//            arr.append("\(number)")
//            return arr
//        }
//        print(reduceArr)
//        
//        let filterArr = [1,2,3,4,5].filter { (index) -> Bool in
//            
//            return index > 3
//        }
//        
//        print(filterArr)
//        
//        
//        let str = String.arbitrary()
//        
//        print(str)
        
        
        let contents = ["cat", "car", "cart", "dog"]
        let trieOfWords = buildStringTrie(words: contents)
        let str = autocompleteString(knownWords: trieOfWords, word: "car")
        
        print(str)
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
