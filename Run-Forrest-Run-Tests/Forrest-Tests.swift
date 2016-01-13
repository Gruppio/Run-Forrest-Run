//
//  Forrest-Tests.swift
//  Run-Forrest-Run
//
//  Created by Michele Gruppioni on 12/01/16.
//  Copyright © 2016 Michele Gruppioni. All rights reserved.
//

import XCTest

class Forrest_Tests: XCTestCase {
    
    let forrest = Forrest()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSplitToArgumentsListWith1Command() {
        XCTAssertEqual(forrest.splitToArgumentsList("a"), [["a"]])
    }

    func testSplitToArgumentsListWith2Commands() {
        XCTAssertEqual(forrest.splitToArgumentsList("a|b"), [["a"], ["b"]])
    }
    
    func testSplitToArgumentsListWith3Commands() {
        XCTAssertEqual(forrest.splitToArgumentsList("a|b|c"), [["a"], ["b"], ["c"]])
    }
    
    func testSplitToArgumentsListWith1CommandWithFlag() {
        XCTAssertEqual(forrest.splitToArgumentsList("a -b"), [["a", "-b"]])
    }
    
    func testSplitToArgumentsListWith2CommandsWithFlag() {
        XCTAssertEqual(forrest.splitToArgumentsList("a -b|c -d"), [["a", "-b"], ["c", "-d"]])
    }
    
    func testSplitToArgumentsListWith3CommandsWithFlag() {
        XCTAssertEqual(forrest.splitToArgumentsList("a -b|c -d|e -f"), [["a", "-b"],["c", "-d"],["e", "-f"]])
    }
    
    func testSplitToArgumentsListWith1CommandWithFlags() {
        XCTAssertEqual(forrest.splitToArgumentsList("a -b --bb"), [["a", "-b", "--bb"]])
    }
    
    func testSplitToArgumentsListWith2CommandsWithFlags() {
        XCTAssertEqual(forrest.splitToArgumentsList("a -b --bb|c -d --dd"), [["a", "-b", "--bb"], ["c", "-d", "--dd"]])
    }
    
    func testSplitToArgumentsListWith3CommandsWithFlags() {
        XCTAssertEqual(forrest.splitToArgumentsList("a -b --bb|c -d --dd|e -f --ff"), [["a", "-b", "--bb"],["c", "-d", "--dd"],["e", "-f", "--ff"]])
    }
    
    func testSplitToArgumentsListWith1CommandAndSpaces() {
        XCTAssertEqual(forrest.splitToArgumentsList("  a "), [["a"]])
    }
    
    func testSplitToArgumentsListWith2CommandsAndSpaces() {
        XCTAssertEqual(forrest.splitToArgumentsList(" a  | b "), [["a"], ["b"]])
    }
    
    func testSplitToArgumentsListWith3CommandsAndSpaces() {
        XCTAssertEqual(forrest.splitToArgumentsList(" a | b  | c  "), [["a"], ["b"], ["c"]])
    }
    
    func testSplitToArgumentsListWith1CommandWithFlagAndSpaces() {
        XCTAssertEqual(forrest.splitToArgumentsList(" a  -b "), [["a", "-b"]])
    }
    
    func testSplitToArgumentsListWith2CommandsWithFlagAndSpaces() {
        XCTAssertEqual(forrest.splitToArgumentsList(" a -b     | c  -d "), [["a", "-b"], ["c", "-d"]])
    }
    
    func testSplitToArgumentsListWith3CommandsWithFlagAndSpaces() {
        XCTAssertEqual(forrest.splitToArgumentsList(" a -b   | c  -d | e -f "), [["a", "-b"],["c", "-d"],["e", "-f"]])
    }
    
    func testSplitToArgumentsListWithBackSlashSpace() {
        XCTAssertEqual(forrest.splitToArgumentsList("  hello world "), [["hello world"]])
    }
}
